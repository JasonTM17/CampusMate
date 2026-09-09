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

abstract class BookLoanSummary implements _i1.SerializableModel {
  BookLoanSummary._({
    required this.id,
    required this.bookId,
    required this.copyId,
    required this.title,
    this.coverUrl,
    required this.borrowedAt,
    required this.dueAt,
    this.returnedAt,
    required this.status,
    required this.daysRemaining,
    required this.isOverdue,
  });

  factory BookLoanSummary({
    required int id,
    required int bookId,
    required int copyId,
    required String title,
    String? coverUrl,
    required DateTime borrowedAt,
    required DateTime dueAt,
    DateTime? returnedAt,
    required _i2.BookLoanStatus status,
    required int daysRemaining,
    required bool isOverdue,
  }) = _BookLoanSummaryImpl;

  factory BookLoanSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookLoanSummary(
      id: jsonSerialization['id'] as int,
      bookId: jsonSerialization['bookId'] as int,
      copyId: jsonSerialization['copyId'] as int,
      title: jsonSerialization['title'] as String,
      coverUrl: jsonSerialization['coverUrl'] as String?,
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
      daysRemaining: jsonSerialization['daysRemaining'] as int,
      isOverdue: _i1.BoolJsonExtension.fromJson(jsonSerialization['isOverdue']),
    );
  }

  int id;

  int bookId;

  int copyId;

  String title;

  String? coverUrl;

  DateTime borrowedAt;

  DateTime dueAt;

  DateTime? returnedAt;

  _i2.BookLoanStatus status;

  int daysRemaining;

  bool isOverdue;

  /// Returns a shallow copy of this [BookLoanSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookLoanSummary copyWith({
    int? id,
    int? bookId,
    int? copyId,
    String? title,
    String? coverUrl,
    DateTime? borrowedAt,
    DateTime? dueAt,
    DateTime? returnedAt,
    _i2.BookLoanStatus? status,
    int? daysRemaining,
    bool? isOverdue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookLoanSummary',
      'id': id,
      'bookId': bookId,
      'copyId': copyId,
      'title': title,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'borrowedAt': borrowedAt.toJson(),
      'dueAt': dueAt.toJson(),
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      'status': status.toJson(),
      'daysRemaining': daysRemaining,
      'isOverdue': isOverdue,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookLoanSummaryImpl extends BookLoanSummary {
  _BookLoanSummaryImpl({
    required int id,
    required int bookId,
    required int copyId,
    required String title,
    String? coverUrl,
    required DateTime borrowedAt,
    required DateTime dueAt,
    DateTime? returnedAt,
    required _i2.BookLoanStatus status,
    required int daysRemaining,
    required bool isOverdue,
  }) : super._(
         id: id,
         bookId: bookId,
         copyId: copyId,
         title: title,
         coverUrl: coverUrl,
         borrowedAt: borrowedAt,
         dueAt: dueAt,
         returnedAt: returnedAt,
         status: status,
         daysRemaining: daysRemaining,
         isOverdue: isOverdue,
       );

  /// Returns a shallow copy of this [BookLoanSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookLoanSummary copyWith({
    int? id,
    int? bookId,
    int? copyId,
    String? title,
    Object? coverUrl = _Undefined,
    DateTime? borrowedAt,
    DateTime? dueAt,
    Object? returnedAt = _Undefined,
    _i2.BookLoanStatus? status,
    int? daysRemaining,
    bool? isOverdue,
  }) {
    return BookLoanSummary(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      copyId: copyId ?? this.copyId,
      title: title ?? this.title,
      coverUrl: coverUrl is String? ? coverUrl : this.coverUrl,
      borrowedAt: borrowedAt ?? this.borrowedAt,
      dueAt: dueAt ?? this.dueAt,
      returnedAt: returnedAt is DateTime? ? returnedAt : this.returnedAt,
      status: status ?? this.status,
      daysRemaining: daysRemaining ?? this.daysRemaining,
      isOverdue: isOverdue ?? this.isOverdue,
    );
  }
}
