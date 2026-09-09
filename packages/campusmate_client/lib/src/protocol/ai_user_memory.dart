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

abstract class AiUserMemory implements _i1.SerializableModel {
  AiUserMemory._({
    this.id,
    required this.userId,
    required this.content,
    required this.source,
    required this.createdAt,
    this.disabledAt,
  });

  factory AiUserMemory({
    int? id,
    required _i1.UuidValue userId,
    required String content,
    required String source,
    required DateTime createdAt,
    DateTime? disabledAt,
  }) = _AiUserMemoryImpl;

  factory AiUserMemory.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiUserMemory(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      content: jsonSerialization['content'] as String,
      source: jsonSerialization['source'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      disabledAt: jsonSerialization['disabledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['disabledAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  String content;

  String source;

  DateTime createdAt;

  DateTime? disabledAt;

  /// Returns a shallow copy of this [AiUserMemory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiUserMemory copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? content,
    String? source,
    DateTime? createdAt,
    DateTime? disabledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiUserMemory',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'content': content,
      'source': source,
      'createdAt': createdAt.toJson(),
      if (disabledAt != null) 'disabledAt': disabledAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiUserMemoryImpl extends AiUserMemory {
  _AiUserMemoryImpl({
    int? id,
    required _i1.UuidValue userId,
    required String content,
    required String source,
    required DateTime createdAt,
    DateTime? disabledAt,
  }) : super._(
         id: id,
         userId: userId,
         content: content,
         source: source,
         createdAt: createdAt,
         disabledAt: disabledAt,
       );

  /// Returns a shallow copy of this [AiUserMemory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiUserMemory copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? content,
    String? source,
    DateTime? createdAt,
    Object? disabledAt = _Undefined,
  }) {
    return AiUserMemory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      disabledAt: disabledAt is DateTime? ? disabledAt : this.disabledAt,
    );
  }
}
