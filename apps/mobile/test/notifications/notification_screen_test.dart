import 'package:campusmate/features/academics/application/academic_controller.dart';
import 'package:campusmate/features/academics/domain/academic_repository.dart';
import 'package:campusmate/features/academics/presentation/exam_detail_screen.dart';
import 'package:campusmate/features/notifications/application/notification_controller.dart';
import 'package:campusmate/features/notifications/domain/notification_repository.dart';
import 'package:campusmate/features/notifications/presentation/notification_screen.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class _NotificationRepository implements NotificationRepository {
  final markReadCalls = <int>[];
  final markAllCalls = <String?>[];

  @override
  Future<NotificationListPage> list({
    String? cursor,
    int limit = 20,
    String? category,
  }) async {
    final items = [
      _notification(1, 'exam', 'Lịch thi giữa kỳ', readAt: null),
      _notification(
        2,
        'system',
        'Bảo trì hệ thống',
        readAt: DateTime.utc(2026, 9, 8),
      ),
    ];
    return NotificationListPage(
      items: category == null
          ? items
          : items.where((item) => item.category == category).toList(),
      unreadCount: category == 'system' ? 0 : 1,
    );
  }

  @override
  Future<int> unreadCount({String? category}) async =>
      category == 'system' ? 0 : 1;

  @override
  Future<int> markAllRead({String? category}) async {
    markAllCalls.add(category);
    return 0;
  }

  @override
  Future<CampusNotificationSummary> markRead({
    required int notificationId,
  }) async {
    markReadCalls.add(notificationId);
    return _notification(
      notificationId,
      'exam',
      'Lịch thi giữa kỳ',
      readAt: DateTime.utc(2026, 9, 8),
    );
  }
}

class _PagedNotificationRepository implements NotificationRepository {
  final listCalls = <String?>[];

  @override
  Future<NotificationListPage> list({
    String? cursor,
    int limit = 20,
    String? category,
  }) async {
    listCalls.add(cursor);
    if (cursor == 'page-2') {
      return NotificationListPage(
        items: [_notification(99, 'system', 'Trang 2')],
        unreadCount: 0,
      );
    }
    return NotificationListPage(
      items: [
        for (var i = 0; i < 24; i++)
          _notification(10 + i, 'system', 'Thông báo $i'),
      ],
      nextCursor: 'page-2',
      unreadCount: 0,
    );
  }

  @override
  Future<int> unreadCount({String? category}) async => 0;

  @override
  Future<int> markAllRead({String? category}) => throw UnimplementedError();

  @override
  Future<CampusNotificationSummary> markRead({required int notificationId}) =>
      throw UnimplementedError();
}

class _AcademicRepository implements AcademicRepository {
  @override
  Future<AcademicSnapshot> loadDashboard({
    required String accountId,
    DateTime? now,
    DateTime? weekStart,
    int? semesterId,
  }) => throw UnimplementedError();

  @override
  Future<CourseDetail> loadCourseDetail({required int offeringId}) =>
      throw UnimplementedError();

  @override
  Future<ExamSummary> loadExamDetail({required int examId}) async {
    expect(examId, 41);
    return ExamSummary(
      examId: 41,
      offeringId: 11,
      courseCode: 'SE214',
      title: 'Lập trình di động',
      examType: 'Giữa kỳ',
      startsAt: DateTime.utc(2026, 10, 20, 2),
      endsAt: DateTime.utc(2026, 10, 20, 3, 30),
      room: 'A101',
      daysUntil: 42,
      notes: 'Mang thẻ sinh viên.',
    );
  }
}

void main() {
  testWidgets('filters categories and opens exam deep links after mark-read', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final notifications = _NotificationRepository();
    await tester.pumpWidget(_app(notifications));
    await tester.pumpAndSettle();

    expect(find.text('Lịch thi giữa kỳ'), findsOneWidget);
    expect(find.text('Bảo trì hệ thống'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Lịch thi'));
    await tester.pumpAndSettle();

    expect(find.text('Lịch thi giữa kỳ'), findsOneWidget);
    expect(find.text('Bảo trì hệ thống'), findsNothing);

    await tester.tap(find.text('Lịch thi giữa kỳ'));
    await tester.pumpAndSettle();

    expect(notifications.markReadCalls, [1]);
    expect(find.text('Chi tiết lịch thi'), findsOneWidget);
    expect(find.textContaining('SE214'), findsOneWidget);
    expect(find.text('Mang thẻ sinh viên.'), findsOneWidget);
  });

  testWidgets('mark-all action delegates the active category', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final notifications = _NotificationRepository();
    await tester.pumpWidget(_app(notifications));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ChoiceChip, 'Lịch thi'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Đánh dấu tất cả đã đọc'));
    await tester.pumpAndSettle();

    expect(notifications.markAllCalls, ['exam']);
  });

  testWidgets('scrolling near the bottom loads the next cursor page', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(900, 600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final notifications = _PagedNotificationRepository();
    await tester.pumpWidget(_app(notifications));
    await tester.pumpAndSettle();

    expect(notifications.listCalls, [null]);
    await tester.drag(find.byType(ListView), const Offset(0, -2200));
    await tester.pumpAndSettle();

    expect(notifications.listCalls, [null, 'page-2']);
    await tester.scrollUntilVisible(
      find.text('Trang 2'),
      240,
      scrollable: find.byType(Scrollable),
      maxScrolls: 8,
    );
    expect(find.text('Trang 2'), findsOneWidget);
  });
}

Widget _app(NotificationRepository notifications) {
  final router = GoRouter(
    initialLocation: '/notifications',
    routes: [
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/academic/exams/:examId',
        builder: (context, state) => ExamDetailScreen(
          examId: int.parse(state.pathParameters['examId']!),
        ),
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      notificationRepositoryProvider.overrideWithValue(notifications),
      academicRepositoryProvider.overrideWithValue(_AcademicRepository()),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

CampusNotificationSummary _notification(
  int id,
  String category,
  String title, {
  DateTime? readAt,
}) {
  return CampusNotificationSummary(
    id: id,
    category: category,
    title: title,
    body: 'Nội dung $title',
    targetType: category == 'exam' ? 'exam' : null,
    targetId: category == 'exam' ? 41 : null,
    readAt: readAt,
    createdAt: DateTime.utc(2026, 9, 8, 1, id),
  );
}
