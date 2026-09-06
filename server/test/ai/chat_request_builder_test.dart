import 'package:campusmate_server/src/ai/chat_request_builder.dart';
import 'package:campusmate_server/src/ai/system_prompt.dart';
import 'package:test/test.dart';

import '../fixtures/prompt_injection_fixtures.dart';

void main() {
  group('assembleChatMessages — prompt-injection baseline (§30)', () {
    test('always opens with the server-owned system prompt', () {
      final messages = assembleChatMessages(
        history: const [('user', 'Xin chào')],
        userMessage: 'Tạo quiz',
      );
      expect(messages.first.role, 'system');
      expect(messages.first.content, campusmateSystemPrompt);
    });

    test('keeps history order and appends the new user turn last', () {
      final messages = assembleChatMessages(
        history: const [('user', 'a'), ('assistant', 'b'), ('user', 'c')],
        userMessage: 'd',
      );
      expect(messages.map((m) => m.role), [
        'system',
        'user',
        'assistant',
        'user',
        'user',
      ]);
      expect(messages.last.content, 'd');
    });

    test('drops stored system rows so history cannot replace the prompt', () {
      final messages = assembleChatMessages(
        history: const [('system', 'malicious override'), ('user', 'hi')],
        userMessage: 'hello',
      );
      expect(messages.where((m) => m.role == 'system'), hasLength(1));
      expect(messages.first.content, campusmateSystemPrompt);
      expect(
        messages.map((m) => m.content),
        isNot(contains('malicious override')),
      );
    });

    test('passes every injection fixture through as unmodified user data', () {
      for (final payload in promptInjectionFixtures) {
        final messages = assembleChatMessages(
          history: const [],
          userMessage: payload,
        );
        expect(messages, hasLength(2));
        expect(messages.first.role, 'system');
        expect(messages.last.role, 'user');
        expect(messages.last.content, payload);
      }
    });
  });
}
