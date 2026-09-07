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

abstract class Enrollment implements _i1.SerializableModel {
  Enrollment._({
    this.id,
    required this.studentProfileId,
    required this.offeringId,
    required this.status,
    required this.progressPercent,
    required this.attendancePercent,
  });

  factory Enrollment({
    int? id,
    required int studentProfileId,
    required int offeringId,
    required String status,
    required double progressPercent,
    required double attendancePercent,
  }) = _EnrollmentImpl;

  factory Enrollment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Enrollment(
      id: jsonSerialization['id'] as int?,
      studentProfileId: jsonSerialization['studentProfileId'] as int,
      offeringId: jsonSerialization['offeringId'] as int,
      status: jsonSerialization['status'] as String,
      progressPercent: (jsonSerialization['progressPercent'] as num).toDouble(),
      attendancePercent: (jsonSerialization['attendancePercent'] as num)
          .toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int studentProfileId;

  int offeringId;

  String status;

  double progressPercent;

  double attendancePercent;

  /// Returns a shallow copy of this [Enrollment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Enrollment copyWith({
    int? id,
    int? studentProfileId,
    int? offeringId,
    String? status,
    double? progressPercent,
    double? attendancePercent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Enrollment',
      if (id != null) 'id': id,
      'studentProfileId': studentProfileId,
      'offeringId': offeringId,
      'status': status,
      'progressPercent': progressPercent,
      'attendancePercent': attendancePercent,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EnrollmentImpl extends Enrollment {
  _EnrollmentImpl({
    int? id,
    required int studentProfileId,
    required int offeringId,
    required String status,
    required double progressPercent,
    required double attendancePercent,
  }) : super._(
         id: id,
         studentProfileId: studentProfileId,
         offeringId: offeringId,
         status: status,
         progressPercent: progressPercent,
         attendancePercent: attendancePercent,
       );

  /// Returns a shallow copy of this [Enrollment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Enrollment copyWith({
    Object? id = _Undefined,
    int? studentProfileId,
    int? offeringId,
    String? status,
    double? progressPercent,
    double? attendancePercent,
  }) {
    return Enrollment(
      id: id is int? ? id : this.id,
      studentProfileId: studentProfileId ?? this.studentProfileId,
      offeringId: offeringId ?? this.offeringId,
      status: status ?? this.status,
      progressPercent: progressPercent ?? this.progressPercent,
      attendancePercent: attendancePercent ?? this.attendancePercent,
    );
  }
}
