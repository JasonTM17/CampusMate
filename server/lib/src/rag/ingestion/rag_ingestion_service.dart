import 'package:serverpod/serverpod.dart';

import '../../ai/ai_provider.dart';
import '../../generated/protocol.dart';
import 'document_chunker.dart';

/// Ingests documents, splits them into semantically bounded chunks,
/// embeds each chunk with [AiProvider.createEmbedding], and persists them.
class RagIngestionService {
  RagIngestionService({
    required this.aiProvider,
    DocumentChunker? chunker,
  }) : chunker = chunker ?? const DocumentChunker();

  final AiProvider aiProvider;
  final DocumentChunker chunker;

  /// Ingests or re-ingests a document with its text content.
  /// Re-ingestion atomically replaces all chunks for this document.
  Future<KnowledgeDocument> ingestDocument(
    Session session, {
    int? documentId,
    required String title,
    required String sourceType,
    required String content,
    String accessLevel = 'public',
    int? bookId,
    int? requiredCourseId,
  }) async {
    final now = DateTime.now().toUtc();
    KnowledgeDocument doc;

    if (documentId != null) {
      final existing = await KnowledgeDocument.db.findById(session, documentId);
      if (existing != null) {
        doc = await KnowledgeDocument.db.updateRow(
          session,
          existing.copyWith(
            title: title,
            sourceType: sourceType,
            accessLevel: accessLevel,
            bookId: bookId,
            requiredCourseId: requiredCourseId,
            updatedAt: now,
          ),
        );
        // Clear previous chunks for re-ingestion
        await KnowledgeChunk.db.deleteWhere(
          session,
          where: (t) => t.documentId.equals(doc.id!),
        );
      } else {
        doc = await KnowledgeDocument.db.insertRow(
          session,
          KnowledgeDocument(
            id: documentId,
            title: title,
            sourceType: sourceType,
            bookId: bookId,
            accessLevel: accessLevel,
            requiredCourseId: requiredCourseId,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    } else {
      doc = await KnowledgeDocument.db.insertRow(
        session,
        KnowledgeDocument(
          title: title,
          sourceType: sourceType,
          bookId: bookId,
          accessLevel: accessLevel,
          requiredCourseId: requiredCourseId,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    final drafts = chunker.chunk(
      fullText: content,
      defaultTitle: title,
    );

    if (drafts.isNotEmpty) {
      final chunksToInsert = <KnowledgeChunk>[];
      for (final draft in drafts) {
        final embeddingList = await aiProvider.createEmbedding(draft.content);
        chunksToInsert.add(
          KnowledgeChunk(
            documentId: doc.id!,
            bookId: bookId,
            title: draft.title,
            chapter: draft.chapter,
            page: draft.page,
            content: draft.content,
            embedding: Vector(embeddingList),
            createdAt: now,
          ),
        );
      }

      await KnowledgeChunk.db.insert(session, chunksToInsert);
    }

    return doc;
  }
}
