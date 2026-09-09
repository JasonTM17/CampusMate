import 'dart:convert';

import 'package:campusmate_shared/campusmate_shared.dart' as shared;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../../src/ai/ai_provider_factory.dart';
import '../../src/ai/chat_request_builder.dart';
import '../../src/ai/context/student_context_builder.dart';
import '../../src/ai/memory/ai_memory_service.dart';
import '../../src/ai/memory/ai_preference_service.dart';
import '../../src/ai/quota.dart';
import '../../src/ai/study_suggestion_service.dart';
import '../../src/auth/campusmate_auth.dart';
import '../../src/generated/protocol.dart';

/// AI assistant endpoints (phase-08 & phase-09): conversation lifecycle,
/// message history, streaming chat with personalized student context,
/// AI user memories, student AI preferences, and study suggestions.
///
/// Authorization rule (§31): every read/write is scoped to the authenticated
/// user via `session.authenticated.userIdentifier`. A request can never read
/// or write another user's conversation — the `userId` predicate is in every
/// query, so tenant isolation holds even if a client forges an id.
class AiEndpoint extends Endpoint {
  /// Per-user daily chat gate (stage 6) — limit from `AI_DAILY_MESSAGE_QUOTA`.
  final DailyMessageQuota _quota = DailyMessageQuota();

  final StudentContextBuilder _contextBuilder = StudentContextBuilder();
  final AiPreferenceService _preferenceService = AiPreferenceService();
  final AiMemoryService _memoryService = AiMemoryService();
  final StudySuggestionService _suggestionService = StudySuggestionService();

  /// Resolves the caller's stable user id or throws if not signed in.
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
  /// In Phase 09, builds personalized context via [StudentContextBuilder]
  /// incorporating academic schedules, upcoming exams, active loans, and
  /// user memories, while obeying least-data budgeting and privacy controls.
  Stream<String> sendMessage(
    Session session, {
    required int conversationId,
    required String userMessage,
    int? bookId,
    String? selectedText,
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

    // Build personalized student context (phase-09)
    final studentContext = await _contextBuilder.buildContext(
      session,
      bookId: bookId,
      selectedText: selectedText,
    );

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
        studentContext: studentContext,
      ),
      studentContext: studentContext,
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

  /// Gets the caller's AI preferences (creates default if not set).
  Future<StudentAiPreference> getPreferences(Session session) async {
    final userId = CampusMateAuth.requireUserId(session);
    return _preferenceService.getPreferences(session, userId: userId);
  }

  /// Updates the caller's AI preferences.
  Future<StudentAiPreference> updatePreferences(
    Session session, {
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    return _preferenceService.updatePreferences(
      session,
      userId: userId,
      explanationStyle: explanationStyle,
      personalizationEnabled: personalizationEnabled,
      memoryEnabled: memoryEnabled,
    );
  }

  /// Lists the caller's AI memories.
  Future<List<AiUserMemory>> getMemories(
    Session session, {
    bool activeOnly = false,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    return _memoryService.listMemories(
      session,
      userId: userId,
      activeOnly: activeOnly,
    );
  }

  /// Adds a new personal memory for the caller.
  Future<AiUserMemory> addMemory(
    Session session, {
    required String content,
    String? source,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    return _memoryService.addMemory(
      session,
      userId: userId,
      content: content,
      source: source ?? 'user',
    );
  }

  /// Enables or disables a specific memory.
  Future<AiUserMemory> toggleMemory(
    Session session, {
    required int memoryId,
    required bool disabled,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    return _memoryService.toggleMemory(
      session,
      userId: userId,
      memoryId: memoryId,
      disabled: disabled,
    );
  }

  /// Permanently deletes a specific memory.
  Future<void> deleteMemory(
    Session session, {
    required int memoryId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    await _memoryService.deleteMemory(
      session,
      userId: userId,
      memoryId: memoryId,
    );
  }

  /// Returns a personalized study suggestion for the dashboard card.
  Future<StudySuggestion?> getStudySuggestion(Session session) async {
    return _suggestionService.getSuggestion(session);
  }
}
