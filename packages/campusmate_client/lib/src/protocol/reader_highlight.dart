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

abstract class ReaderHighlight implements _i1.SerializableModel {
  ReaderHighlight._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.location,
    required this.text,
    required this.colorToken,
    required this.createdAt,
  });

  factory ReaderHighlight({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
    required DateTime createdAt,
  }) = _ReaderHighlightImpl;

  factory ReaderHighlight.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReaderHighlight(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      location: jsonSerialization['location'] as String,
      text: jsonSerialization['text'] as String,
      colorToken: jsonSerialization['colorToken'] as String,
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

  String text;

  String colorToken;

  DateTime createdAt;

  /// Returns a shallow copy of this [ReaderHighlight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReaderHighlight copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? text,
    String? colorToken,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReaderHighlight',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'location': location,
      'text': text,
      'colorToken': colorToken,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReaderHighlightImpl extends ReaderHighlight {
  _ReaderHighlightImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         location: location,
         text: text,
         colorToken: colorToken,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ReaderHighlight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReaderHighlight copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? text,
    String? colorToken,
    DateTime? createdAt,
  }) {
    return ReaderHighlight(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      location: location ?? this.location,
      text: text ?? this.text,
      colorToken: colorToken ?? this.colorToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
