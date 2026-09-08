import 'dart:async';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/app/app.dart';
import 'package:campusmate/app/router/app_router.dart';
import 'package:campusmate/features/academics/application/academic_controller.dart';
import 'package:campusmate/features/academics/domain/academic_repository.dart';
import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';
import 'package:campusmate/features/dashboard/application/dashboard_controller.dart';
import 'package:campusmate/features/dashboard/domain/dashboard_repository.dart';
import 'package:campusmate/features/notifications/application/notification_controller.dart';
import 'package:campusmate/features/notifications/domain/notification_repository.dart';

class _UnauthenticatedRepository implements AuthRepository {
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
  Future<AuthUser?> restore() async => null;

  @override
  Future<void> signOut() async {}
}

class _DelayedRestoreRepository implements AuthRepository {
  final _restore = Completer<AuthUser?>();

  void completeRestore(AuthUser? user) {
    _restore.complete(user);
  }

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
  Future<AuthUser?> restore() => _restore.future;

  @override
  Future<void> signOut() async {}
}

class _AcademicRepository implements AcademicRepository {
  final loadedExamIds = <int>[];

  @override
  Future<AcademicSnapshot> loadDashboard({
    required String accountId,
    DateTime? now,
    DateTime? weekStart,
    int? semesterId,
  }) async {
    final semester = _semester();
    return AcademicSnapshot(
      overview: AcademicOverview(
        currentSemester: semester,
        availableSemesters: [semester],
        courses: const [],
        today: const [],
        upcomingExams: [_exam(41)],
        progress: CurriculumProgress(
          blocks: [],
          creditsEarned: 0,
          creditsRequired: 140,
          percentComplete: 0,
        ),
        semesterGpa: 0,
        cumulativeGpa: 0,
        creditsEarned: 0,
        creditsRequired: 140,
        syncedAt: DateTime.utc(2026, 9, 8),
      ),
      weeklyTimetable: const [],
      grades: GradeSummary(
        semester: semester,
        courses: const [],
        semesterGpa: 0,
        cumulativeGpa: 0,
        creditsEarned: 0,
        creditsAttempted: 0,
      ),
      isFromCache: false,
      cachedAt: DateTime.utc(2026, 9, 8),
    );
  }

  @override
  Future<CourseDetail> loadCourseDetail({required int offeringId}) =>
      throw UnimplementedError();

  @override
  Future<ExamSummary> loadExamDetail({required int examId}) async {
    loadedExamIds.add(examId);
    return _exam(examId);
  }
}

class _DashboardRepository implements DashboardRepository {
  @override
  Future<DashboardGreeting> loadGreeting({DateTime? now}) async {
    return DashboardGreeting(
      message: 'Chào buổi sáng',
      generatedAt: DateTime.utc(2026, 9, 8),
    );
  }

  @override
  Future<DashboardAcademicSummary> loadAcademicSummary() async {
    return DashboardAcademicSummary(
      semesterName: 'Học kỳ 1 2026',
      semesterGpa: 0,
      cumulativeGpa: 0,
      semesterCredits: 0,
      creditsEarned: 0,
      creditsRequired: 140,
      percentComplete: 0,
      activeCourses: 0,
    );
  }

  @override
  Future<List<TimetableEntry>> loadTodayClasses({DateTime? now}) async => [];

  @override
  Future<TimetableEntry?> loadNextClass({DateTime? now}) async => null;

  @override
  Future<ExamSummary?> loadUpcomingExam({DateTime? now}) async => null;

  @override
  Future<List<AnnouncementSummary>> loadAnnouncements({int limit = 5}) async =>
      [];
}

class _NotificationRepository implements NotificationRepository {
  @override
  Future<NotificationListPage> list({
    String? cursor,
    int limit = 20,
    String? category,
  }) async {
    return NotificationListPage(items: const [], unreadCount: 0);
  }

  @override
  Future<int> unreadCount({String? category}) async => 0;

  @override
  Future<int> markAllRead({String? category}) => throw UnimplementedError();

  @override
  Future<CampusNotificationSummary> markRead({required int notificationId}) =>
      throw UnimplementedError();
}

void main() {
  testWidgets('redirects an unauthenticated initial route to login', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            _UnauthenticatedRepository(),
          ),
        ],
        child: const CampusMateApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chào mừng trở lại'), findsOneWidget);
    expect(find.text('Trang chủ'), findsNothing);
  });

  testWidgets(
    'preserves protected exam deep links while auth restore resolves',
    (tester) async {
      final auth = _DelayedRestoreRepository();
      final academic = _AcademicRepository();
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(auth),
          academicRepositoryProvider.overrideWithValue(academic),
          dashboardRepositoryProvider.overrideWithValue(_DashboardRepository()),
          notificationRepositoryProvider.overrideWithValue(
            _NotificationRepository(),
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const CampusMateApp(),
        ),
      );
      final router = container.read(appRouterProvider);

      router.go('/academic/exams/41');
      await tester.pump();

      expect(find.text('Chi tiết lịch thi'), findsNothing);

      auth.completeRestore(
        const AuthUser(
          authUserId: '00000000-0000-4000-8000-000000000101',
          email: 'student001@campusmate.local',
        ),
      );
      await tester.pumpAndSettle();

      expect(academic.loadedExamIds, [41]);
      expect(find.text('Chi tiết lịch thi'), findsOneWidget);
      expect(find.textContaining('SE214'), findsOneWidget);
    },
  );
}

SemesterSummary _semester() => SemesterSummary(
  id: 1,
  code: '2026-HK1',
  name: 'Học kỳ 1 2026',
  startsAt: DateTime.utc(2026, 9, 7),
  endsAt: DateTime.utc(2026, 12, 27),
  isCurrent: true,
);

ExamSummary _exam(int id) => ExamSummary(
  examId: id,
  offeringId: 11,
  courseCode: 'SE214',
  title: 'Lập trình di động',
  examType: 'Giữa kỳ',
  startsAt: DateTime.utc(2026, 10, 20, 2),
  endsAt: DateTime.utc(2026, 10, 20, 3, 30),
  room: 'A101',
  daysUntil: 42,
);
