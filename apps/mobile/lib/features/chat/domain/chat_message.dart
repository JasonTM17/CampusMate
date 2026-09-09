/// One message as rendered in the chat UI (decoupled from the generated
/// protocol model so the UI never depends on DB-row types).
enum MessageRole { user, assistant }

enum MessageStatus { sending, streaming, sent, error }

class ChatCitation {
  const ChatCitation({
    required this.title,
    this.documentId,
    this.bookId,
    this.chapter,
    this.page,
    this.quote,
  });

  final String title;
  final int? documentId;
  final int? bookId;
  final String? chapter;
  final int? page;
  final String? quote;

  String get displayText {
    final buffer = StringBuffer(title);
    if (chapter != null && chapter!.trim().isNotEmpty) {
      buffer.write(' - $chapter');
    }
    if (page != null) {
      buffer.write(', tr. $page');
    }
    return buffer.toString();
  }

  factory ChatCitation.fromJson(Map<String, dynamic> json) {
    return ChatCitation(
      title: json['title'] as String? ?? 'Tài liệu tham khảo',
      documentId: (json['documentId'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      chapter: json['chapter'] as String?,
      page: (json['page'] as num?)?.toInt(),
      quote: json['quote'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    if (documentId != null) 'documentId': documentId,
    if (bookId != null) 'bookId': bookId,
    if (chapter != null) 'chapter': chapter,
    if (page != null) 'page': page,
    if (quote != null) 'quote': quote,
  };
}

class ChatMessage {
  const ChatMessage({
    required this.role,
    required this.content,
    this.status = MessageStatus.sent,
    this.citations = const [],
    this.id,
  });

  final MessageRole role;
  final String content;
  final MessageStatus status;
  final List<ChatCitation> citations;

  /// Stable key for list diffing (message id when known).
  final String? id;

  ChatMessage copyWith({
    MessageRole? role,
    String? content,
    MessageStatus? status,
    List<ChatCitation>? citations,
    String? id,
  }) {
    return ChatMessage(
      role: role ?? this.role,
      content: content ?? this.content,
      status: status ?? this.status,
      citations: citations ?? this.citations,
      id: id ?? this.id,
    );
  }

  bool get isUser => role == MessageRole.user;
}
