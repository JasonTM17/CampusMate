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
import 'semester_summary.dart' as _i2;
import 'course_summary.dart' as _i3;
import 'timetable_entry.dart' as _i4;
import 'exam_summary.dart' as _i5;
import 'curriculum_progress.dart' as _i6;
import 'package:campusmate_client/src/protocol/protocol.dart' as _i7;

abstract class AcademicOverview implements _i1.SerializableModel {
  AcademicOverview._({
    required this.currentSemester,
    required this.availableSemesters,
    required this.courses,
    required this.today,
    required this.upcomingExams,
    required this.progress,
    required this.semesterGpa,
    required this.cumulativeGpa,
    required this.creditsEarned,
    required this.creditsRequired,
    required this.syncedAt,
  });

  factory AcademicOverview({
    required _i2.SemesterSummary currentSemester,
    required List<_i2.SemesterSummary> availableSemesters,
    required List<_i3.CourseSummary> courses,
    required List<_i4.TimetableEntry> today,
    required List<_i5.ExamSummary> upcomingExams,
    required _i6.CurriculumProgress progress,
    required double semesterGpa,
    required double cumulativeGpa,
    required int creditsEarned,
    required int creditsRequired,
    required DateTime syncedAt,
  }) = _AcademicOverviewImpl;

  factory AcademicOverview.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicOverview(
      currentSemester: _i7.Protocol().deserialize<_i2.SemesterSummary>(
        jsonSerialization['currentSemester'],
      ),
      availableSemesters: _i7.Protocol().deserialize<List<_i2.SemesterSummary>>(
        jsonSerialization['availableSemesters'],
      ),
      courses: _i7.Protocol().deserialize<List<_i3.CourseSummary>>(
        jsonSerialization['courses'],
      ),
      today: _i7.Protocol().deserialize<List<_i4.TimetableEntry>>(
        jsonSerialization['today'],
      ),
      upcomingExams: _i7.Protocol().deserialize<List<_i5.ExamSummary>>(
        jsonSerialization['upcomingExams'],
      ),
      progress: _i7.Protocol().deserialize<_i6.CurriculumProgress>(
        jsonSerialization['progress'],
      ),
      semesterGpa: (jsonSerialization['semesterGpa'] as num).toDouble(),
      cumulativeGpa: (jsonSerialization['cumulativeGpa'] as num).toDouble(),
      creditsEarned: jsonSerialization['creditsEarned'] as int,
      creditsRequired: jsonSerialization['creditsRequired'] as int,
      syncedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['syncedAt'],
      ),
    );
  }

  _i2.SemesterSummary currentSemester;

  List<_i2.SemesterSummary> availableSemesters;

  List<_i3.CourseSummary> courses;

  List<_i4.TimetableEntry> today;

  List<_i5.ExamSummary> upcomingExams;

  _i6.CurriculumProgress progress;

  double semesterGpa;

  double cumulativeGpa;

  int creditsEarned;

  int creditsRequired;

  DateTime syncedAt;

  /// Returns a shallow copy of this [AcademicOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AcademicOverview copyWith({
    _i2.SemesterSummary? currentSemester,
    List<_i2.SemesterSummary>? availableSemesters,
    List<_i3.CourseSummary>? courses,
    List<_i4.TimetableEntry>? today,
    List<_i5.ExamSummary>? upcomingExams,
    _i6.CurriculumProgress? progress,
    double? semesterGpa,
    double? cumulativeGpa,
    int? creditsEarned,
    int? creditsRequired,
    DateTime? syncedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcademicOverview',
      'currentSemester': currentSemester.toJson(),
      'availableSemesters': availableSemesters.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'courses': courses.toJson(valueToJson: (v) => v.toJson()),
      'today': today.toJson(valueToJson: (v) => v.toJson()),
      'upcomingExams': upcomingExams.toJson(valueToJson: (v) => v.toJson()),
      'progress': progress.toJson(),
      'semesterGpa': semesterGpa,
      'cumulativeGpa': cumulativeGpa,
      'creditsEarned': creditsEarned,
      'creditsRequired': creditsRequired,
      'syncedAt': syncedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AcademicOverviewImpl extends AcademicOverview {
  _AcademicOverviewImpl({
    required _i2.SemesterSummary currentSemester,
    required List<_i2.SemesterSummary> availableSemesters,
    required List<_i3.CourseSummary> courses,
    required List<_i4.TimetableEntry> today,
    required List<_i5.ExamSummary> upcomingExams,
    required _i6.CurriculumProgress progress,
    required double semesterGpa,
    required double cumulativeGpa,
    required int creditsEarned,
    required int creditsRequired,
    required DateTime syncedAt,
  }) : super._(
         currentSemester: currentSemester,
         availableSemesters: availableSemesters,
         courses: courses,
         today: today,
         upcomingExams: upcomingExams,
         progress: progress,
         semesterGpa: semesterGpa,
         cumulativeGpa: cumulativeGpa,
         creditsEarned: creditsEarned,
         creditsRequired: creditsRequired,
         syncedAt: syncedAt,
       );

  /// Returns a shallow copy of this [AcademicOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AcademicOverview copyWith({
    _i2.SemesterSummary? currentSemester,
    List<_i2.SemesterSummary>? availableSemesters,
    List<_i3.CourseSummary>? courses,
    List<_i4.TimetableEntry>? today,
    List<_i5.ExamSummary>? upcomingExams,
    _i6.CurriculumProgress? progress,
    double? semesterGpa,
    double? cumulativeGpa,
    int? creditsEarned,
    int? creditsRequired,
    DateTime? syncedAt,
  }) {
    return AcademicOverview(
      currentSemester: currentSemester ?? this.currentSemester.copyWith(),
      availableSemesters:
          availableSemesters ??
          this.availableSemesters.map((e0) => e0.copyWith()).toList(),
      courses: courses ?? this.courses.map((e0) => e0.copyWith()).toList(),
      today: today ?? this.today.map((e0) => e0.copyWith()).toList(),
      upcomingExams:
          upcomingExams ??
          this.upcomingExams.map((e0) => e0.copyWith()).toList(),
      progress: progress ?? this.progress.copyWith(),
      semesterGpa: semesterGpa ?? this.semesterGpa,
      cumulativeGpa: cumulativeGpa ?? this.cumulativeGpa,
      creditsEarned: creditsEarned ?? this.creditsEarned,
      creditsRequired: creditsRequired ?? this.creditsRequired,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }
}
