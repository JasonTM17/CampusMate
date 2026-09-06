import '../config/runtime_environment.dart';
import 'ai_provider.dart';
import 'fake_ai_provider.dart';
import 'openai_compatible_provider.dart';

/// Selects the [AiProvider] implementation from the `AI_PROVIDER` env var.
///
/// * `fake` (default, and the dev/test default) → [FakeAiProvider], no key.
/// * `openai_compatible` / `openai-compatible` → [OpenAiCompatibleProvider], reads
///   AI_BASE_URL / AI_API_KEY / AI_CHAT_MODEL / AI_EMBEDDING_MODEL.
///
/// Centralized here so endpoint code never branches on the provider choice.
AiProvider createAiProvider({
  String? provider,
  Map<String, String>? environment,
  String? dotenvContent,
}) {
  final choice =
      (provider ??
              readRuntimeEnvironmentValue(
                'AI_PROVIDER',
                environment: environment,
                dotenvContent: dotenvContent,
              ) ??
              'fake')
          .trim()
          .toLowerCase()
          .replaceAll('-', '_');
  return switch (choice) {
    'openai_compatible' || 'openai' || 'glm' => OpenAiCompatibleProvider(
      environment: environment,
      dotenvContent: dotenvContent,
    ),
    'fake' => FakeAiProvider(),
    _ => throw ArgumentError.value(
      choice,
      'AI_PROVIDER',
      'unknown AI provider; expected "fake", "openai_compatible", or "openai-compatible"',
    ),
  };
}
