import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';

/// Authenticated student profile operations.
///
/// The endpoint deliberately exposes no user-id parameter. The authenticated
/// session is the only source of ownership for reads and writes.
class StudentProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  Future<StudentProfile> getMyProfile(Session session) async {
    final authUserId = CampusMateAuth.requireUserId(session);
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(authUserId),
    );

    if (profile == null) {
      return _createMyProfile(session, authUserId);
    }

    final currentRole = CampusMateAuth.roleFor(session);
    if (profile.role != currentRole) {
      profile.role = currentRole;
      profile.updatedAt = DateTime.now().toUtc();
      await StudentProfile.db.updateRow(session, profile);
    }
    return profile;
  }

  /// Inserts the caller's profile, tolerating a concurrent first read: the
  /// unique auth-user index makes the losing insert fail, so re-read the row
  /// the winner created instead of surfacing a database error.
  Future<StudentProfile> _createMyProfile(
    Session session,
    UuidValue authUserId,
  ) async {
    final now = DateTime.now().toUtc();
    try {
      return await StudentProfile.db.insertRow(
        session,
        StudentProfile(
          authUserId: authUserId,
          role: CampusMateAuth.roleFor(session),
          createdAt: now,
          updatedAt: now,
        ),
      );
    } on Exception {
      final existing = await StudentProfile.db.findFirstRow(
        session,
        where: (table) => table.authUserId.equals(authUserId),
      );
      if (existing != null) return existing;
      rethrow;
    }
  }

  /// Updates the fields that a student may edit themselves.
  ///
  /// Student code, academic results, faculty and major remain server-managed
  /// so client input cannot rewrite institutional data.
  Future<StudentProfile> updateMyProfile(
    Session session, {
    required String fullName,
    required String className,
  }) async {
    final authUserId = CampusMateAuth.requireUserId(session);
    final normalizedFullName = _normalizeRequired(fullName, 'fullName');
    final normalizedClassName = _normalizeRequired(className, 'className');
    var profile = await StudentProfile.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(authUserId),
    );
    final now = DateTime.now().toUtc();

    if (profile == null) {
      profile = StudentProfile(
        authUserId: authUserId,
        fullName: normalizedFullName,
        className: normalizedClassName,
        role: CampusMateAuth.roleFor(session),
        createdAt: now,
        updatedAt: now,
      );
      try {
        return await StudentProfile.db.insertRow(session, profile);
      } on Exception {
        // Concurrent update lost the create race: persist onto the row the
        // winner created instead of surfacing a database error.
        final existing = await StudentProfile.db.findFirstRow(
          session,
          where: (table) => table.authUserId.equals(authUserId),
        );
        if (existing == null) rethrow;
        profile = existing;
      }
    }

    profile.fullName = normalizedFullName;
    profile.className = normalizedClassName;
    profile.role = CampusMateAuth.roleFor(session);
    profile.updatedAt = now;
    return StudentProfile.db.updateRow(session, profile);
  }

  String _normalizeRequired(String value, String fieldName) {
    final normalized = value.trim();
    if (normalized.isEmpty || normalized.length > 120) {
      throw ServerpodClientException(
        'Invalid profile field: $fieldName',
        HttpStatus.badRequest,
      );
    }
    return normalized;
  }
}
