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

abstract class BookFavoriteStatus
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  BookFavoriteStatus._({
    required this.bookId,
    required this.isFavorite,
  });

  factory BookFavoriteStatus({
    required int bookId,
    required bool isFavorite,
  }) = _BookFavoriteStatusImpl;

  factory BookFavoriteStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookFavoriteStatus(
      bookId: jsonSerialization['bookId'] as int,
      isFavorite: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isFavorite'],
      ),
    );
  }

  int bookId;

  bool isFavorite;

  /// Returns a shallow copy of this [BookFavoriteStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookFavoriteStatus copyWith({
    int? bookId,
    bool? isFavorite,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookFavoriteStatus',
      'bookId': bookId,
      'isFavorite': isFavorite,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookFavoriteStatus',
      'bookId': bookId,
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BookFavoriteStatusImpl extends BookFavoriteStatus {
  _BookFavoriteStatusImpl({
    required int bookId,
    required bool isFavorite,
  }) : super._(
         bookId: bookId,
         isFavorite: isFavorite,
       );

  /// Returns a shallow copy of this [BookFavoriteStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookFavoriteStatus copyWith({
    int? bookId,
    bool? isFavorite,
  }) {
    return BookFavoriteStatus(
      bookId: bookId ?? this.bookId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
