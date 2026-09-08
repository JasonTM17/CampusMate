import 'package:campusmate/features/dashboard/application/dashboard_controller.dart';
import 'package:campusmate/features/dashboard/domain/dashboard_repository.dart';
import 'package:campusmate/features/dashboard/presentation/dashboard_screen.dart';
import 'package:campusmate/features/notifications/application/notification_controller.dart';
import 'package:campusmate/features/notifications/domain/notification_repository.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _DashboardRepository implements DashboardRepository {
  _DashboardRepository({this.summaryError = false});

  final bool summaryError;

  @override
  Future<DashboardGreeting> loadGreeting({DateTime? now}) async {
    return DashboardGreeting(
      message: 'Chào buổi sáng',
      studentName: 'Nguyễn An',
      generatedAt: DateTime.utc(2026, 9, 8, 1),
    );
  }

  @override
  Future<DashboardAcademicSummary> loadAcademicSummary() async {
    if (summaryError) throw StateError('summary down');
    return DashboardAcademicSummary(
      semesterName: 'Học kỳ 1 2026',
      semesterGpa: 3.4,
      cumulativeGpa: 3.3,
      semesterCredits: 18,
      creditsEarned: 96,
      creditsRequired: 140,
      percentComplete: 69,
      activeCourses: 5,
    );
  }

  @override
  Future<List<TimetableEntry>> loadTodayClasses({DateTime? now}) async {
    return [_entry(31, 'SE214')];
  }

  @override
  Future<TimetableEntry?> loadNextClass({DateTime? now}) async {
    return _entry(32, 'DB202');
  }

  @override
  Future<ExamSummary?> loadUpcomingExam({DateTime? now}) async {
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
    );
  }

  @override
  Future<List<AnnouncementSummary>> loadAnnouncements({int limit = 5}) async {
    return [
      AnnouncementSummary(
        id: 1,
        title: 'Cập nhật lịch học',
        body: 'Lịch học tuần này đã được đồng bộ.',
        audience: 'student',
        publishAt: DateTime.utc(2026, 9, 8),
      ),
    ];
  }
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
  Future<int> unreadCount({String? category}) async => 2;

  @override
  Future<int> markAllRead({String? category}) => throw UnimplementedError();

  @override
  Future<CampusNotificationSummary> markRead({required int notificationId}) =>
      throw UnimplementedError();
}

void main() {
  testWidgets(
    'dashboard renders academic, class, exam, announcement and deferred sections',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(900, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_app(_DashboardRepository()));
      await tester.pumpAndSettle();

      expect(find.text('Chào buổi sáng'), findsOneWidget);
      expect(find.text('Nguyễn An'), findsOneWidget);
      expect(find.text('GPA kỳ'), findsOneWidget);
      expect(find.text('Tín chỉ kỳ này'), findsOneWidget);
      expect(find.text('Tín chỉ tích lũy'), findsOneWidget);
      expect(find.text('Lớp kế tiếp'), findsOneWidget);
      expect(find.text('Lớp hôm nay'), findsOneWidget);
      expect(find.text('Sắp thi'), findsOneWidget);
      expect(find.text('Cập nhật lịch học'), findsOneWidget);
      expect(find.text('Đọc tiếp'), findsOneWidget);
      expect(find.text('Gợi ý AI'), findsOneWidget);
      expect(find.byType(Badge), findsWidgets);
    },
  );

  testWidgets(
    'dashboard keeps healthy sections visible when one section fails',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(900, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_app(_DashboardRepository(summaryError: true)));
      await tester.pumpAndSettle();

      expect(find.text('Chào buổi sáng'), findsOneWidget);
      expect(find.text('Không tải được Tổng quan học tập'), findsOneWidget);
      expect(find.text('Lớp hôm nay'), findsOneWidget);
    },
  );
}

Widget _app(DashboardRepository repository) {
  return ProviderScope(
    overrides: [
      dashboardRepositoryProvider.overrideWithValue(repository),
      notificationRepositoryProvider.overrideWithValue(
        _NotificationRepository(),
      ),
    ],
    child: const MaterialApp(home: DashboardScreen()),
  );
}

TimetableEntry _entry(int id, String code) {
  return TimetableEntry(
    scheduleId: id,
    offeringId: id,
    courseCode: code,
    title: code == 'SE214' ? 'Lập trình di động' : 'Cơ sở dữ liệu',
    lecturerName: 'ThS. Nguyễn Thu Hà',
    weekday: 2,
    startMinute: 570,
    endMinute: 720,
    room: 'A101',
    campus: 'Cơ sở chính',
    status: 'scheduled',
    startsAt: DateTime.utc(2026, 9, 8, 2, 30),
    endsAt: DateTime.utc(2026, 9, 8, 5),
    isCurrent: id == 31,
  );
}
