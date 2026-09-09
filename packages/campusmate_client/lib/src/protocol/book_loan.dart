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
import 'book_loan_status.dart' as _i2;

abstract class BookLoan implements _i1.SerializableModel {
  BookLoan._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.copyId,
    required this.borrowedAt,
    required this.dueAt,
    this.returnedAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookLoan({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required int copyId,
    required DateTime borrowedAt,
    required DateTime dueAt,
    DateTime? returnedAt,
    required _i2.BookLoanStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookLoanImpl;

  factory BookLoan.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookLoan(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      copyId: jsonSerialization['copyId'] as int,
      borrowedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['borrowedAt'],
      ),
      dueAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      returnedAt: jsonSerialization['returnedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['returnedAt']),
      status: _i2.BookLoanStatus.fromJson(
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

  _i1.UuidValue userId;

  int bookId;

  int copyId;

  DateTime borrowedAt;

  DateTime dueAt;

  DateTime? returnedAt;

  _i2.BookLoanStatus status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [BookLoan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookLoan copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    int? copyId,
    DateTime? borrowedAt,
    DateTime? dueAt,
    DateTime? returnedAt,
    _i2.BookLoanStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookLoan',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'copyId': copyId,
      'borrowedAt': borrowedAt.toJson(),
      'dueAt': dueAt.toJson(),
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
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

class _BookLoanImpl extends BookLoan {
  _BookLoanImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required int copyId,
    required DateTime borrowedAt,
    required DateTime dueAt,
    DateTime? returnedAt,
    required _i2.BookLoanStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         copyId: copyId,
         borrowedAt: borrowedAt,
         dueAt: dueAt,
         returnedAt: returnedAt,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BookLoan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookLoan copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    int? copyId,
    DateTime? borrowedAt,
    DateTime? dueAt,
    Object? returnedAt = _Undefined,
    _i2.BookLoanStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookLoan(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      copyId: copyId ?? this.copyId,
      borrowedAt: borrowedAt ?? this.borrowedAt,
      dueAt: dueAt ?? this.dueAt,
      returnedAt: returnedAt is DateTime? ? returnedAt : this.returnedAt,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
