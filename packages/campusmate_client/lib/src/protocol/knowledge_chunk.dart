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

abstract class KnowledgeChunk implements _i1.SerializableModel {
  KnowledgeChunk._({
    this.id,
    required this.documentId,
    this.bookId,
    required this.title,
    this.chapter,
    this.page,
    required this.content,
    required this.embedding,
    required this.createdAt,
  });

  factory KnowledgeChunk({
    int? id,
    required int documentId,
    int? bookId,
    required String title,
    String? chapter,
    int? page,
    required String content,
    required _i1.Vector embedding,
    required DateTime createdAt,
  }) = _KnowledgeChunkImpl;

  factory KnowledgeChunk.fromJson(Map<String, dynamic> jsonSerialization) {
    return KnowledgeChunk(
      id: jsonSerialization['id'] as int?,
      documentId: jsonSerialization['documentId'] as int,
      bookId: jsonSerialization['bookId'] as int?,
      title: jsonSerialization['title'] as String,
      chapter: jsonSerialization['chapter'] as String?,
      page: jsonSerialization['page'] as int?,
      content: jsonSerialization['content'] as String,
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int documentId;

  int? bookId;

  String title;

  String? chapter;

  int? page;

  String content;

  _i1.Vector embedding;

  DateTime createdAt;

  /// Returns a shallow copy of this [KnowledgeChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KnowledgeChunk copyWith({
    int? id,
    int? documentId,
    int? bookId,
    String? title,
    String? chapter,
    int? page,
    String? content,
    _i1.Vector? embedding,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KnowledgeChunk',
      if (id != null) 'id': id,
      'documentId': documentId,
      if (bookId != null) 'bookId': bookId,
      'title': title,
      if (chapter != null) 'chapter': chapter,
      if (page != null) 'page': page,
      'content': content,
      'embedding': embedding.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KnowledgeChunkImpl extends KnowledgeChunk {
  _KnowledgeChunkImpl({
    int? id,
    required int documentId,
    int? bookId,
    required String title,
    String? chapter,
    int? page,
    required String content,
    required _i1.Vector embedding,
    required DateTime createdAt,
  }) : super._(
         id: id,
         documentId: documentId,
         bookId: bookId,
         title: title,
         chapter: chapter,
         page: page,
         content: content,
         embedding: embedding,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [KnowledgeChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KnowledgeChunk copyWith({
    Object? id = _Undefined,
    int? documentId,
    Object? bookId = _Undefined,
    String? title,
    Object? chapter = _Undefined,
    Object? page = _Undefined,
    String? content,
    _i1.Vector? embedding,
    DateTime? createdAt,
  }) {
    return KnowledgeChunk(
      id: id is int? ? id : this.id,
      documentId: documentId ?? this.documentId,
      bookId: bookId is int? ? bookId : this.bookId,
      title: title ?? this.title,
      chapter: chapter is String? ? chapter : this.chapter,
      page: page is int? ? page : this.page,
      content: content ?? this.content,
      embedding: embedding ?? this.embedding.clone(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
