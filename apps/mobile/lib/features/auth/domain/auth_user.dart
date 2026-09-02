/// Authenticated user identity shown across the app after sign-in.
///
/// The email is captured client-side at sign-in/registration time (the
/// `AuthSuccess` payload only carries the auth user id).
class AuthUser {
  const AuthUser({required this.authUserId, required this.email});

  /// Stable identifier of the auth user on the server (UUID).
  final String authUserId;

  /// Email address used for sign-in.
  final String email;
}
