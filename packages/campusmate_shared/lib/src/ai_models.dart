/// Shared, platform-neutral models exchanged between the CampusMate server
/// and its clients. Kept dependency-free so it can be imported from the
/// Dart server, the Serverpod protocol, and tooling alike.
library;

/// A single user request to the AI assistant.
///
/// [conversationId] ties the request to a persisted conversation;
/// [messages] is the ordered transcript the provider conditions on;
/// [studentContext] carries the personalized, authorization-scoped context
/// assembled by the server (never the whole student record).
class AiRequest {
  const AiRequest({
    required this.conversationId,
    required this.messages,
    this.studentContext,
  });

  final String conversationId;
  final List<AiMessage> messages;
  final String? studentContext;
}

/// One message in a conversation transcript.
class AiMessage {
  const AiMessage({required this.role, required this.content});

  /// "user" or "assistant".
  final String role;
  final String content;
}

/// A streaming chunk of an assistant reply.
///
/// [text] is the incremental delta; [isDone] marks the final chunk;
/// [citations] attaches verifiable source references (RAG) for the spans
/// emitted so far — shaped once up front (Kongming C6) so the citation
/// column never needs a migration later.
class AiStreamChunk {
  const AiStreamChunk({
    required this.text,
    this.isDone = false,
    this.citations = const [],
  });

  final String text;
  final bool isDone;
  final List<AiCitation> citations;
}

/// A verifiable source reference attached to a streamed reply span.
class AiCitation {
  const AiCitation({
    required this.title,
    this.documentId,
    this.bookId,
    this.chapter,
    this.page,
  });

  final String title;
  final String? documentId;
  final String? bookId;
  final String? chapter;
  final int? page;
}
