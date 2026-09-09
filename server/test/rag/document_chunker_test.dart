import 'package:campusmate_server/src/rag/ingestion/document_chunker.dart';
import 'package:test/test.dart';

void main() {
  group('DocumentChunker', () {
    const chunker = DocumentChunker(
      targetChunkSize: 100,
      maxChunkSize: 200,
      chunkOverlap: 20,
    );

    test('returns empty list for empty or whitespace text', () {
      expect(chunker.chunk(fullText: '', defaultTitle: 'Test'), isEmpty);
      expect(
        chunker.chunk(fullText: '   \n  \n  ', defaultTitle: 'Test'),
        isEmpty,
      );
    });

    test('chunks text preserving paragraphs and boundaries', () {
      final text = '''
Đoạn văn thứ nhất nói về cấu trúc dữ liệu mảng. Mảng có kích thước cố định và truy xuất phần tử theo chỉ số với độ phức tạp O(1).

Đoạn văn thứ hai nói về danh sách liên kết. Danh sách liên kết cấp phát động và chèn phần tử ở đầu với độ phức tạp O(1).
''';

      final chunks = chunker.chunk(
        fullText: text,
        defaultTitle: 'Cấu trúc dữ liệu',
      );

      expect(chunks, isNotEmpty);
      expect(chunks.first.title, 'Cấu trúc dữ liệu');
      expect(chunks.first.content, contains('cấu trúc dữ liệu mảng'));
    });

    test('detects chapter headings and page markers', () {
      final text = '''
Chương 1: Giới thiệu giải thuật
[Trang 5]
Thuật toán là một tập hợp hữu hạn các chỉ thị từng bước để giải quyết một bài toán.

Chương 2: Tìm kiếm nhị phân
[Trang 18]
Thuật toán tìm kiếm nhị phân yêu cầu dãy đầu vào đã được sắp xếp trước.
''';

      final chunks = chunker.chunk(
        fullText: text,
        defaultTitle: 'Giải thuật học',
      );

      expect(chunks.length, greaterThanOrEqualTo(2));
      final ch1 = chunks.firstWhere(
        (c) => c.chapter?.contains('Chương 1') ?? false,
      );
      expect(ch1.page, 5);
      expect(ch1.content, contains('tập hợp hữu hạn'));

      final ch2 = chunks.firstWhere(
        (c) => c.chapter?.contains('Chương 2') ?? false,
      );
      expect(ch2.page, 18);
      expect(ch2.content, contains('tìm kiếm nhị phân'));
    });

    test('respects maxChunks guard to prevent memory explosion', () {
      const smallLimitChunker = DocumentChunker(
        targetChunkSize: 20,
        maxChunkSize: 50,
        maxChunks: 3,
      );

      final longText = List.generate(
        20,
        (i) =>
            'Đoạn văn mẫu số $i chứa dữ liệu text dài dài để test giới hạn chunks.',
      ).join('\n\n');

      final chunks = smallLimitChunker.chunk(
        fullText: longText,
        defaultTitle: 'Thử nghiệm giới hạn',
      );

      expect(chunks.length, lessThanOrEqualTo(3));
    });
  });
}
