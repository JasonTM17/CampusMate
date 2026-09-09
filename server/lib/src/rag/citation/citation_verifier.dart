import 'dart:convert';

import '../../generated/protocol.dart';
import '../retrieval/rag_retrieval_service.dart';

/// Verifies citations emitted by LLM against the set of genuine retrieved chunks (Kongming C6).
///
/// Any hallucinated citation pointing to an un-retrieved document, book,
/// chapter, or page is dropped so the assistant never surfaces false citations.
class CitationVerifier {
  const CitationVerifier();

  /// Verifies a list of candidate [RagCitation] objects against [retrievedChunks].
  /// Returns only citations that correspond to authentic retrieved chunks.
  List<RagCitation> verify({
    required List<RagCitation> candidateCitations,
    required List<RetrievedChunk> retrievedChunks,
  }) {
    if (candidateCitations.isEmpty || retrievedChunks.isEmpty) {
      return const [];
    }

    final valid = <RagCitation>[];
    final seen = <String>{};

    for (final candidate in candidateCitations) {
      // Find matching retrieved chunk
      final match = retrievedChunks.where((c) {
        if (candidate.chunkId != null && c.chunkId == candidate.chunkId) {
          return true;
        }
        if (c.documentId == candidate.documentId) {
          return true;
        }
        // Fallback match on title and bookId if documentId wasn't passed by LLM
        if (candidate.bookId != null && c.bookId == candidate.bookId) {
          return true;
        }
        if (_normalize(c.title) == _normalize(candidate.title)) {
          return true;
        }
        return false;
      }).firstOrNull;

      if (match != null) {
        final key = '${match.documentId}-${match.chapter}-${match.page}';
        if (seen.add(key)) {
          valid.add(
            RagCitation(
              documentId: match.documentId,
              chunkId: match.chunkId,
              bookId: match.bookId,
              title: match.title,
              chapter: match.chapter ?? candidate.chapter,
              page: match.page ?? candidate.page,
              quote: candidate.quote,
            ),
          );
        }
      }
    }

    return valid;
  }

  /// Parses explicit citations like `[Nguồn 1]`, `[Nguồn 2]` or `[Title - Chapter, tr. X]`
  /// from the LLM response text and verifies them against [retrievedChunks].
  List<RagCitation> extractAndVerify({
    required String responseText,
    required List<RetrievedChunk> retrievedChunks,
  }) {
    if (responseText.isEmpty || retrievedChunks.isEmpty) {
      return const [];
    }

    final candidates = <RagCitation>[];

    // Pattern 1: [Nguồn 1], [Nguồn 2] indexed against retrieved chunks
    final sourceRefPattern = RegExp(
      r'\[(?:Nguồn|Source)\s*(\d+)\]',
      caseSensitive: false,
    );
    for (final match in sourceRefPattern.allMatches(responseText)) {
      final indexStr = match.group(1);
      if (indexStr != null) {
        final index = int.tryParse(indexStr);
        if (index != null && index >= 1 && index <= retrievedChunks.length) {
          final chunk = retrievedChunks[index - 1];
          candidates.add(
            RagCitation(
              documentId: chunk.documentId,
              chunkId: chunk.chunkId,
              bookId: chunk.bookId,
              title: chunk.title,
              chapter: chunk.chapter,
              page: chunk.page,
            ),
          );
        }
      }
    }

    // Pattern 2: [Title - Chapter, tr. Page]
    final citationPattern = RegExp(
      r'\[([^\]\-]+?)(?:\s*-\s*([^,\n\]]+?))?(?:,\s*(?:tr\.|trang|p\.)\s*(\d+))?\]',
    );
    for (final match in citationPattern.allMatches(responseText)) {
      final title = match.group(1)?.trim();
      final chapter = match.group(2)?.trim();
      final pageStr = match.group(3)?.trim();
      final page = pageStr != null ? int.tryParse(pageStr) : null;

      if (title != null &&
          title.isNotEmpty &&
          !title.toLowerCase().startsWith('nguồn')) {
        candidates.add(
          RagCitation(
            documentId: 0,
            title: title,
            chapter: chapter,
            page: page,
          ),
        );
      }
    }

    return verify(
      candidateCitations: candidates,
      retrievedChunks: retrievedChunks,
    );
  }

  /// Encodes verified citations into a JSON string suitable for `AiMessage.citations`.
  static String? encodeCitations(List<RagCitation> citations) {
    if (citations.isEmpty) return null;
    return jsonEncode(citations.map((c) => c.toJson()).toList());
  }

  /// Decodes citations from a JSON string.
  static List<RagCitation> decodeCitations(String? rawJson) {
    if (rawJson == null || rawJson.trim().isEmpty) return const [];
    try {
      final list = jsonDecode(rawJson) as List<dynamic>;
      return list
          .whereType<Map<String, dynamic>>()
          .map((m) => RagCitation.fromJson(m))
          .toList();
    } catch (_) {
      return const [];
    }
  }

  static String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
}
