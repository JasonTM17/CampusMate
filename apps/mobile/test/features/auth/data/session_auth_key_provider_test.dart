import 'package:campusmate/features/auth/data/auth_token_storage.dart';
import 'package:campusmate/features/auth/data/session_auth_key_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';
import 'package:serverpod_client/serverpod_client.dart';

class _MemorySecretStore implements SecretStore {
  final _values = <String, String>{};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async => _values[key] = value;

  @override
  Future<void> delete(String key) async => _values.remove(key);
}

StoredSession _storedSession() => const StoredSession(
  accessToken: 'access-token',
  refreshToken: 'refresh-token',
  email: 'student001@campusmate.local',
  authUserId: '00000000-0000-4000-8000-000000000001',
);

void main() {
  test('keeps the stored session when the refresh fails transiently', () async {
    final store = AuthTokenStorage(store: _MemorySecretStore());
    final session = _storedSession();
    await store.save(session);

    final provider = SessionAuthKeyProvider(
      storage: store,
      refreshTokens: (refreshToken) =>
          throw ServerpodClientException('connection reset', 500),
    );

    final result = await provider.refreshAuthKey(force: true);

    expect(result, RefreshAuthKeyResult.failedOther);
    // A transient server failure must not sign the user out.
    expect(await store.read(), isNotNull);
  });

  test('clears the stored session when the refresh is rejected', () async {
    final store = AuthTokenStorage(store: _MemorySecretStore());
    await store.save(_storedSession());

    final provider = SessionAuthKeyProvider(
      storage: store,
      refreshTokens: (refreshToken) =>
          throw ServerpodClientException('invalid token', 401),
    );

    final result = await provider.refreshAuthKey(force: true);

    expect(result, RefreshAuthKeyResult.failedUnauthorized);
    expect(await store.read(), isNull);
  });

  test(
    'keeps the stored session when the refresh throws a transport error',
    () async {
      final store = AuthTokenStorage(store: _MemorySecretStore());
      await store.save(_storedSession());

      final provider = SessionAuthKeyProvider(
        storage: store,
        refreshTokens: (refreshToken) => throw Exception('SocketException'),
      );

      final result = await provider.refreshAuthKey(force: true);

      expect(result, RefreshAuthKeyResult.failedOther);
      expect(await store.read(), isNotNull);
    },
  );
}
