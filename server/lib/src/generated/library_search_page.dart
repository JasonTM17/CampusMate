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

import 'package:serverpod/serverpod.dart' as _i1;
import 'book_summary.dart' as _i2;
import 'package:campusmate_server/src/generated/protocol.dart' as _i3;

abstract class LibrarySearchPage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LibrarySearchPage._({
    required this.items,
    this.nextCursor,
    required this.totalCount,
  });

  factory LibrarySearchPage({
    required List<_i2.BookSummary> items,
    String? nextCursor,
    required int totalCount,
  }) = _LibrarySearchPageImpl;

  factory LibrarySearchPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibrarySearchPage(
      items: _i3.Protocol().deserialize<List<_i2.BookSummary>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      totalCount: jsonSerialization['totalCount'] as int,
    );
  }

  List<_i2.BookSummary> items;

  String? nextCursor;

  int totalCount;

  /// Returns a shallow copy of this [LibrarySearchPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibrarySearchPage copyWith({
    List<_i2.BookSummary>? items,
    String? nextCursor,
    int? totalCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibrarySearchPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'totalCount': totalCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibrarySearchPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'totalCount': totalCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibrarySearchPageImpl extends LibrarySearchPage {
  _LibrarySearchPageImpl({
    required List<_i2.BookSummary> items,
    String? nextCursor,
    required int totalCount,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         totalCount: totalCount,
       );

  /// Returns a shallow copy of this [LibrarySearchPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibrarySearchPage copyWith({
    List<_i2.BookSummary>? items,
    Object? nextCursor = _Undefined,
    int? totalCount,
  }) {
    return LibrarySearchPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
