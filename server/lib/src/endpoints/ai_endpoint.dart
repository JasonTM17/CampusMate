import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:campusmate_shared/campusmate_shared.dart' as shared;

import '../../src/ai/ai_provider_factory.dart';
import '../../src/ai/ai_provider.dart';
import '../../src/ai/chat_request_builder.dart';
import '../../src/ai/quota.dart';
import '../../src/generated/protocol.dart';

/// AI assistant endpoints (phase-08): conversation lifecycle, message history,
/// and token-by-token streaming chat backed by [AiProvider].
///
/// Authorization rule (§31): every read/write is scoped to the authenticated
/// user via `session.authenticated.userIdentifier`. A request can never read
/// or write another user's conversation — the `userId` predicate is in every
/// query, so tenant isolation holds even if a client forges an id.
class AiEndpoint extends Endpoint {
  /// Per-user daily chat gate (stage 6) — limit from `AI_DAILY_MESSAGE_QUOTA`.
  final DailyMessageQuota _quota = DailyMessageQuota();

  /// Resolves the caller's stable user id or throws if not signed in.
  ///
  /// Reads the already-authenticated identity synchronously from the session
  /// (Serverpod populates `session.authenticated` before the endpoint runs).
  String _requireUserId(Session session) {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null || userId.isEmpty) {
      throw ServerpodClientUnauthorized();
    }
    return userId;
  }

  /// Loads the user's conversations, newest first.
  Future<List<AiConversation>> listConversations(Session session) async {
    final userId = _requireUserId(session);
    return AiConversation.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
    );
  }

  /// Creates a new empty conversation owned by the caller.
  Future<AiConversation> createConversation(
    Session session, {
    required String title,
  }) async {
    final userId = _requireUserId(session);
    final now = DateTime.now();
    final conversation = AiConversation(
      title: title,
      userId: userId,
      createdAt: now,
      updatedAt: now,
    );
    return AiConversation.db.insertRow(session, conversation);
  }

  /// Deletes one of the caller's conversations (messages cascade).
  Future<void> deleteConversation(
    Session session, {
    required int conversationId,
  }) async {
    final userId = _requireUserId(session);
    final deleted = await AiConversation.db.deleteWhere(
      session,
      where: (t) => t.id.equals(conversationId) & t.userId.equals(userId),
    );
    if (deleted.isEmpty) {
      // Either it does not exist or it belongs to someone else — same result.
      throw ServerpodClientNotFound();
    }
  }

  /// Returns the caller's messages for a conversation, oldest first.
  Future<List<AiMessage>> getMessages(
    Session session, {
    required int conversationId,
  }) async {
    final userId = _requireUserId(session);
    // Ownership check: the conversation must belong to the caller.
    final owned = await AiConversation.db.count(
      session,
      where: (t) => t.id.equals(conversationId) & t.userId.equals(userId),
    );
    if (owned == 0) throw ServerpodClientNotFound();

    return AiMessage.db.find(
      session,
      where: (t) => t.conversationId.equals(conversationId),
      orderBy: (t) => t.createdAt,
    );
  }

  /// Streams an assistant reply to [userMessage] within [conversationId].
  ///
  /// The user message is persisted first; the assistant reply is persisted
  /// (with any citations) once the stream completes. Each emitted String is
  /// one streaming chunk the client appends to the live bubble. The method
  /// return type is `Stream<String>` (not `Future<Stream>`) so Serverpod keeps
  /// the streaming session open. Implemented as an `async*` generator so the
  /// method body can `await` persistence while still returning a
  /// `Stream<String>`.
  Stream<String> sendMessage(
    Session session, {
    required int conversationId,
    required String userMessage,
  }) async* {
    final userId = _requireUserId(session);

    // Ownership check — before the quota so foreign ids never consume quota.
    final owned = await AiConversation.db.count(
      session,
      where: (t) => t.id.equals(conversationId) & t.userId.equals(userId),
    );
    if (owned == 0) throw ServerpodClientNotFound();

    final provider = createAiProvider();

    // Daily quota gate: runs BEFORE context building and the provider call
    // (plan C6) — an exhausted user never reaches the AI.
    await _quota.consume(session, userId);

    // Load transcript and persist the user turn.
    final history = await AiMessage.db.find(
      session,
      where: (t) => t.conversationId.equals(conversationId),
      orderBy: (t) => t.createdAt,
    );
    await AiMessage.db.insertRow(
      session,
      AiMessage(
        conversationId: conversationId,
        role: 'user',
        content: userMessage,
        createdAt: DateTime.now(),
      ),
    );

    final request = shared.AiRequest(
      conversationId: conversationId.toString(),
      messages: assembleChatMessages(
        history: [for (final m in history) (m.role, m.content)],
        userMessage: userMessage,
      ),
      studentContext: null, // wired by the context builder in phase-09
    );

    final collected = StringBuffer();
    await for (final chunk in provider.streamChat(request)) {
      collected.write(chunk.text);
      if (chunk.isDone) {
        final citations = chunk.citations.isEmpty
            ? null
            : jsonEncode(
                chunk.citations
                    .map(
                      (c) => {
                        'title': c.title,
                        'documentId': c.documentId,
                        'bookId': c.bookId,
                        'chapter': c.chapter,
                        'page': c.page,
                      },
                    )
                    .toList(),
              );
        // Persist the completed assistant turn + bump conversation timestamp.
        await AiMessage.db.insertRow(
          session,
          AiMessage(
            conversationId: conversationId,
            role: 'assistant',
            content: collected.toString(),
            citations: citations,
            createdAt: DateTime.now(),
          ),
        );
        final existing = await AiConversation.db.findById(
          session,
          conversationId,
        );
        if (existing != null) {
          existing.updatedAt = DateTime.now();
          await AiConversation.db.update(session, [existing]);
        }
      }
      yield chunk.text;
    }
  }
}
