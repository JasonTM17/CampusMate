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

abstract class CampusNotification implements _i1.SerializableModel {
  CampusNotification._({
    this.id,
    required this.userId,
    required this.category,
    required this.title,
    required this.body,
    this.targetType,
    this.targetId,
    this.readAt,
    required this.createdAt,
  });

  factory CampusNotification({
    int? id,
    required _i1.UuidValue userId,
    required String category,
    required String title,
    required String body,
    String? targetType,
    int? targetId,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _CampusNotificationImpl;

  factory CampusNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusNotification(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  String category;

  String title;

  String body;

  String? targetType;

  int? targetId;

  DateTime? readAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CampusNotification copyWith({
    int? id,
    _i1.UuidValue? userId,
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
      '__className__': 'CampusNotification',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
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

class _CampusNotificationImpl extends CampusNotification {
  _CampusNotificationImpl({
    int? id,
    required _i1.UuidValue userId,
    required String category,
    required String title,
    required String body,
    String? targetType,
    int? targetId,
    DateTime? readAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         category: category,
         title: title,
         body: body,
         targetType: targetType,
         targetId: targetId,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CampusNotification copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? category,
    String? title,
    String? body,
    Object? targetType = _Undefined,
    Object? targetId = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return CampusNotification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
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
