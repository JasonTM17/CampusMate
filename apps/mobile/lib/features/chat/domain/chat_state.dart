import 'package:campusmate/features/chat/domain/chat_message.dart';

/// UI-layer state for the chat screen.
enum ChatStatus { idle, loadingHistory, streaming, error }

class ChatState {
  const ChatState({
    this.status = ChatStatus.idle,
    this.conversationId,
    this.messages = const [],
    this.error,
  });

  final ChatStatus status;
  final int? conversationId;
  final List<ChatMessage> messages;
  final String? error;

  ChatState copyWith({
    ChatStatus? status,
    int? conversationId,
    List<ChatMessage>? messages,
    String? error,
  }) {
    return ChatState(
      status: status ?? this.status,
      conversationId: conversationId ?? this.conversationId,
      messages: messages ?? this.messages,
      error: error ?? this.error,
    );
  }
}
