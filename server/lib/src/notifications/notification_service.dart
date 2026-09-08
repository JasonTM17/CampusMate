import 'dart:convert';

import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';

class NotificationService {
  static const categories = {
    'academic',
    'library',
    'system',
    'ai',
    'course',
    'exam',
  };

  Future<NotificationListPage> list(
    Session session, {
    String? cursor,
    int limit = 20,
    String? category,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final normalizedCategory = _normalizeCategory(category);
    final decodedCursor = cursor == null || cursor.trim().isEmpty
        ? null
        : _decodeCursor(cursor, normalizedCategory);
    final pageSize = limit.clamp(1, 50).toInt();
    final rows = await CampusNotification.db.find(
      session,
      where: (t) {
        var expression = t.userId.equals(userId);
        if (normalizedCategory != null) {
          expression = expression & t.category.equals(normalizedCategory);
        }
        if (decodedCursor != null) {
          expression =
              expression &
              ((t.createdAt < decodedCursor.createdAt) |
                  (t.createdAt.equals(decodedCursor.createdAt) &
                      (t.id < decodedCursor.id)));
        }
        return expression;
      },
      orderByList: (t) => [
        Order(column: t.createdAt, orderDescending: true),
        Order(column: t.id, orderDescending: true),
      ],
      limit: pageSize + 1,
    );
    final hasMore = rows.length > pageSize;
    final visibleRows = hasMore ? rows.take(pageSize).toList() : rows;
    final nextCursor = hasMore && visibleRows.isNotEmpty
        ? _encodeCursor(visibleRows.last, normalizedCategory)
        : null;

    return NotificationListPage(
      items: visibleRows.map(_summary).toList(),
      nextCursor: nextCursor,
      unreadCount: await unreadCount(session, category: normalizedCategory),
    );
  }

  Future<int> unreadCount(Session session, {String? category}) {
    final userId = CampusMateAuth.requireUserId(session);
    final normalizedCategory = _normalizeCategory(category);
    return CampusNotification.db.count(
      session,
      where: (t) {
        var expression = t.userId.equals(userId) & t.readAt.equals(null);
        if (normalizedCategory != null) {
          expression = expression & t.category.equals(normalizedCategory);
        }
        return expression;
      },
    );
  }

  Future<CampusNotificationSummary> markRead(
    Session session, {
    required int notificationId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final row = await CampusNotification.db.findFirstRow(
      session,
      where: (t) => t.id.equals(notificationId) & t.userId.equals(userId),
    );
    if (row == null) {
      throw ServerpodClientException('Notification not found', 404);
    }
    if (row.readAt != null) return _summary(row);

    final updated = await CampusNotification.db.updateRow(
      session,
      row.copyWith(readAt: CampusClock.nowUtc()),
    );
    return _summary(updated);
  }

  Future<int> markAllRead(Session session, {String? category}) async {
    final userId = CampusMateAuth.requireUserId(session);
    final normalizedCategory = _normalizeCategory(category);
    final now = CampusClock.nowUtc();
    final updated = await CampusNotification.db.updateWhere(
      session,
      where: (t) {
        var expression = t.userId.equals(userId) & t.readAt.equals(null);
        if (normalizedCategory != null) {
          expression = expression & t.category.equals(normalizedCategory);
        }
        return expression;
      },
      columnValues: (t) => [t.readAt(now)],
    );
    return updated.length;
  }

  String? _normalizeCategory(String? category) {
    final value = category?.trim().toLowerCase();
    if (value == null || value.isEmpty) return null;
    if (!categories.contains(value)) {
      throw ServerpodClientException('Invalid notification category', 400);
    }
    return value;
  }

  CampusNotificationSummary _summary(CampusNotification row) {
    final id = row.id;
    if (id == null) {
      throw StateError('Persisted notification is missing an id.');
    }
    return CampusNotificationSummary(
      id: id,
      category: row.category,
      title: row.title,
      body: row.body,
      targetType: row.targetType,
      targetId: row.targetId,
      readAt: row.readAt,
      createdAt: row.createdAt,
    );
  }

  String _encodeCursor(CampusNotification row, String? category) {
    final id = row.id;
    if (id == null) {
      throw StateError('Persisted notification is missing an id.');
    }
    return base64Url.encode(
      utf8.encode(
        jsonEncode({
          'v': 1,
          'createdAt': row.createdAt.toIso8601String(),
          'id': id,
          'category': category,
        }),
      ),
    );
  }

  _NotificationCursor _decodeCursor(String cursor, String? category) {
    try {
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(cursor))),
      );
      if (payload is! Map<String, dynamic> ||
          payload['v'] != 1 ||
          payload['id'] is! int ||
          payload['createdAt'] is! String ||
          payload['category'] != category) {
        throw const FormatException('Invalid notification cursor.');
      }
      return _NotificationCursor(
        id: payload['id'] as int,
        createdAt: DateTime.parse(payload['createdAt'] as String).toUtc(),
      );
    } on FormatException {
      throw ServerpodClientException('Invalid notification cursor', 400);
    } on ArgumentError {
      throw ServerpodClientException('Invalid notification cursor', 400);
    }
  }
}

class _NotificationCursor {
  const _NotificationCursor({required this.id, required this.createdAt});

  final int id;
  final DateTime createdAt;
}
