import 'package:campusmate_client/campusmate_client.dart';

import 'auth_failure.dart';
import 'auth_user.dart';

/// Contract for the authentication backend used by the app.
///
/// Throwing members surface a typed [AuthFailure] on failure; success paths
/// persist session tokens internally so the app stays signed in across
/// restarts.
abstract interface class AuthRepository {
  /// Signs in with email + password and returns the signed-in user.
  Future<AuthUser> signIn({required String email, required String password});

  /// Starts registration for [email]; the server delivers a verification
  /// code to that address (dev: logged to the server console).
  ///
  /// Returns the account request id needed by [verifyRegistrationCode].
  Future<UuidValue> startRegistration({required String email});

  /// Verifies the registration [verificationCode] for [accountRequestId].
  ///
  /// Returns the registration token consumed by [completeRegistration].
  Future<String> verifyRegistrationCode({
    required UuidValue accountRequestId,
    required String verificationCode,
  });

  /// Completes registration: creates the user, sets [password], and signs
  /// the new session in.
  Future<AuthUser> completeRegistration({
    required String email,
    required String registrationToken,
    required String password,
  });

  /// Restores a previously signed-in user from local token storage, or
  /// `null` when no session is stored.
  Future<AuthUser?> restore();

  /// Clears the local session (client-side sign-out).
  Future<void> signOut();
}
