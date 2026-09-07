import 'package:campusmate/app/app.dart';
import 'package:campusmate/features/academics/application/academic_controller.dart';
import 'package:campusmate/features/academics/domain/academic_repository.dart';
import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _AuthenticatedAuthRepository implements AuthRepository {
  @override
  Future<AuthUser> signIn({required String email, required String password}) =>
      throw UnimplementedError();

  @override
  Future<UuidValue> startRegistration({required String email}) =>
      throw UnimplementedError();

  @override
  Future<String> verifyRegistrationCode({
    required UuidValue accountRequestId,
    required String verificationCode,
  }) => throw UnimplementedError();

  @override
  Future<AuthUser> completeRegistration({
    required String email,
    required String registrationToken,
    required String password,
  }) => throw UnimplementedError();

  @override
  Future<UuidValue> startPasswordReset({required String email}) =>
      throw UnimplementedError();

  @override
  Future<String> verifyPasswordResetCode({
    required UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => throw UnimplementedError();

  @override
  Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => throw UnimplementedError();

  @override
  Future<AuthUser?> restore() async => const AuthUser(
    authUserId: '00000000-0000-4000-8000-000000000101',
    email: 'student001@campusmate.local',
  );

  @override
  Future<void> signOut() async {}
}

class _AcademicRepository implements AcademicRepository {
  _AcademicRepository(this.snapshot);

  final AcademicSnapshot snapshot;
  final requestedWeeks = <DateTime?>[];
  final requestedSemesters = <int?>[];

  @override
  Future<AcademicSnapshot> loadDashboard({
    required String accountId,
    DateTime? now,
    DateTime? weekStart,
    int? semesterId,
  }) async {
    expect(accountId, '00000000-0000-4000-8000-000000000101');
    requestedWeeks.add(weekStart);
    requestedSemesters.add(semesterId);
    return snapshot;
  }

  @override
  Future<CourseDetail> loadCourseDetail({required int offeringId}) async {
    expect(offeringId, 11);
    return CourseDetail(
      summary: snapshot.overview.courses.first,
      description: 'Chi tiết môn học.',
      faculty: 'Công nghệ thông tin',
      department: 'Chuyên ngành',
      schedules: snapshot.weeklyTimetable.take(1).toList(),
      grades: const [],
      documentsPlaceholder: 'Tài liệu sẽ có ở phase thư viện.',
      relatedBooksPlaceholder: 'Sách liên quan sẽ có ở phase catalog.',
      askAiPlaceholder: 'Ask AI sẽ nối ở phase personalized AI.',
    );
  }
}

void main() {
  testWidgets('academic tab renders GPA, current classes, and conflicts', (
    tester,
  ) async {
    final repository = _AcademicRepository(_snapshot(isFromCache: false));
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Học tập'));
    await tester.pumpAndSettle();

    expect(find.text('GPA kỳ'), findsWidgets);
    expect(find.text('3.20'), findsOneWidget);

    await tester.tap(find.text('Lịch học'));
    await tester.pumpAndSettle();

    expect(find.text('Đang học'), findsNWidgets(2));
    expect(find.text('Trùng lịch'), findsNWidgets(2));

    await tester.tap(find.text('Ngày'));
    await tester.pumpAndSettle();
    expect(find.text('Thứ 2'), findsWidgets);

    await tester.tap(find.byTooltip('Tuần sau'));
    await tester.pumpAndSettle();
    expect(repository.requestedWeeks.whereType<DateTime>(), isNotEmpty);
  });

  testWidgets('academic tab shows an offline badge for cached data', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(_AcademicRepository(_snapshot(isFromCache: true))),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Học tập'));
    await tester.pumpAndSettle();

    expect(find.text('Đang xem dữ liệu offline'), findsOneWidget);
    expect(find.textContaining('Đồng bộ lần cuối'), findsOneWidget);
  });

  testWidgets(
    'academic overview opens course detail and grade semester picker',
    (tester) async {
      final repository = _AcademicRepository(_snapshot(isFromCache: false));
      await tester.pumpWidget(_app(repository));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Học tập'));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('SE214'));
      await tester.pumpAndSettle();
      expect(find.text('Chi tiết môn học.'), findsOneWidget);

      await tester.tap(find.byTooltip('Đóng'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Điểm'));
      await tester.pumpAndSettle();
      expect(find.text('Học kỳ'), findsOneWidget);
      expect(find.text('Học kỳ 1 2026'), findsOneWidget);
      await tester.tap(find.text('Học kỳ 1 2026'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Học kỳ 2 2025').last);
      await tester.pumpAndSettle();
      expect(repository.requestedSemesters.last, 2);
    },
  );
}

Widget _app(_AcademicRepository repository) => ProviderScope(
  overrides: [
    authRepositoryProvider.overrideWithValue(_AuthenticatedAuthRepository()),
    academicRepositoryProvider.overrideWithValue(repository),
  ],
  child: const CampusMateApp(),
);

AcademicSnapshot _snapshot({required bool isFromCache}) {
  final semester = SemesterSummary(
    id: 1,
    code: '2026-HK1',
    name: 'Học kỳ 1 2026',
    startsAt: DateTime.utc(2026, 9, 7),
    endsAt: DateTime.utc(2026, 12, 27),
    isCurrent: true,
  );
  final historicalSemester = SemesterSummary(
    id: 2,
    code: '2025-HK2',
    name: 'Học kỳ 2 2025',
    startsAt: DateTime.utc(2026, 2, 9),
    endsAt: DateTime.utc(2026, 5, 31),
    isCurrent: false,
  );
  final courses = [
    _course(11, 'SE214', 'Lập trình di động'),
    _course(12, 'DB202', 'Cơ sở dữ liệu'),
  ];
  final timetable = [
    _entry(31, 11, 'SE214', 'Lập trình di động'),
    _entry(32, 12, 'DB202', 'Cơ sở dữ liệu'),
  ];
  final progress = CurriculumProgress(
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
  final grades = GradeSummary(
    semester: semester,
    courses: courses,
    semesterGpa: 3.2,
    cumulativeGpa: 3.1,
    creditsEarned: 28,
    creditsAttempted: 31,
  );

  return AcademicSnapshot(
    overview: AcademicOverview(
      currentSemester: semester,
      availableSemesters: [semester, historicalSemester],
      courses: courses,
      today: timetable,
      upcomingExams: [
        ExamSummary(
          examId: 41,
          offeringId: 11,
          courseCode: 'SE214',
          title: 'Lập trình di động',
          examType: 'Giữa kỳ',
          startsAt: DateTime.utc(2026, 10, 20, 2),
          endsAt: DateTime.utc(2026, 10, 20, 3, 30),
          room: 'A101',
          daysUntil: 43,
        ),
      ],
      progress: progress,
      semesterGpa: 3.2,
      cumulativeGpa: 3.1,
      creditsEarned: 28,
      creditsRequired: 140,
      syncedAt: DateTime.utc(2026, 9, 7, 3),
    ),
    weeklyTimetable: timetable,
    grades: grades,
    isFromCache: isFromCache,
    cachedAt: DateTime.utc(2026, 9, 7, 3),
  );
}

CourseSummary _course(int offeringId, String code, String title) =>
    CourseSummary(
      offeringId: offeringId,
      courseCode: code,
      title: title,
      credits: 4,
      lecturerName: 'ThS. Nguyễn Thu Hà',
      section: 'N1',
      status: 'active',
      progressPercent: 58,
      attendancePercent: 92,
      finalScore: 8.1,
      letter: 'B+',
    );

TimetableEntry _entry(
  int scheduleId,
  int offeringId,
  String code,
  String title,
) => TimetableEntry(
  scheduleId: scheduleId,
  offeringId: offeringId,
  courseCode: code,
  title: title,
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
