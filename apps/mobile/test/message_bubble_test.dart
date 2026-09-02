import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/presentation/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps a [MessageBubble] with a fixed-size surface so layout is stable.
Widget _surface({required Widget child}) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  testWidgets('renders a user bubble right-aligned as plain text', (
    tester,
  ) async {
    await tester.pumpWidget(
      _surface(
        child: const MessageBubble(
          message: ChatMessage(role: MessageRole.user, content: 'Xin chào'),
        ),
      ),
    );

    expect(find.text('Xin chào'), findsOneWidget);
  });

  testWidgets('renders an assistant bubble with markdown', (tester) async {
    await tester.pumpWidget(
      _surface(
        child: const MessageBubble(
          message: ChatMessage(
            role: MessageRole.assistant,
            content: '**In đậm** và *nghiêng*',
          ),
        ),
      ),
    );

    // MarkdownBody is present for assistant turns.
    expect(find.byType(MarkdownBody), findsOneWidget);
  });

  testWidgets('hides the avatar when showAvatar is false', (tester) async {
    await tester.pumpWidget(
      _surface(
        child: const MessageBubble(
          message: ChatMessage(role: MessageRole.assistant, content: 'Chào'),
          showAvatar: false,
        ),
      ),
    );

    expect(find.byType(CircleAvatar), findsNothing);
    expect(find.byType(MarkdownBody), findsOneWidget);
  });
}
