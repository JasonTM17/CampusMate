import 'dart:convert';
import 'dart:io';

import 'package:campusmate_shared/campusmate_shared.dart';

import '../config/runtime_environment.dart';
import 'ai_provider.dart';

/// [AiProvider] backed by any OpenAI / GLM-compatible gateway.
///
/// Reads its target from environment (see `.env.example`):
///   AI_BASE_URL      base URL, e.g. https://open.bigmodel.cn/api/paas/v4
///   API key          via the `Authorization: Bearer` header (server-only)
///   AI_CHAT_MODEL    chat/completions model id
///
/// Streams the `chat/completions` endpoint with `stream: true` and parses the
/// Server-Sent Events (`data: {...}`) into [AiStreamChunk]s. A `[DONE]`
/// sentinel closes the stream. The assistant never sees this URL or key —
/// they live on the server only.
class OpenAiCompatibleProvider implements AiProvider {
  OpenAiCompatibleProvider({
    String? baseUrl,
    String? apiKey,
    String? model,
    String? embeddingModel,
    HttpClient? client,
    Map<String, String>? environment,
    String? dotenvContent,
  }) : _baseUrl =
           baseUrl ??
           _env(
             'AI_BASE_URL',
             environment: environment,
             dotenvContent: dotenvContent,
           ),
       _apiKey =
           apiKey ??
           _env(
             'AI_API_KEY',
             environment: environment,
             dotenvContent: dotenvContent,
           ),
       _model =
           model ??
           _env(
             'AI_CHAT_MODEL',
             environment: environment,
             dotenvContent: dotenvContent,
           ),
       _embeddingModel =
           embeddingModel ??
           _env(
             'AI_EMBEDDING_MODEL',
             environment: environment,
             dotenvContent: dotenvContent,
           ),
       _client = client ?? HttpClient() {
    if (_baseUrl == null || _baseUrl.isEmpty) {
      throw const OpenAiConfigException('AI_BASE_URL is empty');
    }
    if (_model == null || _model.isEmpty) {
      throw const OpenAiConfigException('AI_CHAT_MODEL is empty');
    }
  }

  final String? _baseUrl;
  final String? _apiKey;
  final String? _model;
  final String? _embeddingModel;
  final HttpClient _client;

  static String? _env(
    String key, {
    Map<String, String>? environment,
    String? dotenvContent,
  }) {
    final value = readRuntimeEnvironmentValue(
      key,
      environment: environment,
      dotenvContent: dotenvContent,
    );
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }

  /// Streams a chat completion, translating SSE deltas into chunks.
  @override
  Stream<AiStreamChunk> streamChat(AiRequest request) async* {
    final baseUrl = _baseUrl;
    if (baseUrl == null || baseUrl.isEmpty) {
      throw const OpenAiConfigException('AI_BASE_URL is empty');
    }
    final uri = Uri.parse('$baseUrl/chat/completions');
    final httpRequest = await _client.postUrl(uri);
    httpRequest.headers.contentType = ContentType.json;
    if (_apiKey != null && _apiKey.isNotEmpty) {
      httpRequest.headers.set('Authorization', 'Bearer $_apiKey');
    }
    httpRequest.headers.set('Accept', 'text/event-stream');

    httpRequest.add(
      utf8.encode(
        jsonEncode({
          'model': _model,
          'stream': true,
          'messages': request.messages
              .map((m) => {'role': m.role, 'content': m.content})
              .toList(growable: false),
        }),
      ),
    );

    final response = await httpRequest.close();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      await response.drain<void>();
      throw OpenAiProviderException(response.statusCode, operation: 'chat');
    }
    final lines = response
        .transform(utf8.decoder)
        .transform(
          const LineSplitter(),
        );
    var yieldedDone = false;
    await for (final line in lines) {
      final data = line.trim();
      if (!data.startsWith('data:')) continue;
      final payload = data.substring(5).trim();
      if (payload == '[DONE]') {
        if (!yieldedDone) {
          yield const AiStreamChunk(text: '', isDone: true);
        }
        return;
      }
      try {
        final json = jsonDecode(payload) as Map<String, dynamic>;
        final choices = json['choices'] as List<dynamic>?;
        final choice = choices?.first as Map<String, dynamic>?;
        final delta = choice?['delta'] as Map<String, dynamic>?;
        final content = delta?['content'] as String? ?? '';
        final finish = choice?['finish_reason'];
        if (content.isNotEmpty || finish != null) {
          yieldedDone = finish != null;
          yield AiStreamChunk(
            text: content,
            isDone: yieldedDone,
          );
        }
      } on Object {
        // Skip malformed event frames rather than failing the stream.
      }
    }
  }

  /// Embeddings via the gateway's `/embeddings` endpoint. Returns an empty
  /// vector if no embedding model is configured, so callers degrade
  /// gracefully instead of crashing.
  @override
  Future<List<double>> createEmbedding(String text) async {
    final model = _embeddingModel;
    if (model == null || model.isEmpty) {
      return const <double>[];
    }
    final uri = Uri.parse('$_baseUrl/embeddings');
    final httpRequest = await _client.postUrl(uri);
    httpRequest.headers.contentType = ContentType.json;
    if (_apiKey != null && _apiKey.isNotEmpty) {
      httpRequest.headers.set('Authorization', 'Bearer $_apiKey');
    }
    httpRequest.add(
      utf8.encode(jsonEncode({'model': model, 'input': text})),
    );
    final response = await httpRequest.close();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      await response.drain<void>();
      throw OpenAiProviderException(
        response.statusCode,
        operation: 'embedding',
      );
    }
    final body = await response.transform(utf8.decoder).join();
    try {
      final json = jsonDecode(body) as Map<String, dynamic>;
      final data = json['data'] as List<dynamic>?;
      final first = data?.first as Map<String, dynamic>?;
      final embedding = first?['embedding'] as List<dynamic>?;
      return embedding?.map((e) => (e as num).toDouble()).toList() ??
          const <double>[];
    } on Object {
      return const <double>[];
    }
  }
}

/// Thrown when the OpenAI-compatible gateway is misconfigured.
class OpenAiConfigException implements Exception {
  const OpenAiConfigException(this.message);
  final String message;
  @override
  String toString() => 'OpenAiConfigException: $message';
}

/// Thrown when the gateway rejects the request before streaming starts.
class OpenAiProviderException implements Exception {
  const OpenAiProviderException(this.statusCode, {required this.operation});
  final int statusCode;
  final String operation;
  @override
  String toString() =>
      'OpenAiProviderException: $operation request failed with HTTP $statusCode';
}
