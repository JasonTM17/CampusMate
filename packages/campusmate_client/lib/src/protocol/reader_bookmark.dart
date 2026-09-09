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

abstract class ReaderBookmark implements _i1.SerializableModel {
  ReaderBookmark._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.location,
    required this.title,
    required this.createdAt,
  });

  factory ReaderBookmark({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String title,
    required DateTime createdAt,
  }) = _ReaderBookmarkImpl;

  factory ReaderBookmark.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReaderBookmark(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      location: jsonSerialization['location'] as String,
      title: jsonSerialization['title'] as String,
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

  int bookId;

  String location;

  String title;

  DateTime createdAt;

  /// Returns a shallow copy of this [ReaderBookmark]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReaderBookmark copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? title,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReaderBookmark',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'location': location,
      'title': title,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReaderBookmarkImpl extends ReaderBookmark {
  _ReaderBookmarkImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String title,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         location: location,
         title: title,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ReaderBookmark]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReaderBookmark copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? title,
    DateTime? createdAt,
  }) {
    return ReaderBookmark(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      location: location ?? this.location,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
