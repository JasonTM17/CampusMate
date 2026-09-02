import 'package:campusmate_client/campusmate_client.dart';

import '../domain/chat_message.dart';
import '../domain/chat_repository.dart';

/// [AiRepository] backed by the Serverpod-generated client.
class ServerpodAiRepository implements AiRepository {
  ServerpodAiRepository(this._client);

  final Client _client;

  @override
  Future<List<ConversationSummary>> listConversations() async {
    final rows = await _client.ai.listConversations();
    return [
      for (final r in rows)
        ConversationSummary(id: r.id!, title: r.title, updatedAt: r.updatedAt),
    ];
  }

  @override
  Future<ConversationSummary> createConversation({
    required String title,
  }) async {
    final c = await _client.ai.createConversation(title: title);
    return ConversationSummary(
      id: c.id!,
      title: c.title,
      updatedAt: c.updatedAt,
    );
  }

  @override
  Future<void> deleteConversation(int conversationId) =>
      _client.ai.deleteConversation(conversationId: conversationId);

  @override
  Future<List<ChatMessage>> getMessages(int conversationId) async {
    final rows = await _client.ai.getMessages(conversationId: conversationId);
    return [
      for (final r in rows)
        ChatMessage(
          id: 'msg-${r.id}',
          role: r.role == 'assistant'
              ? MessageRole.assistant
              : MessageRole.user,
          content: r.content,
          status: MessageStatus.sent,
        ),
    ];
  }

  @override
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
  }) => _client.ai.sendMessage(
    conversationId: conversationId,
    userMessage: content,
  );
}
