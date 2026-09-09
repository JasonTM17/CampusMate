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

abstract class BookUploadTicket
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  BookUploadTicket._({
    required this.bookId,
    required this.uploadToken,
    required this.storageKey,
    required this.format,
    required this.maxSizeBytes,
    required this.expiresAt,
  });

  factory BookUploadTicket({
    required int bookId,
    required String uploadToken,
    required String storageKey,
    required String format,
    required int maxSizeBytes,
    required DateTime expiresAt,
  }) = _BookUploadTicketImpl;

  factory BookUploadTicket.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookUploadTicket(
      bookId: jsonSerialization['bookId'] as int,
      uploadToken: jsonSerialization['uploadToken'] as String,
      storageKey: jsonSerialization['storageKey'] as String,
      format: jsonSerialization['format'] as String,
      maxSizeBytes: jsonSerialization['maxSizeBytes'] as int,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  int bookId;

  String uploadToken;

  String storageKey;

  String format;

  int maxSizeBytes;

  DateTime expiresAt;

  /// Returns a shallow copy of this [BookUploadTicket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookUploadTicket copyWith({
    int? bookId,
    String? uploadToken,
    String? storageKey,
    String? format,
    int? maxSizeBytes,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookUploadTicket',
      'bookId': bookId,
      'uploadToken': uploadToken,
      'storageKey': storageKey,
      'format': format,
      'maxSizeBytes': maxSizeBytes,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookUploadTicket',
      'bookId': bookId,
      'uploadToken': uploadToken,
      'storageKey': storageKey,
      'format': format,
      'maxSizeBytes': maxSizeBytes,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BookUploadTicketImpl extends BookUploadTicket {
  _BookUploadTicketImpl({
    required int bookId,
    required String uploadToken,
    required String storageKey,
    required String format,
    required int maxSizeBytes,
    required DateTime expiresAt,
  }) : super._(
         bookId: bookId,
         uploadToken: uploadToken,
         storageKey: storageKey,
         format: format,
         maxSizeBytes: maxSizeBytes,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [BookUploadTicket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookUploadTicket copyWith({
    int? bookId,
    String? uploadToken,
    String? storageKey,
    String? format,
    int? maxSizeBytes,
    DateTime? expiresAt,
  }) {
    return BookUploadTicket(
      bookId: bookId ?? this.bookId,
      uploadToken: uploadToken ?? this.uploadToken,
      storageKey: storageKey ?? this.storageKey,
      format: format ?? this.format,
      maxSizeBytes: maxSizeBytes ?? this.maxSizeBytes,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
