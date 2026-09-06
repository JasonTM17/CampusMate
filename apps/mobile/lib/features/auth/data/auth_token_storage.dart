import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Minimal storage contract so auth persistence can be tested without a
/// platform plugin.
abstract interface class SecretStore {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);
}

class FlutterSecureSecretStore implements SecretStore {
  FlutterSecureSecretStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// Persists the JWT session tokens and account metadata in platform-backed
/// secure storage. Tokens never go through plain preferences.
class AuthTokenStorage {
  static const _keyAccessToken = 'auth.accessToken';
  static const _keyAccessTokenExpiresAt = 'auth.accessTokenExpiresAt';
  static const _keyRefreshToken = 'auth.refreshToken';
  static const _keyEmail = 'auth.email';
  static const _keyAuthUserId = 'auth.authUserId';
  static const _keyScopeNames = 'auth.scopeNames';

  AuthTokenStorage({SecretStore? store})
    : _store = store ?? FlutterSecureSecretStore();

  final SecretStore _store;

  /// Loads the full stored session, or `null` when nothing is stored.
  Future<StoredSession?> read() async {
    final accessToken = await _store.read(_keyAccessToken);
    if (accessToken == null) return null;
    if (accessToken.isEmpty) {
      await clear();
      return null;
    }
    final expiresAtRaw = await _store.read(_keyAccessTokenExpiresAt);
    DateTime? accessTokenExpiresAt;
    if (expiresAtRaw != null) {
      try {
        accessTokenExpiresAt = DateTime.parse(expiresAtRaw);
      } on FormatException {
        await clear();
        return null;
      }
    }
    final email = await _store.read(_keyEmail);
    final authUserId = await _store.read(_keyAuthUserId);
    if (email == null ||
        email.isEmpty ||
        authUserId == null ||
        authUserId.isEmpty) {
      await clear();
      return null;
    }
    final refreshToken = await _store.read(_keyRefreshToken);
    final scopeNames = await _readScopeNames();
    return StoredSession(
      accessToken: accessToken,
      accessTokenExpiresAt: accessTokenExpiresAt,
      refreshToken: refreshToken?.isNotEmpty == true ? refreshToken : null,
      email: email,
      authUserId: authUserId,
      scopeNames: scopeNames,
    );
  }

  /// Stores the session obtained from login/registration/refresh.
  Future<void> save(StoredSession session) async {
    await _store.write(_keyAccessToken, session.accessToken);
    final expiresAt = session.accessTokenExpiresAt;
    if (expiresAt == null) {
      await _store.delete(_keyAccessTokenExpiresAt);
    } else {
      await _store.write(_keyAccessTokenExpiresAt, expiresAt.toIso8601String());
    }
    final refreshToken = session.refreshToken;
    if (refreshToken == null) {
      await _store.delete(_keyRefreshToken);
    } else {
      await _store.write(_keyRefreshToken, refreshToken);
    }
    await _store.write(_keyEmail, session.email);
    await _store.write(_keyAuthUserId, session.authUserId);
    final scopeNames = session.scopeNames.toList()..sort();
    await _store.write(_keyScopeNames, jsonEncode(scopeNames));
  }

  /// Removes every stored auth value (sign-out / invalidated session).
  Future<void> clear() async {
    for (final key in const [
      _keyAccessToken,
      _keyAccessTokenExpiresAt,
      _keyRefreshToken,
      _keyEmail,
      _keyAuthUserId,
      _keyScopeNames,
    ]) {
      await _store.delete(key);
    }
  }

  Future<Set<String>> _readScopeNames() async {
    final raw = await _store.read(_keyScopeNames);
    if (raw == null || raw.isEmpty) return const {};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.whereType<String>().toSet();
      }
    } on FormatException {
      // A stale optional metadata field must not destroy a valid session.
    }
    return const {};
  }
}

/// Immutable snapshot of the locally stored session.
class StoredSession {
  const StoredSession({
    required this.accessToken,
    required this.refreshToken,
    required this.email,
    required this.authUserId,
    this.accessTokenExpiresAt,
    this.scopeNames = const {},
  });

  final String accessToken;
  final DateTime? accessTokenExpiresAt;
  final String? refreshToken;
  final String email;
  final String authUserId;
  final Set<String> scopeNames;
}
