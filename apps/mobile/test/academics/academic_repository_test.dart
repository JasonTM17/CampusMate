import 'package:campusmate/features/academics/data/serverpod_academic_repository.dart';
import 'package:campusmate/core/storage/campusmate_database.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('falls back to the Drift cache when the remote refresh fails', () async {
    final database = CampusMateDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final online = ServerpodAcademicRepository(
      _AcademicRemoteFixture(),
      database,
    );
    final refreshed = await online.loadDashboard(
      accountId: 'account-a',
      now: DateTime.utc(2026, 9, 7, 10),
    );
    expect(refreshed.isFromCache, isFalse);
    expect(refreshed.overview.courses, hasLength(1));

    final offline = ServerpodAcademicRepository(
      _FailingAcademicRemote(),
      database,
    );
    final cached = await offline.loadDashboard(
      accountId: 'account-a',
      now: DateTime.utc(2026, 9, 7, 10),
    );

    expect(cached.isFromCache, isTrue);
    expect(cached.overview.currentSemester.code, '2026-HK1');
    expect(cached.weeklyTimetable.single.isCurrent, isTrue);
    expect(cached.grades.semesterGpa, 3.2);
  });

  test('partitions cached academic data by account id', () async {
    final database = CampusMateDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await ServerpodAcademicRepository(
      _AcademicRemoteFixture(),
      database,
    ).loadDashboard(accountId: 'account-a', now: DateTime.utc(2026, 9, 7));

    await expectLater(
      ServerpodAcademicRepository(
        _FailingAcademicRemote(),
        database,
      ).loadDashboard(accountId: 'account-b', now: DateTime.utc(2026, 9, 7)),
      throwsA(isA<StateError>()),
    );
  });
}

class _AcademicRemoteFixture implements AcademicRemoteDataSource {
  @override
  Future<AcademicOverview> getOverview() async => AcademicOverview(
    currentSemester: _semester,
    availableSemesters: [_semester, _historicalSemester],
    courses: [_course],
    today: [_timetable],
    upcomingExams: [_exam],
    progress: _progress,
    semesterGpa: 3.2,
    cumulativeGpa: 3.1,
    creditsEarned: 28,
    creditsRequired: 140,
    syncedAt: DateTime.utc(2026, 9, 7, 3),
  );

  @override
  Future<GradeSummary> getGrades(int semesterId) async => GradeSummary(
    semester: _semester,
    courses: [_course],
    semesterGpa: 3.2,
    cumulativeGpa: 3.1,
    creditsEarned: 28,
    creditsAttempted: 31,
  );

  @override
  Future<List<TimetableEntry>> getWeeklyTimetable({
    required DateTime weekStart,
    required DateTime now,
  }) async => [_timetable];

  @override
  Future<CourseDetail> getCourseDetail(int offeringId) async => CourseDetail(
    summary: _course,
    description: 'Chi tiết môn học.',
    faculty: 'Công nghệ thông tin',
    department: 'Chuyên ngành',
    schedules: [_timetable],
    grades: const [],
    documentsPlaceholder: 'Tài liệu sẽ có ở phase thư viện.',
    relatedBooksPlaceholder: 'Sách liên quan sẽ có ở phase catalog.',
    askAiPlaceholder: 'Ask AI sẽ nối ở phase personalized AI.',
  );
}

class _FailingAcademicRemote implements AcademicRemoteDataSource {
  @override
  Future<AcademicOverview> getOverview() async =>
      throw StateError('network unavailable');

  @override
  Future<GradeSummary> getGrades(int semesterId) async =>
      throw StateError('network unavailable');

  @override
  Future<List<TimetableEntry>> getWeeklyTimetable({
    required DateTime weekStart,
    required DateTime now,
  }) async => throw StateError('network unavailable');

  @override
  Future<CourseDetail> getCourseDetail(int offeringId) async =>
      throw StateError('network unavailable');
}

final _semester = SemesterSummary(
  id: 1,
  code: '2026-HK1',
  name: 'Học kỳ 1 2026',
  startsAt: DateTime.utc(2026, 9, 7),
  endsAt: DateTime.utc(2026, 12, 27),
  isCurrent: true,
);

final _historicalSemester = SemesterSummary(
  id: 2,
  code: '2025-HK2',
  name: 'Học kỳ 2 2025',
  startsAt: DateTime.utc(2026, 2, 9),
  endsAt: DateTime.utc(2026, 5, 31),
  isCurrent: false,
);

final _course = CourseSummary(
  offeringId: 11,
  courseCode: 'SE214',
  title: 'Lập trình di động',
  credits: 4,
  lecturerName: 'ThS. Nguyễn Thu Hà',
  section: 'N1',
  status: 'active',
  progressPercent: 58,
  attendancePercent: 92,
  finalScore: 8.1,
  letter: 'B+',
);

final _timetable = TimetableEntry(
  scheduleId: 31,
  offeringId: 11,
  courseCode: 'SE214',
  title: 'Lập trình di động',
  lecturerName: 'ThS. Nguyễn Thu Hà',
  weekday: 1,
  startMinute: 570,
  endMinute: 720,
  room: 'A101',
  campus: 'Cơ sở chính',
  status: 'scheduled',
  startsAt: DateTime.utc(2026, 9, 7, 2, 30),
  endsAt: DateTime.utc(2026, 9, 7, 5),
  isCurrent: true,
);

final _exam = ExamSummary(
  examId: 41,
  offeringId: 11,
  courseCode: 'SE214',
  title: 'Lập trình di động',
  examType: 'Giữa kỳ',
  startsAt: DateTime.utc(2026, 10, 20, 2),
  endsAt: DateTime.utc(2026, 10, 20, 3, 30),
  room: 'A101',
  notes: 'Mang thẻ sinh viên.',
  daysUntil: 43,
);

final _progress = CurriculumProgress(
  blocks: [
    CurriculumBlockProgress(
      name: 'Chuyên ngành',
      creditsEarned: 28,
      creditsRequired: 60,
    ),
  ],
  creditsEarned: 28,
  creditsRequired: 140,
  percentComplete: 20,
);
