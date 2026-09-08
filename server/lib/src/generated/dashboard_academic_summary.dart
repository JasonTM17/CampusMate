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

abstract class DashboardAcademicSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DashboardAcademicSummary._({
    required this.semesterName,
    required this.semesterGpa,
    required this.cumulativeGpa,
    required this.semesterCredits,
    required this.creditsEarned,
    required this.creditsRequired,
    required this.percentComplete,
    required this.activeCourses,
  });

  factory DashboardAcademicSummary({
    required String semesterName,
    required double semesterGpa,
    required double cumulativeGpa,
    required int semesterCredits,
    required int creditsEarned,
    required int creditsRequired,
    required double percentComplete,
    required int activeCourses,
  }) = _DashboardAcademicSummaryImpl;

  factory DashboardAcademicSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DashboardAcademicSummary(
      semesterName: jsonSerialization['semesterName'] as String,
      semesterGpa: (jsonSerialization['semesterGpa'] as num).toDouble(),
      cumulativeGpa: (jsonSerialization['cumulativeGpa'] as num).toDouble(),
      semesterCredits: jsonSerialization['semesterCredits'] as int,
      creditsEarned: jsonSerialization['creditsEarned'] as int,
      creditsRequired: jsonSerialization['creditsRequired'] as int,
      percentComplete: (jsonSerialization['percentComplete'] as num).toDouble(),
      activeCourses: jsonSerialization['activeCourses'] as int,
    );
  }

  String semesterName;

  double semesterGpa;

  double cumulativeGpa;

  int semesterCredits;

  int creditsEarned;

  int creditsRequired;

  double percentComplete;

  int activeCourses;

  /// Returns a shallow copy of this [DashboardAcademicSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardAcademicSummary copyWith({
    String? semesterName,
    double? semesterGpa,
    double? cumulativeGpa,
    int? semesterCredits,
    int? creditsEarned,
    int? creditsRequired,
    double? percentComplete,
    int? activeCourses,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardAcademicSummary',
      'semesterName': semesterName,
      'semesterGpa': semesterGpa,
      'cumulativeGpa': cumulativeGpa,
      'semesterCredits': semesterCredits,
      'creditsEarned': creditsEarned,
      'creditsRequired': creditsRequired,
      'percentComplete': percentComplete,
      'activeCourses': activeCourses,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardAcademicSummary',
      'semesterName': semesterName,
      'semesterGpa': semesterGpa,
      'cumulativeGpa': cumulativeGpa,
      'semesterCredits': semesterCredits,
      'creditsEarned': creditsEarned,
      'creditsRequired': creditsRequired,
      'percentComplete': percentComplete,
      'activeCourses': activeCourses,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardAcademicSummaryImpl extends DashboardAcademicSummary {
  _DashboardAcademicSummaryImpl({
    required String semesterName,
    required double semesterGpa,
    required double cumulativeGpa,
    required int semesterCredits,
    required int creditsEarned,
    required int creditsRequired,
    required double percentComplete,
    required int activeCourses,
  }) : super._(
         semesterName: semesterName,
         semesterGpa: semesterGpa,
         cumulativeGpa: cumulativeGpa,
         semesterCredits: semesterCredits,
         creditsEarned: creditsEarned,
         creditsRequired: creditsRequired,
         percentComplete: percentComplete,
         activeCourses: activeCourses,
       );

  /// Returns a shallow copy of this [DashboardAcademicSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardAcademicSummary copyWith({
    String? semesterName,
    double? semesterGpa,
    double? cumulativeGpa,
    int? semesterCredits,
    int? creditsEarned,
    int? creditsRequired,
    double? percentComplete,
    int? activeCourses,
  }) {
    return DashboardAcademicSummary(
      semesterName: semesterName ?? this.semesterName,
      semesterGpa: semesterGpa ?? this.semesterGpa,
      cumulativeGpa: cumulativeGpa ?? this.cumulativeGpa,
      semesterCredits: semesterCredits ?? this.semesterCredits,
      creditsEarned: creditsEarned ?? this.creditsEarned,
      creditsRequired: creditsRequired ?? this.creditsRequired,
      percentComplete: percentComplete ?? this.percentComplete,
      activeCourses: activeCourses ?? this.activeCourses,
    );
  }
}
