import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:campusmate_server/src/rag/citation/citation_verifier.dart';
import 'package:campusmate_server/src/rag/retrieval/rag_retrieval_service.dart';
import 'package:test/test.dart';

void main() {
  group('CitationVerifier', () {
    const verifier = CitationVerifier();

    final retrieved = [
      const RetrievedChunk(
        chunkId: 101,
        documentId: 1,
        bookId: 10,
        title: 'Giáo trình Cấu trúc Dữ liệu',
        chapter: 'Chương 2',
        page: 45,
        content: 'Nội dung về danh sách liên kết...',
        distance: 0.12,
      ),
      const RetrievedChunk(
        chunkId: 102,
        documentId: 2,
        title: 'Sổ tay Sinh viên 2026',
        chapter: 'Quy chế thi',
        page: 12,
        content: 'Nội dung về điều kiện dự thi kết thúc học phần...',
        distance: 0.15,
      ),
    ];

    test('accepts candidate citations matching genuine retrieved chunks', () {
      final candidates = [
        RagCitation(
          documentId: 1,
          chunkId: 101,
          title: 'Giáo trình Cấu trúc Dữ liệu',
          chapter: 'Chương 2',
          page: 45,
        ),
      ];

      final verified = verifier.verify(
        candidateCitations: candidates,
        retrievedChunks: retrieved,
      );

      expect(verified.length, 1);
      expect(verified.first.title, 'Giáo trình Cấu trúc Dữ liệu');
      expect(verified.first.documentId, 1);
      expect(verified.first.chapter, 'Chương 2');
      expect(verified.first.page, 45);
    });

    test(
      'strictly drops fabricated citations pointing to non-retrieved documents',
      () {
        final candidates = [
          RagCitation(
            documentId: 999, // Fake document ID
            chunkId: 9999,
            title: 'Tài liệu bịa đặt về đề thi bí mật',
            chapter: 'Chương 99',
            page: 999,
          ),
        ];

        final verified = verifier.verify(
          candidateCitations: candidates,
          retrievedChunks: retrieved,
        );

        expect(verified, isEmpty);
      },
    );

    test('extracts and verifies [Nguồn 1] from assistant response text', () {
      const response =
          'Theo quy định tại [Nguồn 2], sinh viên phải tham gia tối thiểu 80% số tiết học.';

      final verified = verifier.extractAndVerify(
        responseText: response,
        retrievedChunks: retrieved,
      );

      expect(verified.length, 1);
      expect(verified.first.documentId, 2);
      expect(verified.first.title, 'Sổ tay Sinh viên 2026');
      expect(verified.first.chapter, 'Quy chế thi');
      expect(verified.first.page, 12);
    });

    test('encodes and decodes citations JSON roundtrip cleanly', () {
      final citations = [
        RagCitation(
          documentId: 1,
          chunkId: 101,
          bookId: 10,
          title: 'Giáo trình Cấu trúc Dữ liệu',
          chapter: 'Chương 2',
          page: 45,
        ),
      ];

      final jsonString = CitationVerifier.encodeCitations(citations);
      expect(jsonString, isNotNull);

      final decoded = CitationVerifier.decodeCitations(jsonString);
      expect(decoded.length, 1);
      expect(decoded.first.title, 'Giáo trình Cấu trúc Dữ liệu');
      expect(decoded.first.documentId, 1);
      expect(decoded.first.bookId, 10);
    });
  });
}
