import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/presentation/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MessageBubble Citations', () {
    testWidgets('renders citation chips for assistant messages with citations', (tester) async {
      const message = ChatMessage(
        role: MessageRole.assistant,
        content: 'Theo giáo trình giải thuật, tìm kiếm nhị phân có độ phức tạp O(log n).',
        citations: [
          ChatCitation(
            title: 'Giáo trình Cấu trúc Dữ liệu',
            chapter: 'Chương 2',
            page: 45,
            documentId: 1,
            bookId: 10,
          ),
          ChatCitation(
            title: 'Sổ tay Sinh viên 2026',
            chapter: 'Quy chế',
            page: 12,
            documentId: 2,
          ),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MessageBubble(message: message),
          ),
        ),
      );

      expect(find.text('Nguồn trích dẫn:'), findsOneWidget);
      expect(find.text('Giáo trình Cấu trúc Dữ liệu - Chương 2, tr. 45'), findsOneWidget);
      expect(find.text('Sổ tay Sinh viên 2026 - Quy chế, tr. 12'), findsOneWidget);
    });

    testWidgets('does not render citation section when citations list is empty', (tester) async {
      const message = ChatMessage(
        role: MessageRole.assistant,
        content: 'Chào bạn! Mình có thể giúp gì cho bạn hôm nay?',
        citations: [],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MessageBubble(message: message),
          ),
        ),
      );

      expect(find.text('Nguồn trích dẫn:'), findsNothing);
    });

    testWidgets('clicking document citation without bookId opens detail dialog', (tester) async {
      const message = ChatMessage(
        role: MessageRole.assistant,
        content: 'Thông tin theo quy chế chung.',
        citations: [
          ChatCitation(
            title: 'Sổ tay Sinh viên 2026',
            chapter: 'Quy chế đào tạo',
            page: 25,
            documentId: 5,
            quote: 'Sinh viên phải tích lũy tối thiểu 130 tín chỉ để tốt nghiệp.',
          ),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MessageBubble(message: message),
          ),
        ),
      );

      final chipFinder = find.text('Sổ tay Sinh viên 2026 - Quy chế đào tạo, tr. 25');
      expect(chipFinder, findsOneWidget);

      await tester.tap(chipFinder);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Chương: Quy chế đào tạo'), findsOneWidget);
      expect(find.text('Trang: 25'), findsOneWidget);
      expect(find.text('Mã tài liệu: #5'), findsOneWidget);
      expect(find.text('Sinh viên phải tích lũy tối thiểu 130 tín chỉ để tốt nghiệp.'), findsOneWidget);

      await tester.tap(find.text('Đóng'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
