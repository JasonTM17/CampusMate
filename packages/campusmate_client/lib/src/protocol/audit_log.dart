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

abstract class AuditLog implements _i1.SerializableModel {
  AuditLog._({
    this.id,
    required this.actorUserId,
    required this.action,
    required this.resourceType,
    required this.resourceId,
    required this.metadataJson,
    required this.createdAt,
  });

  factory AuditLog({
    int? id,
    required _i1.UuidValue actorUserId,
    required String action,
    required String resourceType,
    required String resourceId,
    required String metadataJson,
    required DateTime createdAt,
  }) = _AuditLogImpl;

  factory AuditLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditLog(
      id: jsonSerialization['id'] as int?,
      actorUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['actorUserId'],
      ),
      action: jsonSerialization['action'] as String,
      resourceType: jsonSerialization['resourceType'] as String,
      resourceId: jsonSerialization['resourceId'] as String,
      metadataJson: jsonSerialization['metadataJson'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue actorUserId;

  String action;

  String resourceType;

  String resourceId;

  String metadataJson;

  DateTime createdAt;

  /// Returns a shallow copy of this [AuditLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditLog copyWith({
    int? id,
    _i1.UuidValue? actorUserId,
    String? action,
    String? resourceType,
    String? resourceId,
    String? metadataJson,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId.toJson(),
      'action': action,
      'resourceType': resourceType,
      'resourceId': resourceId,
      'metadataJson': metadataJson,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditLogImpl extends AuditLog {
  _AuditLogImpl({
    int? id,
    required _i1.UuidValue actorUserId,
    required String action,
    required String resourceType,
    required String resourceId,
    required String metadataJson,
    required DateTime createdAt,
  }) : super._(
         id: id,
         actorUserId: actorUserId,
         action: action,
         resourceType: resourceType,
         resourceId: resourceId,
         metadataJson: metadataJson,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AuditLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditLog copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? actorUserId,
    String? action,
    String? resourceType,
    String? resourceId,
    String? metadataJson,
    DateTime? createdAt,
  }) {
    return AuditLog(
      id: id is int? ? id : this.id,
      actorUserId: actorUserId ?? this.actorUserId,
      action: action ?? this.action,
      resourceType: resourceType ?? this.resourceType,
      resourceId: resourceId ?? this.resourceId,
      metadataJson: metadataJson ?? this.metadataJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
