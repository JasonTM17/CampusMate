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
import 'book_access_type.dart' as _i2;

abstract class BookAccessPolicyUpdate implements _i1.SerializableModel {
  BookAccessPolicyUpdate._({
    required this.bookId,
    required this.accessType,
    required this.updatedAt,
  });

  factory BookAccessPolicyUpdate({
    required int bookId,
    required _i2.BookAccessType accessType,
    required DateTime updatedAt,
  }) = _BookAccessPolicyUpdateImpl;

  factory BookAccessPolicyUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BookAccessPolicyUpdate(
      bookId: jsonSerialization['bookId'] as int,
      accessType: _i2.BookAccessType.fromJson(
        (jsonSerialization['accessType'] as String),
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  int bookId;

  _i2.BookAccessType accessType;

  DateTime updatedAt;

  /// Returns a shallow copy of this [BookAccessPolicyUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookAccessPolicyUpdate copyWith({
    int? bookId,
    _i2.BookAccessType? accessType,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookAccessPolicyUpdate',
      'bookId': bookId,
      'accessType': accessType.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BookAccessPolicyUpdateImpl extends BookAccessPolicyUpdate {
  _BookAccessPolicyUpdateImpl({
    required int bookId,
    required _i2.BookAccessType accessType,
    required DateTime updatedAt,
  }) : super._(
         bookId: bookId,
         accessType: accessType,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BookAccessPolicyUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookAccessPolicyUpdate copyWith({
    int? bookId,
    _i2.BookAccessType? accessType,
    DateTime? updatedAt,
  }) {
    return BookAccessPolicyUpdate(
      bookId: bookId ?? this.bookId,
      accessType: accessType ?? this.accessType,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
