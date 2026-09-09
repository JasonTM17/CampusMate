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

abstract class ReadingProgress implements _i1.SerializableModel {
  ReadingProgress._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.progressPercent,
    required this.currentLocation,
    required this.updatedAt,
  });

  factory ReadingProgress({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime updatedAt,
  }) = _ReadingProgressImpl;

  factory ReadingProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReadingProgress(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      progressPercent: (jsonSerialization['progressPercent'] as num).toDouble(),
      currentLocation: jsonSerialization['currentLocation'] as String,
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

  double progressPercent;

  String currentLocation;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ReadingProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReadingProgress copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    double? progressPercent,
    String? currentLocation,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReadingProgress',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'progressPercent': progressPercent,
      'currentLocation': currentLocation,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReadingProgressImpl extends ReadingProgress {
  _ReadingProgressImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         progressPercent: progressPercent,
         currentLocation: currentLocation,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ReadingProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReadingProgress copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    double? progressPercent,
    String? currentLocation,
    DateTime? updatedAt,
  }) {
    return ReadingProgress(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      progressPercent: progressPercent ?? this.progressPercent,
      currentLocation: currentLocation ?? this.currentLocation,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
