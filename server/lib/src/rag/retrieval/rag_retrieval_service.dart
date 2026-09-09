import 'package:serverpod/serverpod.dart';

import '../../ai/ai_provider.dart';

/// Represents a single chunk retrieved from the vector store with similarity score.
class RetrievedChunk {
  const RetrievedChunk({
    required this.chunkId,
    required this.documentId,
    required this.title,
    required this.content,
    required this.distance,
    this.bookId,
    this.chapter,
    this.page,
  });

  final int chunkId;
  final int documentId;
  final String title;
  final String content;
  final double distance;
  final int? bookId;
  final String? chapter;
  final int? page;

  @override
  String toString() =>
      'RetrievedChunk(id: $chunkId, docId: $documentId, title: $title, dist: $distance)';
}

/// Authorized similarity retrieval service for RAG (Kongming C7).
///
/// Authorization predicate is executed in the SAME SQL query as the vector
/// similarity search before any data leaves PostgreSQL. Restricted or
/// un-enrolled chunks are NEVER retrieved and never leaked to Dart or LLM.
class RagRetrievalService {
  RagRetrievalService({required this.aiProvider});

  final AiProvider aiProvider;

  /// Retrieves relevant chunks authorized for [userId].
  ///
  /// If [userId] is null or empty, only 'public' accessLevel documents are queried.
  /// If [bookId] is provided, retrieval scopes to that specific book.
  Future<List<RetrievedChunk>> retrieve({
    required Session session,
    required String query,
    String? userId,
    int? bookId,
    int limit = 4,
    double maxDistance = 2.0,
  }) async {
    final queryEmbedding = await aiProvider.createEmbedding(query);
    final vectorLiteral = '[${queryEmbedding.join(',')}]';
    final cappedLimit = limit.clamp(1, 10);

    final bool hasUser = userId != null && userId.trim().isNotEmpty;
    String? normalizedUserId;
    if (hasUser) {
      try {
        normalizedUserId = UuidValue.withValidation(userId.trim()).uuid;
      } on FormatException {
        final hex = userId
            .trim()
            .hashCode
            .abs()
            .toRadixString(16)
            .padLeft(12, '0')
            .substring(0, 12);
        normalizedUserId = '00000000-0000-4000-8000-$hex';
      }
    }
    final String sql;
    final List<Object?> params;

    if (!hasUser) {
      if (bookId != null) {
        sql = '''
          SELECT
            c."id",
            c."documentId",
            c."bookId",
            c."title",
            c."chapter",
            c."page",
            c."content",
            (c."embedding" <=> \$1::vector) AS "distance"
          FROM "knowledge_chunks" c
          JOIN "knowledge_documents" d ON c."documentId" = d."id"
          WHERE d."accessLevel" = 'public'
            AND (c."bookId" = \$2 OR d."bookId" = \$2)
          ORDER BY c."embedding" <=> \$1::vector ASC
          LIMIT \$3;
        ''';
        params = [vectorLiteral, bookId, cappedLimit];
      } else {
        sql = '''
          SELECT
            c."id",
            c."documentId",
            c."bookId",
            c."title",
            c."chapter",
            c."page",
            c."content",
            (c."embedding" <=> \$1::vector) AS "distance"
          FROM "knowledge_chunks" c
          JOIN "knowledge_documents" d ON c."documentId" = d."id"
          WHERE d."accessLevel" = 'public'
          ORDER BY c."embedding" <=> \$1::vector ASC
          LIMIT \$2;
        ''';
        params = [vectorLiteral, cappedLimit];
      }
    } else {
      if (bookId != null) {
        sql = '''
          SELECT
            c."id",
            c."documentId",
            c."bookId",
            c."title",
            c."chapter",
            c."page",
            c."content",
            (c."embedding" <=> \$1::vector) AS "distance"
          FROM "knowledge_chunks" c
          JOIN "knowledge_documents" d ON c."documentId" = d."id"
          WHERE (
            d."accessLevel" = 'public'
            OR d."accessLevel" = 'authenticated'
            OR (d."accessLevel" = 'course_enrolled' AND d."requiredCourseId" IN (
                SELECT co."courseId"
                FROM "enrollments" e
                JOIN "student_profiles" sp ON e."studentProfileId" = sp."id"
                JOIN "course_offerings" co ON e."offeringId" = co."id"
                WHERE sp."authUserId" = \$2::uuid AND e."status" = 'enrolled'
            ))
            OR (d."accessLevel" = 'book_borrowed' AND d."bookId" IN (
                SELECT bl."bookId"
                FROM "book_loans" bl
                WHERE bl."userId" = \$2::uuid AND bl."status" IN ('borrowed', 'overdue')
            ))
          )
          AND (c."bookId" = \$3 OR d."bookId" = \$3)
          ORDER BY c."embedding" <=> \$1::vector ASC
          LIMIT \$4;
        ''';
        params = [vectorLiteral, normalizedUserId, bookId, cappedLimit];
      } else {
        sql = '''
          SELECT
            c."id",
            c."documentId",
            c."bookId",
            c."title",
            c."chapter",
            c."page",
            c."content",
            (c."embedding" <=> \$1::vector) AS "distance"
          FROM "knowledge_chunks" c
          JOIN "knowledge_documents" d ON c."documentId" = d."id"
          WHERE (
            d."accessLevel" = 'public'
            OR d."accessLevel" = 'authenticated'
            OR (d."accessLevel" = 'course_enrolled' AND d."requiredCourseId" IN (
                SELECT co."courseId"
                FROM "enrollments" e
                JOIN "student_profiles" sp ON e."studentProfileId" = sp."id"
                JOIN "course_offerings" co ON e."offeringId" = co."id"
                WHERE sp."authUserId" = \$2::uuid AND e."status" = 'enrolled'
            ))
            OR (d."accessLevel" = 'book_borrowed' AND d."bookId" IN (
                SELECT bl."bookId"
                FROM "book_loans" bl
                WHERE bl."userId" = \$2::uuid AND bl."status" IN ('borrowed', 'overdue')
            ))
          )
          ORDER BY c."embedding" <=> \$1::vector ASC
          LIMIT \$3;
        ''';
        params = [vectorLiteral, normalizedUserId, cappedLimit];
      }
    }

    final queryResult = await session.db.unsafeQuery(
      sql,
      parameters: QueryParameters.positional(params),
    );

    final chunks = <RetrievedChunk>[];
    for (final row in queryResult) {
      final map = row.toColumnMap();
      final distance = (map['distance'] as num?)?.toDouble() ?? 1.0;
      if (distance > maxDistance) continue;

      chunks.add(
        RetrievedChunk(
          chunkId: (map['id'] as num).toInt(),
          documentId: (map['documentId'] as num).toInt(),
          bookId: (map['bookId'] as num?)?.toInt(),
          title: map['title'] as String? ?? '',
          chapter: map['chapter'] as String?,
          page: (map['page'] as num?)?.toInt(),
          content: map['content'] as String? ?? '',
          distance: distance,
        ),
      );
    }

    return chunks;
  }
}
