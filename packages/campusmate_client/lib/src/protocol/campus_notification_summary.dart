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

abstract class CampusNotificationSummary implements _i1.SerializableModel {
  CampusNotificationSummary._({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    this.targetType,
    this.targetId,
    this.readAt,
    required this.createdAt,
  });

  factory CampusNotificationSummary({
    required int id,
    required String category,
    required String title,
    required String body,
    String? targetType,
    int? targetId,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _CampusNotificationSummaryImpl;

  factory CampusNotificationSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CampusNotificationSummary(
      id: jsonSerialization['id'] as int,
      category: jsonSerialization['category'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      targetType: jsonSerialization['targetType'] as String?,
      targetId: jsonSerialization['targetId'] as int?,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  int id;

  String category;

  String title;

  String body;

  String? targetType;

  int? targetId;

  DateTime? readAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [CampusNotificationSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CampusNotificationSummary copyWith({
    int? id,
    String? category,
    String? title,
    String? body,
    String? targetType,
    int? targetId,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusNotificationSummary',
      'id': id,
      'category': category,
      'title': title,
      'body': body,
      if (targetType != null) 'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusNotificationSummaryImpl extends CampusNotificationSummary {
  _CampusNotificationSummaryImpl({
    required int id,
    required String category,
    required String title,
    required String body,
    String? targetType,
    int? targetId,
    DateTime? readAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         category: category,
         title: title,
         body: body,
         targetType: targetType,
         targetId: targetId,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CampusNotificationSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CampusNotificationSummary copyWith({
    int? id,
    String? category,
    String? title,
    String? body,
    Object? targetType = _Undefined,
    Object? targetId = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return CampusNotificationSummary(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      body: body ?? this.body,
      targetType: targetType is String? ? targetType : this.targetType,
      targetId: targetId is int? ? targetId : this.targetId,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
