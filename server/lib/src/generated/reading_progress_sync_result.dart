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

abstract class ReadingProgressSyncResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ReadingProgressSyncResult._({
    required this.bookId,
    required this.progressPercent,
    required this.currentLocation,
    required this.updatedAt,
    required this.appliedClientUpdate,
  });

  factory ReadingProgressSyncResult({
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime updatedAt,
    required bool appliedClientUpdate,
  }) = _ReadingProgressSyncResultImpl;

  factory ReadingProgressSyncResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ReadingProgressSyncResult(
      bookId: jsonSerialization['bookId'] as int,
      progressPercent: (jsonSerialization['progressPercent'] as num).toDouble(),
      currentLocation: jsonSerialization['currentLocation'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      appliedClientUpdate: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['appliedClientUpdate'],
      ),
    );
  }

  int bookId;

  double progressPercent;

  String currentLocation;

  DateTime updatedAt;

  bool appliedClientUpdate;

  /// Returns a shallow copy of this [ReadingProgressSyncResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReadingProgressSyncResult copyWith({
    int? bookId,
    double? progressPercent,
    String? currentLocation,
    DateTime? updatedAt,
    bool? appliedClientUpdate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReadingProgressSyncResult',
      'bookId': bookId,
      'progressPercent': progressPercent,
      'currentLocation': currentLocation,
      'updatedAt': updatedAt.toJson(),
      'appliedClientUpdate': appliedClientUpdate,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReadingProgressSyncResult',
      'bookId': bookId,
      'progressPercent': progressPercent,
      'currentLocation': currentLocation,
      'updatedAt': updatedAt.toJson(),
      'appliedClientUpdate': appliedClientUpdate,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ReadingProgressSyncResultImpl extends ReadingProgressSyncResult {
  _ReadingProgressSyncResultImpl({
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime updatedAt,
    required bool appliedClientUpdate,
  }) : super._(
         bookId: bookId,
         progressPercent: progressPercent,
         currentLocation: currentLocation,
         updatedAt: updatedAt,
         appliedClientUpdate: appliedClientUpdate,
       );

  /// Returns a shallow copy of this [ReadingProgressSyncResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReadingProgressSyncResult copyWith({
    int? bookId,
    double? progressPercent,
    String? currentLocation,
    DateTime? updatedAt,
    bool? appliedClientUpdate,
  }) {
    return ReadingProgressSyncResult(
      bookId: bookId ?? this.bookId,
      progressPercent: progressPercent ?? this.progressPercent,
      currentLocation: currentLocation ?? this.currentLocation,
      updatedAt: updatedAt ?? this.updatedAt,
      appliedClientUpdate: appliedClientUpdate ?? this.appliedClientUpdate,
    );
  }
}
