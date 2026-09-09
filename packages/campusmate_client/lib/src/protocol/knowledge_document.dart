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

abstract class KnowledgeDocument implements _i1.SerializableModel {
  KnowledgeDocument._({
    this.id,
    required this.title,
    required this.sourceType,
    this.bookId,
    required this.accessLevel,
    this.requiredCourseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KnowledgeDocument({
    int? id,
    required String title,
    required String sourceType,
    int? bookId,
    required String accessLevel,
    int? requiredCourseId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _KnowledgeDocumentImpl;

  factory KnowledgeDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return KnowledgeDocument(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      sourceType: jsonSerialization['sourceType'] as String,
      bookId: jsonSerialization['bookId'] as int?,
      accessLevel: jsonSerialization['accessLevel'] as String,
      requiredCourseId: jsonSerialization['requiredCourseId'] as int?,
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

  String sourceType;

  int? bookId;

  String accessLevel;

  int? requiredCourseId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [KnowledgeDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KnowledgeDocument copyWith({
    int? id,
    String? title,
    String? sourceType,
    int? bookId,
    String? accessLevel,
    int? requiredCourseId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KnowledgeDocument',
      if (id != null) 'id': id,
      'title': title,
      'sourceType': sourceType,
      if (bookId != null) 'bookId': bookId,
      'accessLevel': accessLevel,
      if (requiredCourseId != null) 'requiredCourseId': requiredCourseId,
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

class _KnowledgeDocumentImpl extends KnowledgeDocument {
  _KnowledgeDocumentImpl({
    int? id,
    required String title,
    required String sourceType,
    int? bookId,
    required String accessLevel,
    int? requiredCourseId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         title: title,
         sourceType: sourceType,
         bookId: bookId,
         accessLevel: accessLevel,
         requiredCourseId: requiredCourseId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [KnowledgeDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KnowledgeDocument copyWith({
    Object? id = _Undefined,
    String? title,
    String? sourceType,
    Object? bookId = _Undefined,
    String? accessLevel,
    Object? requiredCourseId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return KnowledgeDocument(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      sourceType: sourceType ?? this.sourceType,
      bookId: bookId is int? ? bookId : this.bookId,
      accessLevel: accessLevel ?? this.accessLevel,
      requiredCourseId: requiredCourseId is int?
          ? requiredCourseId
          : this.requiredCourseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
