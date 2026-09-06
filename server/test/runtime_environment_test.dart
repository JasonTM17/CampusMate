import 'package:campusmate_server/src/ai/ai_provider_factory.dart';
import 'package:campusmate_server/src/ai/fake_ai_provider.dart';
import 'package:campusmate_server/src/ai/quota.dart';
import 'package:campusmate_server/src/config/runtime_environment.dart';
import 'package:test/test.dart';

void main() {
  group('readRuntimeEnvironmentValue', () {
    test('prefers process environment values over dotenv content', () {
      final value = readRuntimeEnvironmentValue(
        'AI_PROVIDER',
        environment: {'AI_PROVIDER': 'fake'},
        dotenvContent: 'AI_PROVIDER=nonexistent',
      );

      expect(value, 'fake');
    });

    test('reads quoted dotenv values and ignores comments', () {
      final value = readRuntimeEnvironmentValue(
        'AI_BASE_URL',
        environment: const {},
        dotenvContent: '''
# ignored
export AI_BASE_URL="https://ai.example.test/v1"
AI_PROVIDER=fake
''',
      );

      expect(value, 'https://ai.example.test/v1');
    });

    test('treats empty values as missing', () {
      final value = readRuntimeEnvironmentValue(
        'AI_API_KEY',
        environment: const {},
        dotenvContent: 'AI_API_KEY=',
      );

      expect(value, isNull);
    });
  });

  group('AI runtime configuration', () {
    test('factory can read AI_PROVIDER from dotenv content', () {
      final provider = createAiProvider(
        environment: const {},
        dotenvContent: 'AI_PROVIDER=fake',
      );

      expect(provider, isA<FakeAiProvider>());
    });

    test('daily quota can read AI_DAILY_MESSAGE_QUOTA from dotenv content', () {
      final quota = DailyMessageQuota(
        environment: const {},
        dotenvContent: 'AI_DAILY_MESSAGE_QUOTA=7',
      );

      expect(quota.limit, 7);
    });

    test('daily quota falls back to the safe default for invalid values', () {
      final quota = DailyMessageQuota(
        environment: const {},
        dotenvContent: 'AI_DAILY_MESSAGE_QUOTA=0',
      );

      expect(quota.limit, 50);
    });
  });
}
