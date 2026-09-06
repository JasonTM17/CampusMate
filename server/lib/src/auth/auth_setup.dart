import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'campusmate_auth.dart';

Set<Scope> scopesForNewCampusMateUser(Set<Scope> requestedScopes) {
  return requestedScopes.isEmpty ? {campusMateStudentScope} : requestedScopes;
}

/// Registers the authentication services shared by the server and dev tools.
///
/// Keeping this setup in one place prevents a seed command from silently
/// issuing accounts with scopes that differ from the running API.
void initializeCampusMateAuthServices(Serverpod pod) {
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: sendRegistrationCode,
        sendPasswordResetVerificationCode: sendPasswordResetCode,
      ),
    ],
    authUsersConfig: AuthUsersConfig(
      onBeforeAuthUserCreated:
          (
            session,
            scopes,
            blocked, {
            required transaction,
          }) {
            return (
              // Public email registration has no role input and therefore
              // gets the least-privileged student scope. Trusted seed/admin
              // flows pass an explicit role scope and must not inherit student
              // access.
              scopes: scopesForNewCampusMateUser(scopes),
              blocked: blocked,
            );
          },
    ),
  );
}

void sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // Replace this seam with a mail provider before enabling real registration.
  session.log('[EmailIdp] Registration code ($email): $verificationCode');
}

void sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // Replace this seam with a mail provider before enabling real reset emails.
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
}
