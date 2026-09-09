import 'package:campusmate/app/app.dart';
import 'package:campusmate/features/academics/application/academic_controller.dart';
import 'package:campusmate/features/academics/domain/academic_repository.dart';
import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';
import 'package:campusmate/features/dashboard/application/dashboard_controller.dart';
import 'package:campusmate/features/dashboard/domain/dashboard_repository.dart';
import 'package:campusmate/features/library/application/library_controller.dart';
import 'package:campusmate/features/library/domain/library_repository.dart';
import 'package:campusmate/features/chat/application/chat_controller.dart';
import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/domain/chat_repository.dart';
import 'package:campusmate/features/notifications/application/notification_controller.dart';
import 'package:campusmate/features/notifications/domain/notification_repository.dart';
import 'package:campusmate/features/reader/domain/reader_repository.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthRepository implements AuthRepository {
  final AuthUser _user = const AuthUser(
    authUserId: '00000000-0000-4000-8000-000000000001',
    email: 'student001@campusmate.local',
    role: 'student',
  );

  @override
  Future<AuthUser?> restore() async => _user;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async => _user;

  @override
  Future<void> signOut() async {}

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
}

class _FakeDashboardRepository implements DashboardRepository {
  @override
  Future<DashboardGreeting> loadGreeting({DateTime? now}) async {
    return DashboardGreeting(
      message: 'Chào buổi sáng',
      studentName: 'Nguyễn Văn A',
      generatedAt: DateTime.utc(2026, 9, 9, 8),
    );
  }

  @override
  Future<DashboardAcademicSummary> loadAcademicSummary() async {
    return DashboardAcademicSummary(
      semesterName: 'Học kỳ 1 2026',
      semesterGpa: 3.65,
      cumulativeGpa: 3.52,
      semesterCredits: 18,
      creditsEarned: 85,
      creditsRequired: 140,
      percentComplete: 60.7,
      activeCourses: 5,
    );
  }

  @override
  Future<List<TimetableEntry>> loadTodayClasses({DateTime? now}) async {
    return [
      TimetableEntry(
        scheduleId: 101,
        offeringId: 11,
        courseCode: 'CS301',
        title: 'Lập trình Di động',
        lecturerName: 'TS. Tran Minh',
        weekday: 3,
        startMinute: 450,
        endMinute: 600,
        room: 'B1-302',
        campus: 'Cơ sở 1',
        status: 'scheduled',
        startsAt: DateTime.utc(2026, 9, 9, 7, 30),
        endsAt: DateTime.utc(2026, 9, 9, 10),
        isCurrent: true,
      ),
    ];
  }

  @override
  Future<TimetableEntry?> loadNextClass({DateTime? now}) async {
    return TimetableEntry(
      scheduleId: 101,
      offeringId: 11,
      courseCode: 'CS301',
      title: 'Lập trình Di động',
      lecturerName: 'TS. Tran Minh',
      weekday: 3,
      startMinute: 450,
      endMinute: 600,
      room: 'B1-302',
      campus: 'Cơ sở 1',
      status: 'scheduled',
      startsAt: DateTime.utc(2026, 9, 9, 7, 30),
      endsAt: DateTime.utc(2026, 9, 9, 10),
      isCurrent: true,
    );
  }

  @override
  Future<ExamSummary?> loadUpcomingExam({DateTime? now}) async {
    return ExamSummary(
      examId: 201,
      offeringId: 11,
      courseCode: 'CS301',
      title: 'Lập trình Di động',
      examType: 'Cuối kỳ',
      startsAt: DateTime.utc(2026, 9, 20, 7, 30),
      endsAt: DateTime.utc(2026, 9, 20, 9),
      room: 'A2-105',
      daysUntil: 11,
    );
  }

  @override
  Future<List<AnnouncementSummary>> loadAnnouncements({int limit = 5}) async {
    return [
      AnnouncementSummary(
        id: 301,
        title: 'Thông báo học phần bổ sung',
        body: 'Hạn chót đăng ký học phần bổ sung là ngày 15/09/2026.',
        audience: 'student',
        publishAt: DateTime.utc(2026, 9, 8),
      ),
    ];
  }
}

class _FakeNotificationRepository implements NotificationRepository {
  int unread = 2;

  @override
  Future<NotificationListPage> list({
    String? cursor,
    int limit = 20,
    String? category,
  }) async {
    return NotificationListPage(
      items: [
        CampusNotificationSummary(
          id: 501,
          category: 'academic',
          title: 'Thay đổi phòng học CS301',
          body: 'Phòng học môn CS301 sáng nay chuyển sang B1-302.',
          readAt: null,
          createdAt: DateTime.utc(2026, 9, 9, 6, 30),
        ),
      ],
      unreadCount: unread,
    );
  }

  @override
  Future<int> unreadCount({String? category}) async => unread;

  @override
  Future<int> markAllRead({String? category}) async {
    unread = 0;
    return 1;
  }

  @override
  Future<CampusNotificationSummary> markRead({
    required int notificationId,
  }) async {
    if (unread > 0) unread--;
    return CampusNotificationSummary(
      id: notificationId,
      category: 'academic',
      title: 'Thay đổi phòng học CS301',
      body: 'Phòng học môn CS301 sáng nay chuyển sang B1-302.',
      readAt: DateTime.utc(2026, 9, 9, 8),
      createdAt: DateTime.utc(2026, 9, 9, 6, 30),
    );
  }
}

class _FakeAcademicRepository implements AcademicRepository {
  @override
  Future<AcademicSnapshot> loadDashboard({
    required String accountId,
    DateTime? now,
    DateTime? weekStart,
    int? semesterId,
  }) async {
    final semester = SemesterSummary(
      id: 1,
      code: '2026-HK1',
      name: 'Học kỳ 1 2026',
      startsAt: DateTime.utc(2026, 9, 7),
      endsAt: DateTime.utc(2026, 12, 27),
      isCurrent: true,
    );
    final course = CourseSummary(
      offeringId: 11,
      courseCode: 'CS301',
      title: 'Lập trình Di động',
      credits: 3,
      lecturerName: 'TS. Tran Minh',
      section: 'N1',
      status: 'active',
      progressPercent: 65,
      attendancePercent: 100,
      finalScore: 8.5,
      letter: 'A',
    );
    final timetable = [
      TimetableEntry(
        scheduleId: 101,
        offeringId: 11,
        courseCode: 'CS301',
        title: 'Lập trình Di động',
        lecturerName: 'TS. Tran Minh',
        weekday: 3,
        startMinute: 450,
        endMinute: 600,
        room: 'B1-302',
        campus: 'Cơ sở 1',
        status: 'scheduled',
        startsAt: DateTime.utc(2026, 9, 9, 7, 30),
        endsAt: DateTime.utc(2026, 9, 9, 10),
        isCurrent: true,
      ),
    ];
    final progress = CurriculumProgress(
      blocks: [
        CurriculumBlockProgress(
          name: 'Chuyên ngành',
          creditsEarned: 85,
          creditsRequired: 140,
        ),
      ],
      creditsEarned: 85,
      creditsRequired: 140,
      percentComplete: 60.7,
    );
    final grades = GradeSummary(
      semester: semester,
      courses: [course],
      semesterGpa: 3.65,
      cumulativeGpa: 3.52,
      creditsEarned: 85,
      creditsAttempted: 85,
    );

    return AcademicSnapshot(
      overview: AcademicOverview(
        currentSemester: semester,
        availableSemesters: [semester],
        courses: [course],
        today: timetable,
        upcomingExams: [
          ExamSummary(
            examId: 201,
            offeringId: 11,
            courseCode: 'CS301',
            title: 'Lập trình Di động',
            examType: 'Cuối kỳ',
            startsAt: DateTime.utc(2026, 9, 20, 7, 30),
            endsAt: DateTime.utc(2026, 9, 20, 9),
            room: 'A2-105',
            daysUntil: 11,
          ),
        ],
        progress: progress,
        semesterGpa: 3.65,
        cumulativeGpa: 3.52,
        creditsEarned: 85,
        creditsRequired: 140,
        syncedAt: DateTime.utc(2026, 9, 9),
      ),
      weeklyTimetable: timetable,
      grades: grades,
      isFromCache: false,
      cachedAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<CourseDetail> loadCourseDetail({required int offeringId}) async {
    return CourseDetail(
      summary: CourseSummary(
        offeringId: offeringId,
        courseCode: 'CS301',
        title: 'Lập trình Di động',
        credits: 3,
        lecturerName: 'TS. Tran Minh',
        section: 'N1',
        status: 'active',
        progressPercent: 65,
        attendancePercent: 100,
        finalScore: 8.5,
        letter: 'A',
      ),
      description:
          'Khóa học lập trình ứng dụng di động chuyên sâu Flutter & Serverpod.',
      faculty: 'Khoa CNTT',
      department: 'Bộ môn CNPM',
      schedules: const [],
      grades: const [],
      documentsPlaceholder: 'Tài liệu môn học',
      relatedBooksPlaceholder: 'Sách liên quan',
      askAiPlaceholder: 'Hỏi AI về môn học',
    );
  }

  @override
  Future<ExamSummary> loadExamDetail({required int examId}) async {
    return ExamSummary(
      examId: examId,
      offeringId: 11,
      courseCode: 'CS301',
      title: 'Lập trình Di động',
      examType: 'Cuối kỳ',
      startsAt: DateTime.utc(2026, 9, 20, 7, 30),
      endsAt: DateTime.utc(2026, 9, 20, 9),
      room: 'A2-105',
      daysUntil: 11,
    );
  }
}

class _FakeLibraryRepository implements LibraryRepository {
  final BookSummary sampleBook = BookSummary(
    id: 1,
    title: 'Flutter Monorepo Handbook',
    description: 'Cẩm nang xây dựng Flutter Monorepo chuẩn doanh nghiệp.',
    publisher: 'CampusMate Publishing',
    publishedYear: 2026,
    language: 'vi',
    accessType: BookAccessType.publicFullText,
    license: 'CC-BY-4.0',
    authors: const ['Google Deepmind Team'],
    categories: const ['Mobile Dev'],
    courseCodes: const ['CS301'],
    availableFormats: const ['pdf'],
    isFavorite: false,
    access: BookAccessDecision(
      role: 'student',
      canRead: true,
      canDownload: true,
      canBorrow: true,
      reason: 'Tài liệu công khai toàn văn.',
    ),
  );

  @override
  Future<LibraryExplore> explore({int limitPerSection = 8}) async {
    return LibraryExplore(
      sections: [
        LibraryExploreSection(
          key: 'featured',
          title: 'Sách Nổi Bật',
          items: [sampleBook],
        ),
      ],
      filterOptions: LibraryFilterOptions(
        languages: const ['vi', 'en'],
        categories: const ['Mobile Dev'],
        authors: const ['Google Deepmind Team'],
        years: const [2026],
        accessTypes: const [BookAccessType.publicFullText],
        formats: const ['pdf'],
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
    return LibrarySearchPage(items: [sampleBook], totalCount: 1);
  }

  @override
  Future<BookDetail> getBookDetail({required int bookId}) async {
    return BookDetail(
      id: bookId,
      title: 'Flutter Monorepo Handbook',
      description: 'Cẩm nang xây dựng Flutter Monorepo chuẩn doanh nghiệp.',
      publisher: 'CampusMate Publishing',
      publishedYear: 2026,
      language: 'vi',
      accessType: BookAccessType.publicFullText,
      license: 'CC-BY-4.0',
      keywords: 'flutter, serverpod, mobile',
      authors: const ['Google Deepmind Team'],
      categories: const ['Mobile Dev'],
      courseCodes: const ['CS301'],
      availableFormats: const ['pdf'],
      isFavorite: false,
      access: BookAccessDecision(
        role: 'student',
        canRead: true,
        canDownload: true,
        canBorrow: true,
        reason: 'Tài liệu công khai toàn văn.',
      ),
      activeLoan: null,
      activeLoanCount: 0,
      availableCopies: 5,
    );
  }

  @override
  Future<BookFavoriteStatus> toggleFavorite({required int bookId}) async {
    return BookFavoriteStatus(bookId: bookId, isFavorite: true);
  }

  @override
  Future<BookLoanSummary> borrowBook({required int bookId}) async {
    return BookLoanSummary(
      id: 88,
      bookId: bookId,
      copyId: 101,
      title: 'Flutter Monorepo Handbook',
      status: BookLoanStatus.borrowed,
      borrowedAt: DateTime.utc(2026, 9, 9),
      dueAt: DateTime.utc(2026, 9, 23),
      returnedAt: null,
      daysRemaining: 14,
      isOverdue: false,
    );
  }

  @override
  Future<BookLoanSummary> returnLoan({required int loanId}) async {
    return BookLoanSummary(
      id: loanId,
      bookId: 1,
      copyId: 101,
      title: 'Flutter Monorepo Handbook',
      status: BookLoanStatus.returned,
      borrowedAt: DateTime.utc(2026, 9, 9),
      dueAt: DateTime.utc(2026, 9, 23),
      returnedAt: DateTime.utc(2026, 9, 9, 10),
      daysRemaining: 0,
      isOverdue: false,
    );
  }

  @override
  Future<BookLoanPage> myLoans({
    String? cursor,
    int limit = 20,
    bool activeOnly = true,
  }) async {
    return BookLoanPage(items: const [], serverNow: DateTime.utc(2026, 9, 9));
  }

  @override
  Future<List<BookLoanSummary>> activeLoansForBook({
    required int bookId,
  }) async => const [];

  @override
  Future<BookAccessPolicyUpdate> updateAccessPolicy({
    required int bookId,
    required BookAccessType accessType,
  }) async {
    return BookAccessPolicyUpdate(
      bookId: bookId,
      accessType: accessType,
      updatedAt: DateTime.utc(2026, 9, 9),
    );
  }
}

class _FakeReaderRepository implements ReaderRepository {
  ReadingProgress? savedProgress;
  int syncCalls = 0;

  @override
  Future<ReaderAsset> getReaderAsset({
    required int bookId,
    required String format,
  }) async {
    return ReaderAsset(
      bookId: bookId,
      format: format,
      assetUrl: 'https://storage.campusmate.local/books/1/content.pdf',
      expiresAt: DateTime.utc(2026, 9, 9, 12),
    );
  }

  @override
  Future<ReadingProgress?> getProgress({required int bookId}) async {
    return savedProgress;
  }

  @override
  Future<ReadingProgressSyncResult> syncProgress({
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime clientUpdatedAt,
  }) async {
    syncCalls++;
    savedProgress = ReadingProgress(
      id: 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      bookId: bookId,
      progressPercent: progressPercent,
      currentLocation: currentLocation,
      updatedAt: clientUpdatedAt,
    );
    return ReadingProgressSyncResult(
      bookId: bookId,
      progressPercent: progressPercent,
      currentLocation: currentLocation,
      updatedAt: clientUpdatedAt,
      appliedClientUpdate: true,
    );
  }

  @override
  Future<ReaderBookmark> addBookmark({
    required int bookId,
    required String location,
    required String title,
  }) async {
    return ReaderBookmark(
      id: 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      bookId: bookId,
      location: location,
      title: title,
      createdAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<List<ReaderBookmark>> getBookmarks({required int bookId}) async =>
      const [];

  @override
  Future<void> removeBookmark({required int bookmarkId}) async {}

  @override
  Future<ReaderNote> saveNote({
    required int bookId,
    required String location,
    required String content,
    int? noteId,
  }) async {
    return ReaderNote(
      id: noteId ?? 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      bookId: bookId,
      location: location,
      content: content,
      createdAt: DateTime.utc(2026, 9, 9),
      updatedAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<List<ReaderNote>> getNotes({required int bookId}) async => const [];

  @override
  Future<void> deleteNote({required int noteId}) async {}

  @override
  Future<ReaderHighlight> addHighlight({
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
  }) async {
    return ReaderHighlight(
      id: 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      bookId: bookId,
      location: location,
      text: text,
      colorToken: colorToken,
      createdAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<List<ReaderHighlight>> getHighlights({required int bookId}) async =>
      const [];

  @override
  Future<void> removeHighlight({required int highlightId}) async {}
}

class _FakeAiRepository implements AiRepository {
  StudentAiPreference pref = StudentAiPreference(
    userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
    explanationStyle: 'standard',
    personalizationEnabled: true,
    memoryEnabled: true,
    updatedAt: DateTime.utc(2026, 9, 9),
  );

  @override
  Future<StudySuggestion?> getStudySuggestion() async => StudySuggestion(
    title: 'Ôn tập Lập trình Di động',
    message: 'Kỳ thi cuối kỳ môn CS301 sắp diễn ra trong 11 ngày tới.',
    priority: 'high',
    actionLabel: 'Xem lịch thi',
    actionRoute: '/academic',
  );

  @override
  Future<List<ConversationSummary>> listConversations() async => [];

  @override
  Future<ConversationSummary> createConversation({
    required String title,
  }) async => ConversationSummary(
    id: 1,
    title: title,
    updatedAt: DateTime.utc(2026, 9, 9),
  );

  @override
  Future<void> deleteConversation(int conversationId) async {}

  @override
  Future<List<ChatMessage>> getMessages(int conversationId) async => [];

  @override
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
    int? bookId,
    String? selectedText,
  }) => Stream.fromIterable([
    'Điểm rèn luyện được đánh giá theo 5 tiêu chí. ',
    'Tham khảo Quy chế Công tác Sinh viên (Điều 8).',
  ]);

  @override
  Future<StudentAiPreference> getPreferences() async => pref;

  @override
  Future<StudentAiPreference> updatePreferences({
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) async {
    pref = StudentAiPreference(
      userId: pref.userId,
      explanationStyle: explanationStyle,
      personalizationEnabled: personalizationEnabled,
      memoryEnabled: memoryEnabled,
      updatedAt: DateTime.utc(2026, 9, 9, 10),
    );
    return pref;
  }

  @override
  Future<List<AiUserMemory>> getMemories({bool activeOnly = false}) async => [
    AiUserMemory(
      id: 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      content: 'Thích học qua ví dụ Flutter',
      source: 'user_stated',
      createdAt: DateTime.utc(2026, 9, 9),
    ),
  ];

  @override
  Future<AiUserMemory> addMemory({
    required String content,
    String? source,
  }) async => AiUserMemory(
    id: 2,
    userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
    content: content,
    source: source ?? 'user_stated',
    createdAt: DateTime.utc(2026, 9, 9),
  );

  @override
  Future<AiUserMemory> toggleMemory({
    required int memoryId,
    required bool disabled,
  }) async => AiUserMemory(
    id: memoryId,
    userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
    content: 'Thích học qua ví dụ Flutter',
    source: 'user_stated',
    createdAt: DateTime.utc(2026, 9, 9),
    disabledAt: disabled ? DateTime.utc(2026, 9, 9) : null,
  );

  @override
  Future<void> deleteMemory({required int memoryId}) async {}
}

void main() {
  Widget buildApp({
    required _FakeAuthRepository authRepo,
    required _FakeDashboardRepository dashRepo,
    required _FakeNotificationRepository notifRepo,
    required _FakeAcademicRepository acadRepo,
    required _FakeLibraryRepository libRepo,
    required _FakeReaderRepository readerRepo,
    _FakeAiRepository? aiRepo,
  }) {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepo),
        dashboardRepositoryProvider.overrideWithValue(dashRepo),
        notificationRepositoryProvider.overrideWithValue(notifRepo),
        academicRepositoryProvider.overrideWithValue(acadRepo),
        libraryRepositoryProvider.overrideWithValue(libRepo),
        readerRepositoryProvider.overrideWithValue(readerRepo),
        aiRepositoryProvider.overrideWithValue(aiRepo ?? _FakeAiRepository()),
      ],
      child: const CampusMateApp(),
    );
  }

  group('Student End-to-End Application Flows', () {
    testWidgets(
      'Flow 1: Login -> Dashboard -> Library -> Book Detail -> Reader -> Sync Progress',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        final authRepo = _FakeAuthRepository();
        final dashRepo = _FakeDashboardRepository();
        final notifRepo = _FakeNotificationRepository();
        final acadRepo = _FakeAcademicRepository();
        final libRepo = _FakeLibraryRepository();
        final readerRepo = _FakeReaderRepository();

        await tester.pumpWidget(
          buildApp(
            authRepo: authRepo,
            dashRepo: dashRepo,
            notifRepo: notifRepo,
            acadRepo: acadRepo,
            libRepo: libRepo,
            readerRepo: readerRepo,
          ),
        );
        await tester.pumpAndSettle();

        // 1. Verify on Dashboard with greeting and academic summary
        expect(find.textContaining('Nguyễn Văn A'), findsWidgets);
        expect(find.textContaining('3.52'), findsWidgets);

        // 2. Navigate to Library tab (index 2 in bottom bar)
        final libraryTab = find.byIcon(Icons.local_library_outlined);
        expect(libraryTab, findsOneWidget);
        await tester.tap(libraryTab);
        await tester.pumpAndSettle();

        // Verify on Library screen with explore sections
        expect(find.text('Thư viện'), findsWidgets);
        expect(find.text('Flutter Monorepo Handbook'), findsWidgets);

        // 3. Open Book Detail
        final bookCard = find.text('Flutter Monorepo Handbook').first;
        await tester.tap(bookCard);
        await tester.pumpAndSettle();

        // Verify Book Detail content
        expect(
          find.text('Cẩm nang xây dựng Flutter Monorepo chuẩn doanh nghiệp.'),
          findsOneWidget,
        );
        expect(find.text('Đọc'), findsOneWidget);

        // 4. Tap "Đọc" to open ReaderScreen
        await tester.tap(find.text('Đọc'));
        await tester.pumpAndSettle();

        // Verify ReaderScreen loaded
        expect(find.byType(Slider), findsOneWidget);

        // 5. Simulate reading forward by moving to next position
        final nextPositionBtn = find.byTooltip('Vị trí kế tiếp');
        expect(nextPositionBtn, findsOneWidget);
        await tester.tap(nextPositionBtn);
        await tester.pumpAndSettle();

        // Tap bookmark button
        final bookmarkChip = find.text('Đánh dấu vị trí này');
        expect(bookmarkChip, findsOneWidget);
        await tester.tap(bookmarkChip);
        await tester.pumpAndSettle();

        // Verify progress sync call was made
        expect(readerRepo.syncCalls, greaterThan(0));
        expect(readerRepo.savedProgress, isNotNull);

        // 6. Navigate back to Book Detail
        final backButton = find.byIcon(Icons.arrow_back);
        expect(backButton, findsOneWidget);
        await tester.tap(backButton);
        await tester.pumpAndSettle();

        // Back on Book Detail
        expect(find.text('Flutter Monorepo Handbook'), findsWidgets);
      },
    );

    testWidgets(
      'Flow 3: Morning Flow (§76) - Dashboard -> Notifications -> Academic Timetable',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);

        final authRepo = _FakeAuthRepository();
        final dashRepo = _FakeDashboardRepository();
        final notifRepo = _FakeNotificationRepository();
        final acadRepo = _FakeAcademicRepository();
        final libRepo = _FakeLibraryRepository();
        final readerRepo = _FakeReaderRepository();

        await tester.pumpWidget(
          buildApp(
            authRepo: authRepo,
            dashRepo: dashRepo,
            notifRepo: notifRepo,
            acadRepo: acadRepo,
            libRepo: libRepo,
            readerRepo: readerRepo,
          ),
        );
        await tester.pumpAndSettle();

        // 1. Dashboard displays today's next class & upcoming exam
        expect(find.textContaining('Lập trình Di động'), findsWidgets);
        expect(find.textContaining('B1-302'), findsWidgets);

        // 2. Open Notification center via Bell icon
        final bellIcon = find.byIcon(Icons.notifications_outlined);
        expect(bellIcon, findsOneWidget);
        await tester.tap(bellIcon);
        await tester.pumpAndSettle();

        // Verify notification list and mark read action
        expect(find.text('Thông báo'), findsOneWidget);
        expect(find.text('Thay đổi phòng học CS301'), findsOneWidget);

        // 3. Return to shell and navigate to Academic tab
        final backBtn = find.byType(BackButton);
        expect(backBtn, findsOneWidget);
        await tester.tap(backBtn);
        await tester.pumpAndSettle();

        final academicTab = find.descendant(
          of: find.byType(NavigationBar),
          matching: find.byIcon(Icons.school_outlined),
        );
        expect(academicTab, findsOneWidget);
        await tester.tap(academicTab);
        await tester.pumpAndSettle();

        // Verify Academic timetable
        expect(find.textContaining('Lập trình Di động'), findsWidgets);
        expect(find.textContaining('Học tập'), findsWidgets);
      },
    );

    testWidgets('Flow 2: Login -> AI Assistant -> Send Prompt -> AI Settings', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      final authRepo = _FakeAuthRepository();
      final dashRepo = _FakeDashboardRepository();
      final notifRepo = _FakeNotificationRepository();
      final acadRepo = _FakeAcademicRepository();
      final libRepo = _FakeLibraryRepository();
      final readerRepo = _FakeReaderRepository();
      final aiRepo = _FakeAiRepository();

      await tester.pumpWidget(
        buildApp(
          authRepo: authRepo,
          dashRepo: dashRepo,
          notifRepo: notifRepo,
          acadRepo: acadRepo,
          libRepo: libRepo,
          readerRepo: readerRepo,
          aiRepo: aiRepo,
        ),
      );
      await tester.pumpAndSettle();

      // 1. Navigate to AI Assistant tab
      final aiTab = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.byIcon(Icons.smart_toy_outlined),
      );
      expect(aiTab, findsOneWidget);
      await tester.tap(aiTab);
      await tester.pumpAndSettle();

      // 2. ChatScreen loaded, suggestion chips are visible
      expect(find.text('AI'), findsWidgets);
      expect(find.text('📚 Giải thích bài học'), findsOneWidget);

      // 3. Tap a suggestion chip to send prompt
      final chip = find.text('📚 Giải thích bài học');
      await tester.tap(chip);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 200));

      // 4. Verify streamed response rendered
      expect(find.textContaining('Điểm rèn luyện'), findsWidgets);

      // 5. Open AI Settings via AppBar action button
      final settingsBtn = find.byIcon(Icons.tune_outlined);
      expect(settingsBtn, findsOneWidget);
      await tester.tap(settingsBtn);
      await tester.pumpAndSettle();

      // 6. Verify AI Settings screen opened
      expect(find.text('Cài đặt & Bộ nhớ AI'), findsOneWidget);
      expect(find.text('Phong cách giải thích'), findsOneWidget);
      expect(find.text('Thích học qua ví dụ Flutter'), findsOneWidget);

      // 7. Return to chat screen
      final backBtn = find.byType(BackButton);
      expect(backBtn, findsOneWidget);
      await tester.tap(backBtn);
      await tester.pumpAndSettle();

      // Back on Chat screen with conversation history intact
      expect(find.textContaining('Điểm rèn luyện'), findsWidgets);
    });
  });
}
