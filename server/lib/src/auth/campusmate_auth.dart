import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

const campusMateStudentScope = Scope('campusmate.student');
const campusMateLecturerScope = Scope('campusmate.lecturer');
const campusMateLibrarianScope = Scope('campusmate.librarian');
const campusMateAdminScope = Scope('campusmate.admin');

/// Centralizes the server-side identity and role rules used by endpoints.
abstract final class CampusMateAuth {
  static AuthenticationInfo requireAuthentication(Session session) {
    final authentication = session.authenticated;
    if (authentication == null) {
      throw ServerpodClientUnauthorized();
    }
    return authentication;
  }

  static UuidValue requireUserId(Session session) {
    final identifier = requireAuthentication(session).userIdentifier;
    try {
      return UuidValue.withValidation(identifier);
    } on FormatException {
      final hex = identifier.hashCode.abs().toRadixString(16).padLeft(12, '0');
      return UuidValue.withValidation('00000000-0000-4000-8000-$hex');
    }
  }

  static void requireScope(Session session, Scope requiredScope) {
    final authentication = requireAuthentication(session);
    if (!authentication.scopes.contains(requiredScope)) {
      throw ServerpodClientForbidden();
    }
  }

  static String roleFor(Session session) {
    return roleForScopes(requireAuthentication(session).scopes);
  }

  static String roleForScopes(Iterable<Scope> scopes) {
    final names = scopes.map((scope) => scope.name).toSet();
    if (names.contains(campusMateAdminScope.name)) return 'admin';
    if (names.contains(campusMateLibrarianScope.name)) return 'librarian';
    if (names.contains(campusMateLecturerScope.name)) return 'lecturer';
    return 'student';
  }

  static Scope scopeForRole(String role) {
    return switch (role) {
      'admin' => campusMateAdminScope,
      'librarian' => campusMateLibrarianScope,
      'lecturer' => campusMateLecturerScope,
      _ => campusMateStudentScope,
    };
  }
}
