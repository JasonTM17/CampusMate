import 'package:campusmate_client/campusmate_client.dart';

import '../domain/notification_repository.dart';

class ServerpodNotificationRepository implements NotificationRepository {
  const ServerpodNotificationRepository(this._client);

  final Client _client;

  @override
  Future<NotificationListPage> list({
    String? cursor,
    int limit = 20,
    String? category,
  }) => _client.notification.list(
    cursor: cursor,
    limit: limit,
    category: category,
  );

  @override
  Future<int> unreadCount({String? category}) =>
      _client.notification.unreadCount(category: category);

  @override
  Future<CampusNotificationSummary> markRead({required int notificationId}) =>
      _client.notification.markRead(notificationId: notificationId);

  @override
  Future<int> markAllRead({String? category}) =>
      _client.notification.markAllRead(category: category);
}
