/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'campus_notification_summary.dart' as _i2;
import 'package:campusmate_client/src/protocol/protocol.dart' as _i3;

abstract class NotificationListPage implements _i1.SerializableModel {
  NotificationListPage._({
    required this.items,
    this.nextCursor,
    required this.unreadCount,
  });

  factory NotificationListPage({
    required List<_i2.CampusNotificationSummary> items,
    String? nextCursor,
    required int unreadCount,
  }) = _NotificationListPageImpl;

  factory NotificationListPage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return NotificationListPage(
      items: _i3.Protocol().deserialize<List<_i2.CampusNotificationSummary>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      unreadCount: jsonSerialization['unreadCount'] as int,
    );
  }

  List<_i2.CampusNotificationSummary> items;

  String? nextCursor;

  int unreadCount;

  /// Returns a shallow copy of this [NotificationListPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotificationListPage copyWith({
    List<_i2.CampusNotificationSummary>? items,
    String? nextCursor,
    int? unreadCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationListPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'unreadCount': unreadCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationListPageImpl extends NotificationListPage {
  _NotificationListPageImpl({
    required List<_i2.CampusNotificationSummary> items,
    String? nextCursor,
    required int unreadCount,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         unreadCount: unreadCount,
       );

  /// Returns a shallow copy of this [NotificationListPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotificationListPage copyWith({
    List<_i2.CampusNotificationSummary>? items,
    Object? nextCursor = _Undefined,
    int? unreadCount,
  }) {
    return NotificationListPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
