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
import 'book_loan_summary.dart' as _i2;
import 'package:campusmate_client/src/protocol/protocol.dart' as _i3;

abstract class BookLoanPage implements _i1.SerializableModel {
  BookLoanPage._({
    required this.items,
    this.nextCursor,
    required this.serverNow,
  });

  factory BookLoanPage({
    required List<_i2.BookLoanSummary> items,
    String? nextCursor,
    required DateTime serverNow,
  }) = _BookLoanPageImpl;

  factory BookLoanPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookLoanPage(
      items: _i3.Protocol().deserialize<List<_i2.BookLoanSummary>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      serverNow: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverNow'],
      ),
    );
  }

  List<_i2.BookLoanSummary> items;

  String? nextCursor;

  DateTime serverNow;

  /// Returns a shallow copy of this [BookLoanPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookLoanPage copyWith({
    List<_i2.BookLoanSummary>? items,
    String? nextCursor,
    DateTime? serverNow,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookLoanPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'serverNow': serverNow.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookLoanPageImpl extends BookLoanPage {
  _BookLoanPageImpl({
    required List<_i2.BookLoanSummary> items,
    String? nextCursor,
    required DateTime serverNow,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         serverNow: serverNow,
       );

  /// Returns a shallow copy of this [BookLoanPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookLoanPage copyWith({
    List<_i2.BookLoanSummary>? items,
    Object? nextCursor = _Undefined,
    DateTime? serverNow,
  }) {
    return BookLoanPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      serverNow: serverNow ?? this.serverNow,
    );
  }
}
