import 'package:campusmate_client/campusmate_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import 'auth_token_storage.dart';

/// Supplies the Serverpod client with the stored bearer token and refreshes
/// it automatically when it is (about to be) expired.
///
/// The refresh itself goes through the `jwtRefresh` endpoint, which is
/// registered unauthenticated — so requesting the auth header inside the
/// refresh call cannot deadlock.
class SessionAuthKeyProvider implements RefresherClientAuthKeyProvider {
  SessionAuthKeyProvider({
    required this._storage,
    required Future<AuthSuccess> Function(String refreshToken) refreshTokens,
  }) : _refreshTokens = refreshTokens;

  final AuthTokenStorage _storage;
  final Future<AuthSuccess> Function(String refreshToken) _refreshTokens;

  /// Refresh this close to expiry so in-flight calls do not fail mid-way.
  static const _refreshMargin = Duration(minutes: 2);

  @override
  Future<String?> get authHeaderValue async {
    final session = await _storage.read();
    if (session == null) return null;
    return wrapAsBearerAuthHeaderValue(session.accessToken);
  }

  @override
  Future<RefreshAuthKeyResult> refreshAuthKey({bool force = false}) async {
    final session = await _storage.read();
    final refreshToken = session?.refreshToken;
    if (session == null || refreshToken == null) {
      return RefreshAuthKeyResult.failedUnauthorized;
    }

    final expiresAt = session.accessTokenExpiresAt;
    final isFresh =
        expiresAt != null &&
        expiresAt.isAfter(DateTime.now().add(_refreshMargin));
    if (!force && isFresh) {
      return RefreshAuthKeyResult.skipped;
    }

    try {
      final success = await _refreshTokens(refreshToken);
      await _storage.save(
        StoredSession(
          accessToken: success.token,
          accessTokenExpiresAt: success.tokenExpiresAt,
          refreshToken: success.refreshToken ?? refreshToken,
          email: session.email,
          authUserId: session.authUserId,
        ),
      );
      return RefreshAuthKeyResult.success;
    } on ServerpodClientException {
      // Invalid/expired refresh token or server rejection: drop the session
      // so the next guarded call treats the user as signed out.
      await _storage.clear();
      return RefreshAuthKeyResult.failedUnauthorized;
    } on Exception {
      return RefreshAuthKeyResult.failedOther;
    }
  }
}
