import 'package:campusmate/features/chat/domain/chat_message.dart';

const Object _unsetError = Object();
const Object _unsetConversationId = Object();

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
    Object? conversationId = _unsetConversationId,
    List<ChatMessage>? messages,
    Object? error = _unsetError,
  }) {
    return ChatState(
      status: status ?? this.status,
      conversationId: identical(conversationId, _unsetConversationId)
          ? this.conversationId
          : conversationId as int?,
      messages: messages ?? this.messages,
      error: identical(error, _unsetError) ? this.error : error as String?,
    );
  }
}
