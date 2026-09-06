/// Authenticated user identity shown across the app after sign-in.
///
/// The email is captured client-side at sign-in/registration time (the
/// `AuthSuccess` payload only carries the auth user id).
class AuthUser {
  const AuthUser({
    required this.authUserId,
    required this.email,
    this.role = 'student',
    this.scopeNames = const {},
  });

  /// Stable identifier of the auth user on the server (UUID).
  final String authUserId;

  /// Email address used for sign-in.
  final String email;

  /// Server-issued role used for presentation decisions only. Every protected
  /// operation is still authorized by the server-side scope checks.
  final String role;

  /// Scopes returned by Serverpod and persisted for session restore.
  final Set<String> scopeNames;
}

String authRoleForScopes(Iterable<String> scopes) {
  final names = scopes.toSet();
  if (names.contains('campusmate.admin')) return 'admin';
  if (names.contains('campusmate.librarian')) return 'librarian';
  if (names.contains('campusmate.lecturer')) return 'lecturer';
  return 'student';
}

/// Presentation-only navigation gate for the privileged area.
/// Server endpoints remain the source of truth for authorization.
bool canAccessPrivilegedArea(String role) =>
    role == 'admin' || role == 'librarian';
