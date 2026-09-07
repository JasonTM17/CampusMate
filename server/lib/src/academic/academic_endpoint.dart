import 'package:serverpod/serverpod.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import 'academic_read_service.dart';

class AcademicEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  final _service = AcademicReadService();

  Future<AcademicOverview> getOverview(Session session) =>
      _service.getOverview(session);
}

class CoursesEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  final _service = AcademicReadService();

  Future<List<CourseSummary>> getMyCourses(
    Session session, {
    int? semesterId,
  }) => _service.getCourses(session, semesterId: semesterId);

  Future<CourseDetail> getCourseDetail(
    Session session, {
    required int offeringId,
  }) => _service.getCourseDetail(session, offeringId: offeringId);
}

class TimetableEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  final _service = AcademicReadService();

  Future<List<TimetableEntry>> getWeekly(
    Session session, {
    DateTime? weekStart,
    DateTime? now,
  }) => _service.getWeeklyTimetable(
    session,
    weekStart: weekStart,
    now: now,
  );

  Future<List<TimetableEntry>> getDaily(
    Session session, {
    DateTime? day,
    DateTime? now,
  }) => _service.getDailyTimetable(session, day: day, now: now);
}

class GradesEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  final _service = AcademicReadService();

  Future<GradeSummary> getBySemester(
    Session session, {
    int? semesterId,
  }) => _service.getGrades(session, semesterId: semesterId);

  Future<GradeSummary> getCumulative(Session session) =>
      _service.getGrades(session);
}

class ExamsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  final _service = AcademicReadService();

  Future<List<ExamSummary>> getUpcoming(Session session, {DateTime? now}) =>
      _service.getUpcomingExams(session, now: now);
}

class ProgressEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  final _service = AcademicReadService();

  Future<CurriculumProgress> getCurriculumProgress(Session session) =>
      _service.getProgress(session);
}
