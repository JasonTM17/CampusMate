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

abstract class LibraryBookCategory implements _i1.SerializableModel {
  LibraryBookCategory._({
    this.id,
    required this.bookId,
    required this.categoryId,
  });

  factory LibraryBookCategory({
    int? id,
    required int bookId,
    required int categoryId,
  }) = _LibraryBookCategoryImpl;

  factory LibraryBookCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookCategory(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      categoryId: jsonSerialization['categoryId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookId;

  int categoryId;

  /// Returns a shallow copy of this [LibraryBookCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookCategory copyWith({
    int? id,
    int? bookId,
    int? categoryId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryBookCategory',
      if (id != null) 'id': id,
      'bookId': bookId,
      'categoryId': categoryId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookCategoryImpl extends LibraryBookCategory {
  _LibraryBookCategoryImpl({
    int? id,
    required int bookId,
    required int categoryId,
  }) : super._(
         id: id,
         bookId: bookId,
         categoryId: categoryId,
       );

  /// Returns a shallow copy of this [LibraryBookCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookCategory copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? categoryId,
  }) {
    return LibraryBookCategory(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
