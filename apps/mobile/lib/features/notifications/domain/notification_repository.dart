import 'package:campusmate_client/campusmate_client.dart';

class NotificationState {
  const NotificationState({
    required this.items,
    required this.unreadCount,
    this.nextCursor,
    this.category,
    this.isLoadingMore = false,
  });

  final List<CampusNotificationSummary> items;
  final String? nextCursor;
  final int unreadCount;
  final String? category;
  final bool isLoadingMore;

  bool get hasMore => nextCursor != null;

  NotificationState copyWith({
    List<CampusNotificationSummary>? items,
    String? nextCursor,
    bool clearNextCursor = false,
    int? unreadCount,
    String? category,
    bool clearCategory = false,
    bool? isLoadingMore,
  }) {
    return NotificationState(
      items: items ?? this.items,
      nextCursor: clearNextCursor ? null : nextCursor ?? this.nextCursor,
      unreadCount: unreadCount ?? this.unreadCount,
      category: clearCategory ? null : category ?? this.category,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

abstract interface class NotificationRepository {
  Future<NotificationListPage> list({
    String? cursor,
    int limit = 20,
    String? category,
  });

  Future<int> unreadCount({String? category});

  Future<CampusNotificationSummary> markRead({required int notificationId});

  Future<int> markAllRead({String? category});
}
