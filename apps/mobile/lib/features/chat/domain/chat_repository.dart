import 'package:campusmate_client/campusmate_client.dart';
import 'package:campusmate/features/chat/domain/chat_message.dart';

/// Result of listing conversations for the conversation picker.
class ConversationSummary {
  const ConversationSummary({
    required this.id,
    required this.title,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final DateTime updatedAt;
}

/// Chat transport abstraction so the controller is unit-testable without a
/// live Serverpod client (same seam as AuthRepository).
abstract interface class AiRepository {
  Future<List<ConversationSummary>> listConversations();
  Future<ConversationSummary> createConversation({required String title});
  Future<void> deleteConversation(int conversationId);
  Future<List<ChatMessage>> getMessages(int conversationId);
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
    int? bookId,
    String? selectedText,
  });

  Future<StudentAiPreference> getPreferences();
  Future<StudentAiPreference> updatePreferences({
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  });

  Future<List<AiUserMemory>> getMemories({bool activeOnly = false});
  Future<AiUserMemory> addMemory({required String content, String? source});
  Future<AiUserMemory> toggleMemory({
    required int memoryId,
    required bool disabled,
  });
  Future<void> deleteMemory({required int memoryId});

  Future<StudySuggestion?> getStudySuggestion();
}
