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

abstract class AiConversation implements _i1.SerializableModel {
  AiConversation._({
    this.id,
    required this.title,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AiConversation({
    int? id,
    required String title,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AiConversationImpl;

  factory AiConversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiConversation(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      userId: jsonSerialization['userId'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String userId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AiConversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiConversation copyWith({
    int? id,
    String? title,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiConversation',
      if (id != null) 'id': id,
      'title': title,
      'userId': userId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiConversationImpl extends AiConversation {
  _AiConversationImpl({
    int? id,
    required String title,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         title: title,
         userId: userId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AiConversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiConversation copyWith({
    Object? id = _Undefined,
    String? title,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AiConversation(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
