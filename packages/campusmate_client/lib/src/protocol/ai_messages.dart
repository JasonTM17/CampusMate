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

abstract class AiMessage implements _i1.SerializableModel {
  AiMessage._({
    this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    this.citations,
    this.feedback,
    required this.createdAt,
  });

  factory AiMessage({
    int? id,
    required int conversationId,
    required String role,
    required String content,
    String? citations,
    String? feedback,
    required DateTime createdAt,
  }) = _AiMessageImpl;

  factory AiMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiMessage(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      role: jsonSerialization['role'] as String,
      content: jsonSerialization['content'] as String,
      citations: jsonSerialization['citations'] as String?,
      feedback: jsonSerialization['feedback'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int conversationId;

  String role;

  String content;

  String? citations;

  String? feedback;

  DateTime createdAt;

  /// Returns a shallow copy of this [AiMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiMessage copyWith({
    int? id,
    int? conversationId,
    String? role,
    String? content,
    String? citations,
    String? feedback,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'role': role,
      'content': content,
      if (citations != null) 'citations': citations,
      if (feedback != null) 'feedback': feedback,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiMessageImpl extends AiMessage {
  _AiMessageImpl({
    int? id,
    required int conversationId,
    required String role,
    required String content,
    String? citations,
    String? feedback,
    required DateTime createdAt,
  }) : super._(
         id: id,
         conversationId: conversationId,
         role: role,
         content: content,
         citations: citations,
         feedback: feedback,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AiMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiMessage copyWith({
    Object? id = _Undefined,
    int? conversationId,
    String? role,
    String? content,
    Object? citations = _Undefined,
    Object? feedback = _Undefined,
    DateTime? createdAt,
  }) {
    return AiMessage(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      citations: citations is String? ? citations : this.citations,
      feedback: feedback is String? ? feedback : this.feedback,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
