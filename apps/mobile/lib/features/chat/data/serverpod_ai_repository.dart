import 'dart:convert';

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
          citations: _decodeCitations(r.citations),
          status: MessageStatus.sent,
        ),
    ];
  }

  static List<ChatCitation> _decodeCitations(String? rawJson) {
    if (rawJson == null || rawJson.trim().isEmpty) return const [];
    try {
      final list = jsonDecode(rawJson) as List<dynamic>;
      return [
        for (final item in list)
          if (item is Map<String, dynamic>) ChatCitation.fromJson(item),
      ];
    } catch (_) {
      return const [];
    }
  }

  @override
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
    int? bookId,
    String? selectedText,
  }) => _client.ai.sendMessage(
    conversationId: conversationId,
    userMessage: content,
    bookId: bookId,
    selectedText: selectedText,
  );

  @override
  Future<StudentAiPreference> getPreferences() => _client.ai.getPreferences();

  @override
  Future<StudentAiPreference> updatePreferences({
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) => _client.ai.updatePreferences(
    explanationStyle: explanationStyle,
    personalizationEnabled: personalizationEnabled,
    memoryEnabled: memoryEnabled,
  );

  @override
  Future<List<AiUserMemory>> getMemories({bool activeOnly = false}) =>
      _client.ai.getMemories(activeOnly: activeOnly);

  @override
  Future<AiUserMemory> addMemory({required String content, String? source}) =>
      _client.ai.addMemory(content: content, source: source);

  @override
  Future<AiUserMemory> toggleMemory({
    required int memoryId,
    required bool disabled,
  }) => _client.ai.toggleMemory(memoryId: memoryId, disabled: disabled);

  @override
  Future<void> deleteMemory({required int memoryId}) =>
      _client.ai.deleteMemory(memoryId: memoryId);

  @override
  Future<StudySuggestion?> getStudySuggestion() =>
      _client.ai.getStudySuggestion();
}
