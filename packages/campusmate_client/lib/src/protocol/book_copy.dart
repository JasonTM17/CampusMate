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
import 'book_copy_status.dart' as _i2;

abstract class BookCopy implements _i1.SerializableModel {
  BookCopy._({
    this.id,
    required this.bookId,
    required this.barcode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookCopy({
    int? id,
    required int bookId,
    required String barcode,
    required _i2.BookCopyStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookCopyImpl;

  factory BookCopy.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookCopy(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      barcode: jsonSerialization['barcode'] as String,
      status: _i2.BookCopyStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
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

  int bookId;

  String barcode;

  _i2.BookCopyStatus status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [BookCopy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookCopy copyWith({
    int? id,
    int? bookId,
    String? barcode,
    _i2.BookCopyStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookCopy',
      if (id != null) 'id': id,
      'bookId': bookId,
      'barcode': barcode,
      'status': status.toJson(),
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

class _BookCopyImpl extends BookCopy {
  _BookCopyImpl({
    int? id,
    required int bookId,
    required String barcode,
    required _i2.BookCopyStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         bookId: bookId,
         barcode: barcode,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BookCopy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookCopy copyWith({
    Object? id = _Undefined,
    int? bookId,
    String? barcode,
    _i2.BookCopyStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookCopy(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      barcode: barcode ?? this.barcode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
