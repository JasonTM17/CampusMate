import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../academic/academic_read_service.dart';
import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';

class DashboardService {
  DashboardService({AcademicReadService? academic})
    : _academic = academic ?? AcademicReadService();

  final AcademicReadService _academic;

  Future<DashboardGreeting> getGreeting(
    Session session, {
    DateTime? now,
  }) async {
    final profile = await _requireStudentProfile(session);
    final reference = (now ?? CampusClock.nowUtc()).toUtc();
    final campusHour = reference.toUtc().add(const Duration(hours: 7)).hour;
    final prefix = switch (campusHour) {
      < 11 => 'Chào buổi sáng',
      < 14 => 'Chào buổi trưa',
      < 18 => 'Chào buổi chiều',
      _ => 'Chào buổi tối',
    };
    final name = profile.fullName?.trim();

    return DashboardGreeting(
      message: name == null || name.isEmpty ? '$prefix, bạn' : '$prefix, $name',
      studentName: name == null || name.isEmpty ? null : name,
      generatedAt: reference,
    );
  }

  Future<DashboardAcademicSummary> getAcademicSummary(Session session) async {
    final overview = await _academic.getOverview(session);
    return DashboardAcademicSummary(
      semesterName: overview.currentSemester.name,
      semesterGpa: overview.semesterGpa,
      cumulativeGpa: overview.cumulativeGpa,
      semesterCredits: overview.courses.fold<int>(
        0,
        (total, course) => total + course.credits,
      ),
      creditsEarned: overview.creditsEarned,
      creditsRequired: overview.creditsRequired,
      percentComplete: overview.progress.percentComplete,
      activeCourses: overview.courses.length,
    );
  }

  Future<List<TimetableEntry>> getTodayClasses(
    Session session, {
    DateTime? now,
  }) {
    final reference = (now ?? CampusClock.nowUtc()).toUtc();
    return _academic.getDailyTimetable(
      session,
      day: reference,
      now: reference,
    );
  }

  Future<TimetableEntry?> getNextClass(
    Session session, {
    DateTime? now,
  }) async {
    final reference = (now ?? CampusClock.nowUtc()).toUtc();
    final currentWeek = await _academic.getWeeklyTimetable(
      session,
      weekStart: reference,
      now: reference,
    );
    final upcomingThisWeek =
        currentWeek.where((row) => !row.startsAt.isBefore(reference)).toList()
          ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    if (upcomingThisWeek.isNotEmpty) return upcomingThisWeek.first;

    final nextWeek = await _academic.getWeeklyTimetable(
      session,
      weekStart: reference.add(const Duration(days: 7)),
      now: reference,
    );
    nextWeek.sort((a, b) => a.startsAt.compareTo(b.startsAt));
    return nextWeek.isEmpty ? null : nextWeek.first;
  }

  Future<ExamSummary?> getUpcomingExam(
    Session session, {
    DateTime? now,
  }) async {
    final exams = await _academic.getUpcomingExams(session, now: now);
    return exams.isEmpty ? null : exams.first;
  }

  Future<List<AnnouncementSummary>> getAnnouncements(
    Session session, {
    DateTime? now,
    int limit = 5,
  }) async {
    await _requireStudentProfile(session);
    final normalizedLimit = limit.clamp(1, 20).toInt();
    final reference = (now ?? CampusClock.nowUtc()).toUtc();
    final rows = await Announcement.db.find(
      session,
      where: (t) =>
          t.archived.equals(false) &
          t.audience.inSet({'all', 'student'}) &
          (t.publishAt <= reference) &
          (t.expiresAt.equals(null) | (t.expiresAt > reference)),
      orderBy: (t) => t.publishAt,
      orderDescending: true,
      limit: normalizedLimit,
    );

    return rows
        .where((row) => row.id != null)
        .map(
          (row) => AnnouncementSummary(
            id: row.id!,
            title: row.title,
            body: row.body,
            audience: row.audience,
            publishAt: row.publishAt,
            expiresAt: row.expiresAt,
          ),
        )
        .toList();
  }

  Future<StudentProfile> _requireStudentProfile(Session session) async {
    final authUserId = CampusMateAuth.requireUserId(session);
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (profile?.id == null) {
      throw ServerpodClientException('Student profile not found', 404);
    }
    return profile!;
  }
}
