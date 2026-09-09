import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

import 'package:campusmate/app/app.dart';
import 'package:campusmate/features/dashboard/application/dashboard_controller.dart';
import 'package:campusmate/features/dashboard/domain/dashboard_repository.dart';
import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';
import 'package:campusmate/features/library/application/library_controller.dart';
import 'package:campusmate/features/library/domain/library_repository.dart';
import 'package:campusmate/features/notifications/application/notification_controller.dart';
import 'package:campusmate/features/notifications/domain/notification_repository.dart';

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
    authUserId: '00000000-0000-4000-8000-000000000001',
    email: 'student001@campusmate.local',
  );

  @override
  Future<void> signOut() async {}
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
      semesterGpa: 3.2,
      cumulativeGpa: 3.1,
      semesterCredits: 8,
      creditsEarned: 28,
      creditsRequired: 140,
      percentComplete: 20,
      activeCourses: 2,
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

class _LibraryRepository implements LibraryRepository {
  @override
  Future<LibraryExplore> explore({int limitPerSection = 8}) async {
    return LibraryExplore(
      sections: [
        LibraryExploreSection(
          key: 'featured',
          title: 'Nổi bật',
          items: [_book()],
        ),
      ],
      filterOptions: LibraryFilterOptions(
        languages: const ['vi'],
        categories: const ['Mobile Development'],
        authors: const ['CampusMate Lab'],
        years: const [2026],
        accessTypes: const [BookAccessType.publicFullText],
        formats: const ['PDF'],
      ),
    );
  }

  @override
  Future<LibrarySearchPage> search({
    String? query,
    String? cursor,
    int limit = 20,
    LibraryFilters filters = const LibraryFilters(),
  }) async {
    return LibrarySearchPage(items: [_book()], totalCount: 1);
  }

  @override
  Future<BookDetail> getBookDetail({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookFavoriteStatus> toggleFavorite({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookLoanSummary> borrowBook({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookLoanSummary> returnLoan({required int loanId}) =>
      throw UnimplementedError();

  @override
  Future<BookLoanPage> myLoans({
    String? cursor,
    int limit = 20,
    bool activeOnly = true,
  }) => throw UnimplementedError();

  @override
  Future<List<BookLoanSummary>> activeLoansForBook({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookAccessPolicyUpdate> updateAccessPolicy({
    required int bookId,
    required BookAccessType accessType,
  }) => throw UnimplementedError();
}

void main() {
  testWidgets('app boots into the 5-tab shell with Vietnamese default locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            _AuthenticatedAuthRepository(),
          ),
          dashboardRepositoryProvider.overrideWithValue(_DashboardRepository()),
          libraryRepositoryProvider.overrideWithValue(_LibraryRepository()),
          notificationRepositoryProvider.overrideWithValue(
            _NotificationRepository(),
          ),
        ],
        child: const CampusMateApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Vietnamese is the default locale (§46).
    expect(find.text('Trang chủ'), findsWidgets);
    expect(find.text('Học tập'), findsOneWidget);
    expect(find.text('Thư viện'), findsOneWidget);
    expect(find.text('AI'), findsOneWidget);
    expect(find.text('Cá nhân'), findsOneWidget);

    // Switching branches renders the real library catalog now that Phase 05 is active.
    await tester.tap(find.text('Thư viện'));
    await tester.pumpAndSettle();
    expect(find.text('CampusMate Notes'), findsWidgets);
    await tester.drag(
      find.byKey(const Key('library-scroll-view')),
      const Offset(0, -700),
    );
    await tester.pumpAndSettle();
    expect(find.text('Tất cả tài liệu'), findsOneWidget);
  });
}

BookSummary _book() {
  return BookSummary(
    id: 1,
    title: 'CampusMate Notes',
    description: 'Demo library record.',
    publisher: 'CampusMate Lab',
    publishedYear: 2026,
    language: 'vi',
    accessType: BookAccessType.publicFullText,
    license: 'CampusMate demo',
    authors: const ['CampusMate Lab'],
    categories: const ['Mobile Development'],
    courseCodes: const ['SE214'],
    availableFormats: const ['PDF'],
    isFavorite: false,
    access: BookAccessDecision(
      role: 'student',
      canRead: true,
      canDownload: true,
      canBorrow: false,
    ),
  );
}
