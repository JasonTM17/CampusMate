import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/app/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('falls back to the local dev server URL without dart-define', () {
      final config = AppConfig.fromEnvironment(isAndroid: false);

      expect(config.serverUrl, 'http://localhost:8080/');
    });

    test('falls back to the Android emulator host bridge on Android', () {
      final config = AppConfig.fromEnvironment(isAndroid: true);

      expect(config.serverUrl, 'http://10.0.2.2:8080/');
    });

    test('is const-constructible for compile-time defaults', () {
      const config = AppConfig(serverUrl: 'https://api.example.com/');

      expect(config.serverUrl, 'https://api.example.com/');
    });

    test('fromEnvironment always returns a usable instance', () {
      // README quickstart requires a trailing slash on the server URL; a
      // missing one would silently produce malformed endpoint paths.
      expect(
        AppConfig.fromEnvironment(isAndroid: false).serverUrl,
        endsWith('/'),
      );
    });

    test('normalizes server URLs to a trailing slash', () {
      expect(
        AppConfig.normalizeServerUrl(' https://api.example.com '),
        'https://api.example.com/',
      );
      expect(
        AppConfig.normalizeServerUrl('https://api.example.com/'),
        'https://api.example.com/',
      );
    });
  });
}
