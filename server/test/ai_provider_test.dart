import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:campusmate_server/src/ai/ai_provider_factory.dart';
import 'package:campusmate_server/src/ai/fake_ai_provider.dart';
import 'package:campusmate_server/src/ai/openai_compatible_provider.dart';
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

    test('normalizes non-empty fake embeddings to unit length', () async {
      final provider = FakeAiProvider();
      final embedding = await provider.createEmbedding('campusmate rag seed');
      final length = math.sqrt(
        embedding.fold<double>(0, (sum, value) => sum + value * value),
      );

      expect(length, closeTo(1, 1e-12));
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

    test(
      'reads the runtime AI_PROVIDER environment when no override is given',
      () {
        expect(
          () => createAiProvider(environment: {'AI_PROVIDER': 'nonexistent'}),
          throwsA(isA<ArgumentError>()),
        );
      },
    );

    test('explicit provider override wins over runtime environment', () {
      expect(
        createAiProvider(
          provider: 'fake',
          environment: {'AI_PROVIDER': 'nonexistent'},
        ),
        isA<FakeAiProvider>(),
      );
    });

    test('accepts the documented openai-compatible provider alias', () {
      expect(
        createAiProvider(
          provider: 'openai-compatible',
          environment: {
            'AI_BASE_URL': 'https://ai.example.test/v1',
            'AI_CHAT_MODEL': 'test-model',
          },
        ),
        isA<OpenAiCompatibleProvider>(),
      );
    });

    test('passes runtime config into the OpenAI-compatible provider', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(server.close);

      final handled = server.first.then((request) async {
        expect(request.headers.value('authorization'), 'Bearer factory-key');
        final body =
            jsonDecode(await utf8.decoder.bind(request).join())
                as Map<String, dynamic>;
        expect(body['model'], 'factory-model');

        request.response.headers.contentType = ContentType(
          'text',
          'event-stream',
        );
        request.response.write(
          'data: {"choices":[{"delta":{"content":"factory-ok"},'
          '"finish_reason":"stop"}]}\n\n',
        );
        request.response.write('data: [DONE]\n\n');
        await request.response.close();
      });

      final provider = createAiProvider(
        provider: 'openai-compatible',
        environment: const {},
        dotenvContent:
            '''
AI_BASE_URL=http://${server.address.host}:${server.port}
AI_API_KEY=factory-key
AI_CHAT_MODEL=factory-model
''',
      );
      final chunks = await provider.streamChat(request).toList();

      expect(chunks.map((c) => c.text).join(), 'factory-ok');
      expect(chunks.last.isDone, isTrue);
      await handled;
    });

    test('throws for an unknown provider', () {
      expect(
        () => createAiProvider(provider: 'nonexistent'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('OpenAiCompatibleProvider', () {
    test('requires AI_BASE_URL when explicitly selected', () {
      expect(
        () => OpenAiCompatibleProvider(baseUrl: ''),
        throwsA(isA<OpenAiConfigException>()),
      );
    });

    test('requires AI_CHAT_MODEL when explicitly selected', () {
      expect(
        () => OpenAiCompatibleProvider(baseUrl: 'https://ai.example.test/v1'),
        throwsA(
          isA<OpenAiConfigException>().having(
            (e) => e.message,
            'message',
            'AI_CHAT_MODEL is empty',
          ),
        ),
      );
    });

    test('parses OpenAI-compatible SSE delta chunks', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(server.close);

      final handled = server.first.then((request) async {
        expect(request.method, 'POST');
        expect(request.uri.path, '/chat/completions');
        expect(request.headers.value('authorization'), 'Bearer test-key');

        final body =
            jsonDecode(await utf8.decoder.bind(request).join())
                as Map<String, dynamic>;
        expect(body['model'], 'test-model');
        expect(body['stream'], isTrue);

        request.response.headers.contentType = ContentType(
          'text',
          'event-stream',
        );
        request.response.write('data: {"choices":[{"delta":{"content":"Hel');
        await request.response.flush();
        request.response.write('lo "},"finish_reason":null}]}\n\n');
        request.response.write(
          'data: {"choices":[{"delta":{"content":"world"},'
          '"finish_reason":null}]}\n\n',
        );
        request.response.write(
          'data: {"choices":[{"delta":{},"finish_reason":"stop"}]}\n\n',
        );
        request.response.write('data: [DONE]\n\n');
        await request.response.close();
      });

      final provider = OpenAiCompatibleProvider(
        baseUrl: 'http://${server.address.host}:${server.port}',
        apiKey: 'test-key',
        model: 'test-model',
      );
      final chunks = await provider.streamChat(request).toList();

      expect(chunks.map((c) => c.text).join(), 'Hello world');
      expect(chunks.last.isDone, isTrue);
      await handled;
    });

    test('reads gateway config from dotenv content', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(server.close);

      final handled = server.first.then((request) async {
        expect(request.headers.value('authorization'), 'Bearer dotenv-key');
        final body =
            jsonDecode(await utf8.decoder.bind(request).join())
                as Map<String, dynamic>;
        expect(body['model'], 'dotenv-model');

        request.response.headers.contentType = ContentType(
          'text',
          'event-stream',
        );
        request.response.write(
          'data: {"choices":[{"delta":{"content":"ok"},'
          '"finish_reason":"stop"}]}\n\n',
        );
        request.response.write('data: [DONE]\n\n');
        await request.response.close();
      });

      final provider = OpenAiCompatibleProvider(
        environment: const {},
        dotenvContent:
            '''
AI_BASE_URL=http://${server.address.host}:${server.port}
AI_API_KEY=dotenv-key
AI_CHAT_MODEL=dotenv-model
''',
      );
      final chunks = await provider.streamChat(request).toList();

      expect(chunks.map((c) => c.text).join(), 'ok');
      expect(chunks.last.isDone, isTrue);
      await handled;
    });

    test(
      'returns an empty embedding vector when no embedding model is set',
      () async {
        final provider = OpenAiCompatibleProvider(
          baseUrl: 'https://ai.example.test/v1',
          model: 'test-model',
          embeddingModel: '',
        );

        expect(await provider.createEmbedding('campusmate rag seed'), isEmpty);
      },
    );

    test('throws a sanitized error for non-success HTTP responses', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(server.close);

      final handled = server.first.then((request) async {
        request.response.statusCode = HttpStatus.unauthorized;
        request.response.write('raw provider body with sk-secret');
        await request.response.close();
      });

      final provider = OpenAiCompatibleProvider(
        baseUrl: 'http://${server.address.host}:${server.port}',
        apiKey: 'test-key',
        model: 'test-model',
      );

      await expectLater(
        provider.streamChat(request).toList(),
        throwsA(
          isA<OpenAiProviderException>()
              .having((e) => e.statusCode, 'statusCode', 401)
              .having((e) => e.toString(), 'message', isNot(contains('sk-'))),
        ),
      );
      await handled;
    });

    test('emits a done chunk when the gateway only sends DONE', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(server.close);

      final handled = server.first.then((request) async {
        request.response.headers.contentType = ContentType(
          'text',
          'event-stream',
        );
        request.response.write(
          'data: {"choices":[{"delta":{"content":"Xin chao"},'
          '"finish_reason":null}]}\n\n',
        );
        request.response.write('data: [DONE]\n\n');
        await request.response.close();
      });

      final provider = OpenAiCompatibleProvider(
        baseUrl: 'http://${server.address.host}:${server.port}',
        apiKey: 'test-key',
        model: 'test-model',
      );
      final chunks = await provider.streamChat(request).toList();

      expect(chunks.map((c) => c.text).join(), 'Xin chao');
      expect(chunks.last.isDone, isTrue);
      await handled;
    });
  });
}
