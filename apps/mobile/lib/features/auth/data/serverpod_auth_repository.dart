import 'package:campusmate_client/campusmate_client.dart';
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    hide AuthUser;

import '../domain/auth_failure.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';
import 'auth_token_storage.dart';

/// [AuthRepository] backed by the Serverpod email identity provider.
///
/// Persists every `AuthSuccess` into [AuthTokenStorage] so restarts restore
/// the session, and classifies module exceptions into typed [AuthFailure]s.
class ServerpodAuthRepository implements AuthRepository {
  ServerpodAuthRepository({required this._client, required this._storage});

  final Client _client;
  final AuthTokenStorage _storage;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final success = await _client.emailIdp.login(
        email: email,
        password: password,
      );
      return _persist(success, email);
    } on EmailAccountLoginException catch (e) {
      throw switch (e.reason) {
        EmailAccountLoginExceptionReason.invalidCredentials =>
          const InvalidCredentialsFailure(),
        EmailAccountLoginExceptionReason.tooManyAttempts =>
          const TooManyAttemptsFailure(),
        _ => UnknownAuthFailure(e.reason.name),
      };
    } on ServerpodClientException {
      throw const NetworkFailure();
    }
  }

  @override
  Future<UuidValue> startRegistration({required String email}) async {
    try {
      return await _client.emailIdp.startRegistration(email: email);
    } on ServerpodClientException {
      throw const NetworkFailure();
    }
  }

  @override
  Future<String> verifyRegistrationCode({
    required UuidValue accountRequestId,
    required String verificationCode,
  }) async {
    try {
      return await _client.emailIdp.verifyRegistrationCode(
        accountRequestId: accountRequestId,
        verificationCode: verificationCode,
      );
    } on EmailAccountRequestException {
      throw const CodeInvalidOrExpiredFailure();
    } on ServerpodClientException {
      throw const NetworkFailure();
    }
  }

  @override
  Future<AuthUser> completeRegistration({
    required String email,
    required String registrationToken,
    required String password,
  }) async {
    try {
      final success = await _client.emailIdp.finishRegistration(
        registrationToken: registrationToken,
        password: password,
      );
      return _persist(success, email);
    } on EmailAccountRequestException catch (e) {
      throw switch (e.reason) {
        EmailAccountRequestExceptionReason.policyViolation =>
          const PasswordPolicyFailure(),
        _ => const CodeInvalidOrExpiredFailure(),
      };
    } on ServerpodClientException {
      throw const NetworkFailure();
    }
  }

  @override
  Future<AuthUser?> restore() async {
    final session = await _storage.read();
    if (session == null || session.authUserId.isEmpty) return null;
    return AuthUser(authUserId: session.authUserId, email: session.email);
  }

  @override
  Future<void> signOut() => _storage.clear();

  /// Persists an `AuthSuccess` and returns the matching [AuthUser].
  Future<AuthUser> _persist(AuthSuccess success, String email) async {
    await _storage.save(
      StoredSession(
        accessToken: success.token,
        accessTokenExpiresAt: success.tokenExpiresAt,
        refreshToken: success.refreshToken,
        email: email,
        authUserId: success.authUserId.uuid,
      ),
    );
    return AuthUser(authUserId: success.authUserId.uuid, email: email);
  }
}
