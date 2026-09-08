import 'package:serverpod/serverpod.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import 'notification_service.dart';

class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateStudentScope};

  final _service = NotificationService();

  Future<NotificationListPage> list(
    Session session, {
    String? cursor,
    int limit = 20,
    String? category,
  }) => _service.list(
    session,
    cursor: cursor,
    limit: limit,
    category: category,
  );

  Future<int> unreadCount(Session session, {String? category}) =>
      _service.unreadCount(session, category: category);

  Future<CampusNotificationSummary> markRead(
    Session session, {
    required int notificationId,
  }) => _service.markRead(session, notificationId: notificationId);

  Future<int> markAllRead(Session session, {String? category}) =>
      _service.markAllRead(session, category: category);
}
