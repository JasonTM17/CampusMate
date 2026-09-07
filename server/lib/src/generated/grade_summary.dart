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
import 'semester_summary.dart' as _i2;
import 'course_summary.dart' as _i3;
import 'package:campusmate_server/src/generated/protocol.dart' as _i4;

abstract class GradeSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GradeSummary._({
    required this.semester,
    required this.courses,
    required this.semesterGpa,
    required this.cumulativeGpa,
    required this.creditsEarned,
    required this.creditsAttempted,
  });

  factory GradeSummary({
    required _i2.SemesterSummary semester,
    required List<_i3.CourseSummary> courses,
    required double semesterGpa,
    required double cumulativeGpa,
    required int creditsEarned,
    required int creditsAttempted,
  }) = _GradeSummaryImpl;

  factory GradeSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return GradeSummary(
      semester: _i4.Protocol().deserialize<_i2.SemesterSummary>(
        jsonSerialization['semester'],
      ),
      courses: _i4.Protocol().deserialize<List<_i3.CourseSummary>>(
        jsonSerialization['courses'],
      ),
      semesterGpa: (jsonSerialization['semesterGpa'] as num).toDouble(),
      cumulativeGpa: (jsonSerialization['cumulativeGpa'] as num).toDouble(),
      creditsEarned: jsonSerialization['creditsEarned'] as int,
      creditsAttempted: jsonSerialization['creditsAttempted'] as int,
    );
  }

  _i2.SemesterSummary semester;

  List<_i3.CourseSummary> courses;

  double semesterGpa;

  double cumulativeGpa;

  int creditsEarned;

  int creditsAttempted;

  /// Returns a shallow copy of this [GradeSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GradeSummary copyWith({
    _i2.SemesterSummary? semester,
    List<_i3.CourseSummary>? courses,
    double? semesterGpa,
    double? cumulativeGpa,
    int? creditsEarned,
    int? creditsAttempted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GradeSummary',
      'semester': semester.toJson(),
      'courses': courses.toJson(valueToJson: (v) => v.toJson()),
      'semesterGpa': semesterGpa,
      'cumulativeGpa': cumulativeGpa,
      'creditsEarned': creditsEarned,
      'creditsAttempted': creditsAttempted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GradeSummary',
      'semester': semester.toJsonForProtocol(),
      'courses': courses.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'semesterGpa': semesterGpa,
      'cumulativeGpa': cumulativeGpa,
      'creditsEarned': creditsEarned,
      'creditsAttempted': creditsAttempted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GradeSummaryImpl extends GradeSummary {
  _GradeSummaryImpl({
    required _i2.SemesterSummary semester,
    required List<_i3.CourseSummary> courses,
    required double semesterGpa,
    required double cumulativeGpa,
    required int creditsEarned,
    required int creditsAttempted,
  }) : super._(
         semester: semester,
         courses: courses,
         semesterGpa: semesterGpa,
         cumulativeGpa: cumulativeGpa,
         creditsEarned: creditsEarned,
         creditsAttempted: creditsAttempted,
       );

  /// Returns a shallow copy of this [GradeSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GradeSummary copyWith({
    _i2.SemesterSummary? semester,
    List<_i3.CourseSummary>? courses,
    double? semesterGpa,
    double? cumulativeGpa,
    int? creditsEarned,
    int? creditsAttempted,
  }) {
    return GradeSummary(
      semester: semester ?? this.semester.copyWith(),
      courses: courses ?? this.courses.map((e0) => e0.copyWith()).toList(),
      semesterGpa: semesterGpa ?? this.semesterGpa,
      cumulativeGpa: cumulativeGpa ?? this.cumulativeGpa,
      creditsEarned: creditsEarned ?? this.creditsEarned,
      creditsAttempted: creditsAttempted ?? this.creditsAttempted,
    );
  }
}
