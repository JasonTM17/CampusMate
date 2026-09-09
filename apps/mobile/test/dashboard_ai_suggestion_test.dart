import 'package:campusmate/features/chat/application/chat_controller.dart';
import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/domain/chat_repository.dart';
import 'package:campusmate/features/dashboard/application/dashboard_controller.dart';
import 'package:campusmate/features/dashboard/domain/dashboard_repository.dart';
import 'package:campusmate/features/dashboard/presentation/dashboard_screen.dart';
import 'package:campusmate/features/notifications/application/notification_controller.dart';
import 'package:campusmate/features/notifications/domain/notification_repository.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAiRepo implements AiRepository {
  _FakeAiRepo({this.suggestion});

  final StudySuggestion? suggestion;

  @override
  Future<StudySuggestion?> getStudySuggestion() async => suggestion;

  @override
  Future<List<ConversationSummary>> listConversations() async => [];
  @override
  Future<ConversationSummary> createConversation({required String title}) =>
      throw UnimplementedError();
  @override
  Future<void> deleteConversation(int conversationId) =>
      throw UnimplementedError();
  @override
  Future<List<ChatMessage>> getMessages(int conversationId) =>
      throw UnimplementedError();
  @override
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
    int? bookId,
    String? selectedText,
  }) => throw UnimplementedError();
  @override
  Future<StudentAiPreference> getPreferences() => throw UnimplementedError();
  @override
  Future<StudentAiPreference> updatePreferences({
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) => throw UnimplementedError();
  @override
  Future<List<AiUserMemory>> getMemories({bool activeOnly = false}) =>
      throw UnimplementedError();
  @override
  Future<AiUserMemory> addMemory({required String content, String? source}) =>
      throw UnimplementedError();
  @override
  Future<AiUserMemory> toggleMemory({
    required int memoryId,
    required bool disabled,
  }) => throw UnimplementedError();
  @override
  Future<void> deleteMemory({required int memoryId}) =>
      throw UnimplementedError();
}

class _FakeDashboardRepo implements DashboardRepository {
  @override
  Future<DashboardGreeting> loadGreeting({DateTime? now}) async =>
      DashboardGreeting(
        message: 'Chào buổi sáng',
        studentName: 'Nguyễn An',
        generatedAt: DateTime.utc(2026, 9, 8, 1),
      );

  @override
  Future<DashboardAcademicSummary> loadAcademicSummary() async =>
      DashboardAcademicSummary(
        semesterName: 'Học kỳ 1 2026',
        semesterGpa: 3.5,
        cumulativeGpa: 3.4,
        semesterCredits: 18,
        creditsEarned: 96,
        creditsRequired: 140,
        percentComplete: 69,
        activeCourses: 5,
      );

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

class _FakeNotifRepo implements NotificationRepository {
  @override
  Future<NotificationListPage> list({
    String? cursor,
    int limit = 20,
    String? category,
  }) async => NotificationListPage(items: const [], unreadCount: 0);

  @override
  Future<int> unreadCount({String? category}) async => 0;

  @override
  Future<int> markAllRead({String? category}) => throw UnimplementedError();

  @override
  Future<CampusNotificationSummary> markRead({required int notificationId}) =>
      throw UnimplementedError();
}

Widget _hostApp(StudySuggestion? suggestion) {
  return ProviderScope(
    overrides: [
      aiRepositoryProvider.overrideWithValue(
        _FakeAiRepo(suggestion: suggestion),
      ),
      dashboardRepositoryProvider.overrideWithValue(_FakeDashboardRepo()),
      notificationRepositoryProvider.overrideWithValue(_FakeNotifRepo()),
    ],
    child: const MaterialApp(home: DashboardScreen()),
  );
}

void main() {
  testWidgets(
    'renders live AI suggestion card when study suggestion is available',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(900, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final suggestion = StudySuggestion(
        title: 'Ôn thi Lập trình di động',
        message: 'Kỳ thi diễn ra vào ngày 20/10 (còn 5 ngày). Ôn tập ngay nhé!',
        priority: 'high',
        actionLabel: 'Xem lịch thi',
        actionRoute: '/academic',
      );

      await tester.pumpWidget(_hostApp(suggestion));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('dashboard-ai-suggestion-card')),
        findsOneWidget,
      );
      expect(find.text('Ôn thi Lập trình di động'), findsOneWidget);
      expect(
        find.text(
          'Kỳ thi diễn ra vào ngày 20/10 (còn 5 ngày). Ôn tập ngay nhé!',
        ),
        findsOneWidget,
      );
      expect(find.text('Ưu tiên'), findsOneWidget);
      expect(find.text('Xem lịch thi'), findsOneWidget);
    },
  );

  testWidgets(
    'renders empty state for AI suggestion when no suggestion is available',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(900, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_hostApp(null));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('dashboard-ai-suggestion-card')),
        findsNothing,
      );
      expect(find.text('Chưa có gợi ý mới'), findsOneWidget);
    },
  );
}
