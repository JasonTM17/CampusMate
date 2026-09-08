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

abstract class LibraryBookAuthor implements _i1.SerializableModel {
  LibraryBookAuthor._({
    this.id,
    required this.bookId,
    required this.authorId,
  });

  factory LibraryBookAuthor({
    int? id,
    required int bookId,
    required int authorId,
  }) = _LibraryBookAuthorImpl;

  factory LibraryBookAuthor.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookAuthor(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      authorId: jsonSerialization['authorId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookId;

  int authorId;

  /// Returns a shallow copy of this [LibraryBookAuthor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookAuthor copyWith({
    int? id,
    int? bookId,
    int? authorId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryBookAuthor',
      if (id != null) 'id': id,
      'bookId': bookId,
      'authorId': authorId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookAuthorImpl extends LibraryBookAuthor {
  _LibraryBookAuthorImpl({
    int? id,
    required int bookId,
    required int authorId,
  }) : super._(
         id: id,
         bookId: bookId,
         authorId: authorId,
       );

  /// Returns a shallow copy of this [LibraryBookAuthor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookAuthor copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? authorId,
  }) {
    return LibraryBookAuthor(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      authorId: authorId ?? this.authorId,
    );
  }
}
