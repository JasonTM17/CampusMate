import 'package:shared_preferences/shared_preferences.dart';

/// Persists the JWT session tokens and account email locally.
///
/// Backed by `SharedPreferences` for the current phase; migrating to
/// encrypted/secure storage is deferred to the phase-12 hardening pass (the
/// interface below keeps that swap local to this class).
class AuthTokenStorage {
  static const _keyAccessToken = 'auth.accessToken';
  static const _keyAccessTokenExpiresAt = 'auth.accessTokenExpiresAt';
  static const _keyRefreshToken = 'auth.refreshToken';
  static const _keyEmail = 'auth.email';
  static const _keyAuthUserId = 'auth.authUserId';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// Loads the full stored session, or `null` when nothing is stored.
  Future<StoredSession?> read() async {
    final prefs = await _prefs;
    final accessToken = prefs.getString(_keyAccessToken);
    if (accessToken == null) return null;
    final expiresAtRaw = prefs.getString(_keyAccessTokenExpiresAt);
    DateTime? accessTokenExpiresAt;
    if (expiresAtRaw != null) {
      try {
        accessTokenExpiresAt = DateTime.parse(expiresAtRaw);
      } on FormatException {
        await clear();
        return null;
      }
    }
    final email = prefs.getString(_keyEmail);
    final authUserId = prefs.getString(_keyAuthUserId);
    if (email == null ||
        email.isEmpty ||
        authUserId == null ||
        authUserId.isEmpty) {
      await clear();
      return null;
    }
    return StoredSession(
      accessToken: accessToken,
      accessTokenExpiresAt: accessTokenExpiresAt,
      refreshToken: prefs.getString(_keyRefreshToken),
      email: email,
      authUserId: authUserId,
    );
  }

  /// Stores the session obtained from login/registration/refresh.
  Future<void> save(StoredSession session) async {
    final prefs = await _prefs;
    await prefs.setString(_keyAccessToken, session.accessToken);
    final expiresAt = session.accessTokenExpiresAt;
    if (expiresAt == null) {
      await prefs.remove(_keyAccessTokenExpiresAt);
    } else {
      await prefs.setString(
        _keyAccessTokenExpiresAt,
        expiresAt.toIso8601String(),
      );
    }
    final refreshToken = session.refreshToken;
    if (refreshToken == null) {
      await prefs.remove(_keyRefreshToken);
    } else {
      await prefs.setString(_keyRefreshToken, refreshToken);
    }
    await prefs.setString(_keyEmail, session.email);
    await prefs.setString(_keyAuthUserId, session.authUserId);
  }

  /// Removes every stored auth value (sign-out / invalidated session).
  Future<void> clear() async {
    final prefs = await _prefs;
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyAccessTokenExpiresAt);
    await prefs.remove(_keyRefreshToken);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyAuthUserId);
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
  });

  final String accessToken;
  final DateTime? accessTokenExpiresAt;
  final String? refreshToken;
  final String email;
  final String authUserId;
}
