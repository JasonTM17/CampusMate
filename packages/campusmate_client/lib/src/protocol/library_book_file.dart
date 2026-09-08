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

abstract class LibraryBookFile implements _i1.SerializableModel {
  LibraryBookFile._({
    this.id,
    required this.bookId,
    required this.format,
    required this.storageKey,
    required this.byteSize,
    required this.checksum,
    required this.isPrimary,
    required this.createdAt,
  });

  factory LibraryBookFile({
    int? id,
    required int bookId,
    required String format,
    required String storageKey,
    required int byteSize,
    required String checksum,
    required bool isPrimary,
    required DateTime createdAt,
  }) = _LibraryBookFileImpl;

  factory LibraryBookFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookFile(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      format: jsonSerialization['format'] as String,
      storageKey: jsonSerialization['storageKey'] as String,
      byteSize: jsonSerialization['byteSize'] as int,
      checksum: jsonSerialization['checksum'] as String,
      isPrimary: _i1.BoolJsonExtension.fromJson(jsonSerialization['isPrimary']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookId;

  String format;

  String storageKey;

  int byteSize;

  String checksum;

  bool isPrimary;

  DateTime createdAt;

  /// Returns a shallow copy of this [LibraryBookFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookFile copyWith({
    int? id,
    int? bookId,
    String? format,
    String? storageKey,
    int? byteSize,
    String? checksum,
    bool? isPrimary,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryBookFile',
      if (id != null) 'id': id,
      'bookId': bookId,
      'format': format,
      'storageKey': storageKey,
      'byteSize': byteSize,
      'checksum': checksum,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookFileImpl extends LibraryBookFile {
  _LibraryBookFileImpl({
    int? id,
    required int bookId,
    required String format,
    required String storageKey,
    required int byteSize,
    required String checksum,
    required bool isPrimary,
    required DateTime createdAt,
  }) : super._(
         id: id,
         bookId: bookId,
         format: format,
         storageKey: storageKey,
         byteSize: byteSize,
         checksum: checksum,
         isPrimary: isPrimary,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [LibraryBookFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookFile copyWith({
    Object? id = _Undefined,
    int? bookId,
    String? format,
    String? storageKey,
    int? byteSize,
    String? checksum,
    bool? isPrimary,
    DateTime? createdAt,
  }) {
    return LibraryBookFile(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      format: format ?? this.format,
      storageKey: storageKey ?? this.storageKey,
      byteSize: byteSize ?? this.byteSize,
      checksum: checksum ?? this.checksum,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
