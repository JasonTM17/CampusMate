/// One message as rendered in the chat UI (decoupled from the generated
/// protocol model so the UI never depends on DB-row types).
enum MessageRole { user, assistant }

enum MessageStatus { sending, streaming, sent, error }

class ChatMessage {
  const ChatMessage({
    required this.role,
    required this.content,
    this.status = MessageStatus.sent,
    this.id,
  });

  final MessageRole role;
  final String content;
  final MessageStatus status;

  /// Stable key for list diffing (message id when known).
  final String? id;

  ChatMessage copyWith({
    MessageRole? role,
    String? content,
    MessageStatus? status,
    String? id,
  }) {
    return ChatMessage(
      role: role ?? this.role,
      content: content ?? this.content,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  bool get isUser => role == MessageRole.user;
}
