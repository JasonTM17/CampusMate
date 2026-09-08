import 'package:campusmate/features/notifications/application/notification_controller.dart';
import 'package:campusmate/features/notifications/domain/notification_repository.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _NotificationRepository implements NotificationRepository {
  final listCalls = <({String? cursor, String? category})>[];
  final markReadCalls = <int>[];
  final markAllCalls = <String?>[];

  @override
  Future<NotificationListPage> list({
    String? cursor,
    int limit = 20,
    String? category,
  }) async {
    listCalls.add((cursor: cursor, category: category));
    if (category == 'exam') {
      return NotificationListPage(
        items: [_notification(2, 'exam', readAt: null)],
        unreadCount: 1,
      );
    }
    if (cursor == 'next-page') {
      return NotificationListPage(
        items: [_notification(3, 'library', readAt: DateTime.utc(2026, 9, 8))],
        unreadCount: 2,
      );
    }
    return NotificationListPage(
      items: [_notification(1, 'academic', readAt: null)],
      nextCursor: 'next-page',
      unreadCount: 2,
    );
  }

  @override
  Future<int> unreadCount({String? category}) async =>
      category == 'exam' ? 1 : 2;

  @override
  Future<CampusNotificationSummary> markRead({
    required int notificationId,
  }) async {
    markReadCalls.add(notificationId);
    return _notification(
      notificationId,
      'academic',
      readAt: DateTime.utc(2026, 9, 8),
    );
  }

  @override
  Future<int> markAllRead({String? category}) async {
    markAllCalls.add(category);
    return 0;
  }
}

void main() {
  test('loads, filters, paginates, marks read and marks all', () async {
    final repository = _NotificationRepository();
    final container = ProviderContainer(
      overrides: [notificationRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    var state = await container.read(notificationControllerProvider.future);
    expect(state.items.map((item) => item.id), [1]);
    expect(state.nextCursor, 'next-page');

    await container.read(notificationControllerProvider.notifier).loadMore();
    state = container.read(notificationControllerProvider).requireValue;
    expect(state.items.map((item) => item.id), [1, 3]);
    expect(repository.listCalls.last.cursor, 'next-page');

    await container
        .read(notificationControllerProvider.notifier)
        .setCategory('exam');
    state = container.read(notificationControllerProvider).requireValue;
    expect(state.category, 'exam');
    expect(state.items.single.category, 'exam');
    expect(repository.listCalls.last.category, 'exam');

    await container
        .read(notificationControllerProvider.notifier)
        .markRead(state.items.single);
    expect(repository.markReadCalls, [2]);

    await container.read(notificationControllerProvider.notifier).markAllRead();
    expect(repository.markAllCalls, ['exam']);
  });
}

CampusNotificationSummary _notification(
  int id,
  String category, {
  DateTime? readAt,
}) {
  return CampusNotificationSummary(
    id: id,
    category: category,
    title: category == 'exam' ? 'Lịch thi giữa kỳ' : 'Thông báo $id',
    body: 'Nội dung thông báo $id',
    targetType: category == 'exam' ? 'exam' : null,
    targetId: category == 'exam' ? 41 : null,
    readAt: readAt,
    createdAt: DateTime.utc(2026, 9, 8, 1, id),
  );
}
