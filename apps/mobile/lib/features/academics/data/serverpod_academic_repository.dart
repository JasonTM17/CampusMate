import 'dart:convert';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:campusmate_shared/campusmate_shared.dart' show CampusClock;

import '../../../core/storage/campusmate_database.dart';
import '../domain/academic_repository.dart';

abstract interface class AcademicRemoteDataSource {
  Future<AcademicOverview> getOverview();

  Future<GradeSummary> getGrades(int semesterId);

  Future<List<TimetableEntry>> getWeeklyTimetable({
    required DateTime weekStart,
    required DateTime now,
  });

  Future<CourseDetail> getCourseDetail(int offeringId);

  Future<ExamSummary> getExamDetail(int examId);
}

class ServerpodAcademicRemoteDataSource implements AcademicRemoteDataSource {
  const ServerpodAcademicRemoteDataSource(this._client);

  final Client _client;

  @override
  Future<AcademicOverview> getOverview() => _client.academic.getOverview();

  @override
  Future<GradeSummary> getGrades(int semesterId) =>
      _client.grades.getBySemester(semesterId: semesterId);

  @override
  Future<List<TimetableEntry>> getWeeklyTimetable({
    required DateTime weekStart,
    required DateTime now,
  }) => _client.timetable.getWeekly(weekStart: weekStart, now: now);

  @override
  Future<CourseDetail> getCourseDetail(int offeringId) =>
      _client.courses.getCourseDetail(offeringId: offeringId);

  @override
  Future<ExamSummary> getExamDetail(int examId) =>
      _client.exams.getDetail(examId: examId);
}

class ServerpodAcademicRepository implements AcademicRepository {
  const ServerpodAcademicRepository(this._remote, this._database);

  final AcademicRemoteDataSource _remote;
  final CampusMateDatabase _database;

  @override
  Future<AcademicSnapshot> loadDashboard({
    required String accountId,
    DateTime? now,
    DateTime? weekStart,
    int? semesterId,
  }) async {
    final reference = now?.toUtc() ?? CampusClock.nowUtc();
    final selectedWeekStart = CampusClock.startOfCampusWeekUtc(
      weekStart ?? reference,
    );
    final weekStartKey = CampusClock.campusDateKey(selectedWeekStart);
    final semesterKey = semesterId?.toString() ?? 'current';
    final cached = await _readCachedSnapshot(
      accountId: accountId,
      weekStartKey: weekStartKey,
      semesterKey: semesterKey,
    );

    try {
      final overview = await _remote.getOverview();
      final grades = await _remote.getGrades(
        semesterId ?? overview.currentSemester.id,
      );
      final timetable = await _remote.getWeeklyTimetable(
        weekStart: selectedWeekStart,
        now: reference,
      );
      final syncedAt = DateTime.now().toUtc();
      await _database.replaceAcademicSnapshot(
        accountId: accountId,
        weekStartKey: weekStartKey,
        semesterKey: semesterKey,
        profilePayloadJson: jsonEncode(overview.toJson()),
        timetablePayloadJson: jsonEncode([
          for (final row in timetable) row.toJson(),
        ]),
        gradesPayloadJson: jsonEncode(grades.toJson()),
        syncedAt: syncedAt,
      );
      return AcademicSnapshot(
        overview: overview,
        weeklyTimetable: timetable,
        grades: grades,
        isFromCache: false,
        cachedAt: syncedAt,
      );
    } on Object {
      if (cached != null) return cached;
      rethrow;
    }
  }

  @override
  Future<CourseDetail> loadCourseDetail({required int offeringId}) =>
      _remote.getCourseDetail(offeringId);

  @override
  Future<ExamSummary> loadExamDetail({required int examId}) =>
      _remote.getExamDetail(examId);

  Future<AcademicSnapshot?> _readCachedSnapshot({
    required String accountId,
    required String weekStartKey,
    required String semesterKey,
  }) async {
    final profile = await _database.readAcademicProfile(accountId);
    final timetable = await _database.readTimetable(accountId, weekStartKey);
    final grades = await _database.readGrades(accountId, semesterKey);
    if (profile == null || timetable == null || grades == null) return null;

    return AcademicSnapshot(
      overview: AcademicOverview.fromJson(jsonDecode(profile.payloadJson)),
      weeklyTimetable: [
        for (final row in jsonDecode(timetable.payloadJson) as List)
          TimetableEntry.fromJson(row as Map<String, dynamic>),
      ],
      grades: GradeSummary.fromJson(jsonDecode(grades.payloadJson)),
      isFromCache: true,
      cachedAt: profile.syncedAt,
    );
  }
}
