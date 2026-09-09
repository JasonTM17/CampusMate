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

abstract class ReaderNote implements _i1.SerializableModel {
  ReaderNote._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.location,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReaderNote({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReaderNoteImpl;

  factory ReaderNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReaderNote(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      location: jsonSerialization['location'] as String,
      content: jsonSerialization['content'] as String,
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

  _i1.UuidValue userId;

  int bookId;

  String location;

  String content;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ReaderNote]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReaderNote copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReaderNote',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'location': location,
      'content': content,
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

class _ReaderNoteImpl extends ReaderNote {
  _ReaderNoteImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         location: location,
         content: content,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ReaderNote]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReaderNote copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReaderNote(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      location: location ?? this.location,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
