import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/app/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('falls back to the local dev server URL without dart-define', () {
      final config = AppConfig.fromEnvironment();

      expect(config.serverUrl, 'http://localhost:8080/');
    });

    test('is const-constructible for compile-time defaults', () {
      const config = AppConfig(serverUrl: 'https://api.example.com/');

      expect(config.serverUrl, 'https://api.example.com/');
    });

    test('fromEnvironment always returns a usable instance', () {
      // README quickstart requires a trailing slash on the server URL; a
      // missing one would silently produce malformed endpoint paths.
      expect(AppConfig.fromEnvironment().serverUrl, endsWith('/'));
    });
  });
}
