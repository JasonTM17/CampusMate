import 'package:serverpod/serverpod.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import 'admin_service.dart';

/// Primary administration surface.
///
/// Protected strictly by `campusMateAdminScope`. Non-admin roles (librarian,
/// lecturer, student) are rejected at the Serverpod scope boundary.
class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateAdminScope};

  final _service = AdminService();

  Future<String> getAccessSummary(Session session) async {
    CampusMateAuth.requireScope(session, campusMateAdminScope);
    return 'admin-access-granted';
  }

  Future<AdminDashboardStats> getDashboardStats(Session session) =>
      _service.getDashboardStats(session);

  Future<AdminStudentPage> listStudents(
    Session session, {
    String? query,
    String? faculty,
    String? status,
    int? limit,
    String? cursor,
  }) => _service.listStudents(
    session,
    query: query,
    faculty: faculty,
    status: status,
    limit: limit ?? 20,
    cursor: cursor,
  );

  Future<AdminStudentDetail> getStudentDetail(
    Session session, {
    required int profileId,
  }) => _service.getStudentDetail(session, profileId: profileId);

  Future<StudentProfile> createStudent(
    Session session, {
    required String email,
    required String password,
    required String studentCode,
    required String fullName,
    required String className,
    String? faculty,
    String? major,
  }) => _service.createStudent(
    session,
    email: email,
    password: password,
    studentCode: studentCode,
    fullName: fullName,
    className: className,
    faculty: faculty,
    major: major,
  );

  Future<StudentProfile> updateStudent(
    Session session, {
    required int profileId,
    String? studentCode,
    String? fullName,
    String? className,
    String? faculty,
    String? major,
    double? gpa,
    int? credits,
    double? conductScore,
  }) => _service.updateStudent(
    session,
    profileId: profileId,
    studentCode: studentCode,
    fullName: fullName,
    className: className,
    faculty: faculty,
    major: major,
    gpa: gpa,
    credits: credits,
    conductScore: conductScore,
  );

  Future<StudentProfile> setStudentStatus(
    Session session, {
    required int profileId,
    required bool isActive,
  }) => _service.setStudentStatus(
    session,
    profileId: profileId,
    isActive: isActive,
  );

  Future<AdminAnnouncementPage> listAnnouncements(
    Session session, {
    bool? includeArchived,
    int? limit,
    String? cursor,
  }) => _service.listAnnouncements(
    session,
    includeArchived: includeArchived ?? true,
    limit: limit ?? 20,
    cursor: cursor,
  );

  Future<Announcement> createAnnouncement(
    Session session, {
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
    DateTime? expiresAt,
  }) => _service.createAnnouncement(
    session,
    title: title,
    body: body,
    audience: audience,
    publishAt: publishAt,
    expiresAt: expiresAt,
  );

  Future<Announcement> updateAnnouncement(
    Session session, {
    required int announcementId,
    String? title,
    String? body,
    String? audience,
    DateTime? publishAt,
    DateTime? expiresAt,
    bool? archived,
  }) => _service.updateAnnouncement(
    session,
    announcementId: announcementId,
    title: title,
    body: body,
    audience: audience,
    publishAt: publishAt,
    expiresAt: expiresAt,
    archived: archived,
  );

  Future<Announcement> archiveAnnouncement(
    Session session, {
    required int announcementId,
  }) => _service.archiveAnnouncement(
    session,
    announcementId: announcementId,
  );

  Future<AdminAuditLogPage> listAuditLogs(
    Session session, {
    String? actorUserId,
    String? action,
    String? resourceType,
    int? limit,
    String? cursor,
  }) => _service.listAuditLogs(
    session,
    actorUserId: actorUserId,
    action: action,
    resourceType: resourceType,
    limit: limit ?? 20,
    cursor: cursor,
  );
}
