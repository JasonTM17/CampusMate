import 'package:serverpod/serverpod.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import 'dashboard_service.dart';

class DashboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  final _service = DashboardService();

  Future<DashboardGreeting> getGreeting(Session session, {DateTime? now}) =>
      _service.getGreeting(session, now: now);

  Future<DashboardAcademicSummary> getAcademicSummary(Session session) =>
      _service.getAcademicSummary(session);

  Future<List<TimetableEntry>> getTodayClasses(
    Session session, {
    DateTime? now,
  }) => _service.getTodayClasses(session, now: now);

  Future<TimetableEntry?> getNextClass(Session session, {DateTime? now}) =>
      _service.getNextClass(session, now: now);

  Future<ExamSummary?> getUpcomingExam(Session session, {DateTime? now}) =>
      _service.getUpcomingExam(session, now: now);

  Future<List<AnnouncementSummary>> getAnnouncements(
    Session session, {
    int limit = 5,
  }) => _service.getAnnouncements(session, limit: limit);
}
