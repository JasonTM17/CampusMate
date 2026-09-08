import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../data/serverpod_notification_repository.dart';
import '../domain/notification_repository.dart';

const notificationCategories = <String>[
  'academic',
  'library',
  'system',
  'ai',
  'course',
  'exam',
];

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => ServerpodNotificationRepository(ref.watch(serverpodClientProvider)),
);

final notificationUnreadCountProvider = FutureProvider.autoDispose<int>(
  (ref) => ref.watch(notificationRepositoryProvider).unreadCount(),
);

final notificationControllerProvider =
    AsyncNotifierProvider<NotificationController, NotificationState>(
      NotificationController.new,
    );

class NotificationController extends AsyncNotifier<NotificationState> {
  NotificationRepository get _repository =>
      ref.read(notificationRepositoryProvider);

  @override
  Future<NotificationState> build() => _load();

  Future<void> refresh() async {
    final category = state.value?.category;
    state = const AsyncLoading<NotificationState>();
    state = await AsyncValue.guard(() => _load(category: category));
    ref.invalidate(notificationUnreadCountProvider);
  }

  Future<void> setCategory(String? category) async {
    state = const AsyncLoading<NotificationState>();
    state = await AsyncValue.guard(() => _load(category: category));
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final page = await _repository.list(
        cursor: current.nextCursor,
        category: current.category,
      );
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...page.items],
          nextCursor: page.nextCursor,
          clearNextCursor: page.nextCursor == null,
          unreadCount: page.unreadCount,
          isLoadingMore: false,
        ),
      );
    } on Object catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> markRead(CampusNotificationSummary notification) async {
    if (notification.readAt != null) return;
    final current = state.value;
    if (current == null) return;
    final updated = await _repository.markRead(notificationId: notification.id);
    final unreadCount = await _repository.unreadCount(
      category: current.category,
    );
    state = AsyncData(
      current.copyWith(
        items: [
          for (final item in current.items)
            item.id == updated.id ? updated : item,
        ],
        unreadCount: unreadCount,
      ),
    );
    ref.invalidate(notificationUnreadCountProvider);
  }

  Future<void> markAllRead() async {
    final current = state.value;
    if (current == null) return;
    await _repository.markAllRead(category: current.category);
    final unreadCount = await _repository.unreadCount(
      category: current.category,
    );
    final readAt = DateTime.now().toUtc();
    state = AsyncData(
      current.copyWith(
        items: [
          for (final item in current.items)
            item.readAt == null ? item.copyWith(readAt: readAt) : item,
        ],
        unreadCount: unreadCount,
      ),
    );
    ref.invalidate(notificationUnreadCountProvider);
  }

  Future<NotificationState> _load({String? category}) async {
    final page = await _repository.list(category: category);
    return NotificationState(
      items: page.items,
      nextCursor: page.nextCursor,
      unreadCount: page.unreadCount,
      category: category,
    );
  }
}
