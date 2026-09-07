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

abstract class CourseSummary implements _i1.SerializableModel {
  CourseSummary._({
    required this.offeringId,
    required this.courseCode,
    required this.title,
    required this.credits,
    required this.lecturerName,
    required this.section,
    required this.status,
    required this.progressPercent,
    required this.attendancePercent,
    this.finalScore,
    this.letter,
  });

  factory CourseSummary({
    required int offeringId,
    required String courseCode,
    required String title,
    required int credits,
    required String lecturerName,
    required String section,
    required String status,
    required double progressPercent,
    required double attendancePercent,
    double? finalScore,
    String? letter,
  }) = _CourseSummaryImpl;

  factory CourseSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseSummary(
      offeringId: jsonSerialization['offeringId'] as int,
      courseCode: jsonSerialization['courseCode'] as String,
      title: jsonSerialization['title'] as String,
      credits: jsonSerialization['credits'] as int,
      lecturerName: jsonSerialization['lecturerName'] as String,
      section: jsonSerialization['section'] as String,
      status: jsonSerialization['status'] as String,
      progressPercent: (jsonSerialization['progressPercent'] as num).toDouble(),
      attendancePercent: (jsonSerialization['attendancePercent'] as num)
          .toDouble(),
      finalScore: (jsonSerialization['finalScore'] as num?)?.toDouble(),
      letter: jsonSerialization['letter'] as String?,
    );
  }

  int offeringId;

  String courseCode;

  String title;

  int credits;

  String lecturerName;

  String section;

  String status;

  double progressPercent;

  double attendancePercent;

  double? finalScore;

  String? letter;

  /// Returns a shallow copy of this [CourseSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseSummary copyWith({
    int? offeringId,
    String? courseCode,
    String? title,
    int? credits,
    String? lecturerName,
    String? section,
    String? status,
    double? progressPercent,
    double? attendancePercent,
    double? finalScore,
    String? letter,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseSummary',
      'offeringId': offeringId,
      'courseCode': courseCode,
      'title': title,
      'credits': credits,
      'lecturerName': lecturerName,
      'section': section,
      'status': status,
      'progressPercent': progressPercent,
      'attendancePercent': attendancePercent,
      if (finalScore != null) 'finalScore': finalScore,
      if (letter != null) 'letter': letter,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseSummaryImpl extends CourseSummary {
  _CourseSummaryImpl({
    required int offeringId,
    required String courseCode,
    required String title,
    required int credits,
    required String lecturerName,
    required String section,
    required String status,
    required double progressPercent,
    required double attendancePercent,
    double? finalScore,
    String? letter,
  }) : super._(
         offeringId: offeringId,
         courseCode: courseCode,
         title: title,
         credits: credits,
         lecturerName: lecturerName,
         section: section,
         status: status,
         progressPercent: progressPercent,
         attendancePercent: attendancePercent,
         finalScore: finalScore,
         letter: letter,
       );

  /// Returns a shallow copy of this [CourseSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseSummary copyWith({
    int? offeringId,
    String? courseCode,
    String? title,
    int? credits,
    String? lecturerName,
    String? section,
    String? status,
    double? progressPercent,
    double? attendancePercent,
    Object? finalScore = _Undefined,
    Object? letter = _Undefined,
  }) {
    return CourseSummary(
      offeringId: offeringId ?? this.offeringId,
      courseCode: courseCode ?? this.courseCode,
      title: title ?? this.title,
      credits: credits ?? this.credits,
      lecturerName: lecturerName ?? this.lecturerName,
      section: section ?? this.section,
      status: status ?? this.status,
      progressPercent: progressPercent ?? this.progressPercent,
      attendancePercent: attendancePercent ?? this.attendancePercent,
      finalScore: finalScore is double? ? finalScore : this.finalScore,
      letter: letter is String? ? letter : this.letter,
    );
  }
}
