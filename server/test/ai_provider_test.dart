import 'package:campusmate_server/src/ai/ai_provider_factory.dart';
import 'package:campusmate_server/src/ai/fake_ai_provider.dart';
import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:test/test.dart';

void main() {
  final request = AiRequest(
    conversationId: 'conv-1',
    messages: const [AiMessage(role: 'user', content: 'Giải thích phase 8')],
  );

  group('FakeAiProvider', () {
    test('streams multiple chunks ending with isDone', () async {
      final provider = FakeAiProvider(chunkDelay: Duration.zero);
      final chunks = await provider.streamChat(request).toList();

      expect(chunks, isNotEmpty);
      expect(chunks.last.isDone, isTrue);
      final text = chunks.map((c) => c.text).join();
      expect(text, contains('phase 8'));
      expect(text, contains('Gợi ý bắt đầu'));
    });

    test('emits a greeting with suggestions for an empty prompt', () async {
      final provider = FakeAiProvider(chunkDelay: Duration.zero);
      final empty = AiRequest(conversationId: 'conv-2', messages: const []);
      final text = (await provider.streamChat(empty).toList())
          .map((c) => c.text)
          .join();

      expect(text, contains('Xin chào'));
      expect(text, contains('Giải thích bài học'));
    });

    test('produces a deterministic embedding for the same text', () async {
      final provider = FakeAiProvider();
      final a = await provider.createEmbedding('hello campusmate');
      final b = await provider.createEmbedding('hello campusmate');
      final c = await provider.createEmbedding('different text');

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a, isNotEmpty);
    });

    test('yields no citations in the fake implementation', () async {
      final provider = FakeAiProvider(chunkDelay: Duration.zero);
      final chunks = await provider.streamChat(request).toList();
      expect(chunks.every((c) => c.citations.isEmpty), isTrue);
    });
  });

  group('createAiProvider', () {
    test('defaults to the fake provider', () {
      expect(createAiProvider(), isA<FakeAiProvider>());
    });

    test('AI_PROVIDER=fake returns a FakeAiProvider', () {
      expect(createAiProvider(provider: 'fake'), isA<FakeAiProvider>());
    });

    test('throws for an unknown provider', () {
      expect(
        () => createAiProvider(provider: 'nonexistent'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
