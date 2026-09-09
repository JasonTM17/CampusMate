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

abstract class ReaderAsset
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ReaderAsset._({
    required this.bookId,
    required this.format,
    required this.assetUrl,
    required this.expiresAt,
  });

  factory ReaderAsset({
    required int bookId,
    required String format,
    required String assetUrl,
    required DateTime expiresAt,
  }) = _ReaderAssetImpl;

  factory ReaderAsset.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReaderAsset(
      bookId: jsonSerialization['bookId'] as int,
      format: jsonSerialization['format'] as String,
      assetUrl: jsonSerialization['assetUrl'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  int bookId;

  String format;

  String assetUrl;

  DateTime expiresAt;

  /// Returns a shallow copy of this [ReaderAsset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReaderAsset copyWith({
    int? bookId,
    String? format,
    String? assetUrl,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReaderAsset',
      'bookId': bookId,
      'format': format,
      'assetUrl': assetUrl,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReaderAsset',
      'bookId': bookId,
      'format': format,
      'assetUrl': assetUrl,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ReaderAssetImpl extends ReaderAsset {
  _ReaderAssetImpl({
    required int bookId,
    required String format,
    required String assetUrl,
    required DateTime expiresAt,
  }) : super._(
         bookId: bookId,
         format: format,
         assetUrl: assetUrl,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [ReaderAsset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReaderAsset copyWith({
    int? bookId,
    String? format,
    String? assetUrl,
    DateTime? expiresAt,
  }) {
    return ReaderAsset(
      bookId: bookId ?? this.bookId,
      format: format ?? this.format,
      assetUrl: assetUrl ?? this.assetUrl,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
