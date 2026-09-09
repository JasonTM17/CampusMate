import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:test/test.dart';

void main() {
  group('AiRequest', () {
    test('instantiates with required fields and optional studentContext', () {
      final messages = [
        const AiMessage(role: 'user', content: 'Chào trợ lý!'),
        const AiMessage(role: 'assistant', content: 'Chào bạn, mình giúp gì được?'),
      ];

      final request = AiRequest(
        conversationId: 'conv-123',
        messages: messages,
        studentContext: 'Student: Nguyen Van A, Major: Software Engineering',
      );

      expect(request.conversationId, 'conv-123');
      expect(request.messages, hasLength(2));
      expect(request.messages.first.role, 'user');
      expect(request.messages.first.content, 'Chào trợ lý!');
      expect(
        request.studentContext,
        'Student: Nguyen Van A, Major: Software Engineering',
      );
    });
  });

  group('AiStreamChunk', () {
    test('defaults isDone to false and citations to empty list', () {
      const chunk = AiStreamChunk(text: 'Đang tải...');

      expect(chunk.text, 'Đang tải...');
      expect(chunk.isDone, isFalse);
      expect(chunk.citations, isEmpty);
    });

    test('carries citations when provided', () {
      const citation = AiCitation(
        title: 'Giáo trình Cơ sở dữ liệu',
        bookId: '10',
        chapter: 'Chương 3: Chuẩn hóa dữ liệu',
        page: 45,
      );

      const chunk = AiStreamChunk(
        text: 'Nội dung chuẩn hóa 3NF.',
        isDone: true,
        citations: [citation],
      );

      expect(chunk.isDone, isTrue);
      expect(chunk.citations, hasLength(1));
      expect(chunk.citations.first.title, 'Giáo trình Cơ sở dữ liệu');
      expect(chunk.citations.first.bookId, '10');
      expect(chunk.citations.first.chapter, 'Chương 3: Chuẩn hóa dữ liệu');
      expect(chunk.citations.first.page, 45);
    });
  });
}
