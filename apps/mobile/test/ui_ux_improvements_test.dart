import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/presentation/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('assistant bubble renders copy button and citation opens /library/books/:id', (tester) async {
    String? navigatedRoute;
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(
            body: MessageBubble(
              message: ChatMessage(
                id: 'msg-1',
                role: MessageRole.assistant,
                content: 'Giai thich bai hoc',
                citations: [
                  ChatCitation(
                    bookId: 42,
                    title: 'Sach Lap Trinh Flutter',
                  ),
                ],
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/library/books/:bookId',
          builder: (context, state) {
            navigatedRoute = state.uri.path;
            return const Scaffold(body: Text('BOOK_DETAIL_PAGE'));
          },
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Sao chép nội dung'), findsOneWidget);
    expect(find.text('Sach Lap Trinh Flutter'), findsOneWidget);

    await tester.tap(find.text('Sach Lap Trinh Flutter'));
    await tester.pumpAndSettle();

    expect(navigatedRoute, '/library/books/42');
    expect(find.text('BOOK_DETAIL_PAGE'), findsOneWidget);
  });
}
