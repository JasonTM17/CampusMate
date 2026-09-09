import 'package:campusmate/core/widgets/app_empty_state.dart';
import 'package:campusmate/core/widgets/bouncing_widget.dart';
import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/presentation/message_bubble.dart';
import 'package:campusmate/features/library/presentation/book_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
    'assistant bubble renders copy button and citation opens /library/books/:id',
    (tester) async {
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
                    ChatCitation(bookId: 42, title: 'Sach Lap Trinh Flutter'),
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
    },
  );

  testWidgets('BookCover wraps in Hero widget when heroTag is provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BookCover(
            heroTag: 'test-hero-tag',
            coverUrl: null,
            width: 80,
            height: 120,
          ),
        ),
      ),
    );

    final heroFinder = find.byType(Hero);
    expect(heroFinder, findsOneWidget);
    final hero = tester.widget<Hero>(heroFinder);
    expect(hero.tag, 'test-hero-tag');
  });

  testWidgets('BouncingWidget reacts to taps and triggers callback', (
    tester,
  ) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BouncingWidget(
            enableHaptic: true,
            onTap: () => tapped = true,
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    expect(find.text('Tap Me'), findsOneWidget);
    await tester.tap(find.text('Tap Me'));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  testWidgets(
    'AppEmptyState renders icon, title, message and optional action',
    (tester) async {
      var actionClicked = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              icon: Icons.search_off,
              title: 'Trống',
              message: 'Không có dữ liệu hiển thị.',
              actionLabel: 'Thử lại ngay',
              onAction: () => actionClicked = true,
            ),
          ),
        ),
      );

      expect(find.text('Trống'), findsOneWidget);
      expect(find.text('Không có dữ liệu hiển thị.'), findsOneWidget);
      expect(find.text('Thử lại ngay'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);

      await tester.tap(find.text('Thử lại ngay'));
      await tester.pumpAndSettle();
      expect(actionClicked, isTrue);
    },
  );
}
