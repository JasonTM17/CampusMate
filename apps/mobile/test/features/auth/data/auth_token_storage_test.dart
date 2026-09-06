import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/features/auth/data/auth_token_storage.dart';

class FakeSecretStore implements SecretStore {
  FakeSecretStore([Map<String, String>? initialValues])
    : values = {...?initialValues};

  final Map<String, String> values;

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}

void main() {
  group('AuthTokenStorage', () {
    test(
      'saves and restores a valid session in the injected secure store',
      () async {
        final store = FakeSecretStore();
        final storage = AuthTokenStorage(store: store);
        final expiresAt = DateTime.utc(2026, 9, 6, 12);

        await storage.save(
          StoredSession(
            accessToken: 'access-token',
            accessTokenExpiresAt: expiresAt,
            refreshToken: 'refresh-token',
            email: 'student001@campusmate.local',
            authUserId: 'user-123',
            scopeNames: {'campusmate.student'},
          ),
        );

        final restored = await storage.read();

        expect(restored, isNotNull);
        expect(restored!.accessToken, 'access-token');
        expect(restored.accessTokenExpiresAt, expiresAt);
        expect(restored.refreshToken, 'refresh-token');
        expect(restored.email, 'student001@campusmate.local');
        expect(restored.authUserId, 'user-123');
        expect(restored.scopeNames, {'campusmate.student'});
        expect(store.values['auth.accessToken'], 'access-token');
      },
    );

    test('clears corrupted expiry data and returns null', () async {
      final store = FakeSecretStore({
        'auth.accessToken': 'access-token',
        'auth.accessTokenExpiresAt': 'not-a-date',
        'auth.refreshToken': 'refresh-token',
        'auth.email': 'student001@campusmate.local',
        'auth.authUserId': 'user-123',
      });

      final restored = await AuthTokenStorage(store: store).read();

      expect(restored, isNull);
      expect(store.values, isEmpty);
    });

    test('clears sessions missing identity fields and returns null', () async {
      final store = FakeSecretStore({
        'auth.accessToken': 'access-token',
        'auth.accessTokenExpiresAt': '2026-09-06T12:00:00.000Z',
        'auth.refreshToken': 'refresh-token',
        'auth.email': '',
        'auth.authUserId': 'user-123',
      });

      final restored = await AuthTokenStorage(store: store).read();

      expect(restored, isNull);
      expect(store.values, isEmpty);
    });

    test('clears an empty access token instead of restoring it', () async {
      final store = FakeSecretStore({
        'auth.accessToken': '',
        'auth.email': 'student001@campusmate.local',
        'auth.authUserId': 'user-123',
      });

      final restored = await AuthTokenStorage(store: store).read();

      expect(restored, isNull);
      expect(store.values, isEmpty);
    });

    test(
      'ignores malformed optional scope metadata without losing the session',
      () async {
        final store = FakeSecretStore({
          'auth.accessToken': 'access-token',
          'auth.email': 'student001@campusmate.local',
          'auth.authUserId': 'user-123',
          'auth.scopeNames': '{bad-json',
        });

        final restored = await AuthTokenStorage(store: store).read();

        expect(restored, isNotNull);
        expect(restored!.scopeNames, isEmpty);
      },
    );
  });
}
