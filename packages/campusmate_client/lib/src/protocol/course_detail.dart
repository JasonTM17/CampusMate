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
import 'course_summary.dart' as _i2;
import 'timetable_entry.dart' as _i3;
import 'grade_component_score.dart' as _i4;
import 'package:campusmate_client/src/protocol/protocol.dart' as _i5;

abstract class CourseDetail implements _i1.SerializableModel {
  CourseDetail._({
    required this.summary,
    required this.description,
    required this.faculty,
    required this.department,
    required this.schedules,
    required this.grades,
    required this.documentsPlaceholder,
    required this.relatedBooksPlaceholder,
    required this.askAiPlaceholder,
  });

  factory CourseDetail({
    required _i2.CourseSummary summary,
    required String description,
    required String faculty,
    required String department,
    required List<_i3.TimetableEntry> schedules,
    required List<_i4.GradeComponentScore> grades,
    required String documentsPlaceholder,
    required String relatedBooksPlaceholder,
    required String askAiPlaceholder,
  }) = _CourseDetailImpl;

  factory CourseDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseDetail(
      summary: _i5.Protocol().deserialize<_i2.CourseSummary>(
        jsonSerialization['summary'],
      ),
      description: jsonSerialization['description'] as String,
      faculty: jsonSerialization['faculty'] as String,
      department: jsonSerialization['department'] as String,
      schedules: _i5.Protocol().deserialize<List<_i3.TimetableEntry>>(
        jsonSerialization['schedules'],
      ),
      grades: _i5.Protocol().deserialize<List<_i4.GradeComponentScore>>(
        jsonSerialization['grades'],
      ),
      documentsPlaceholder: jsonSerialization['documentsPlaceholder'] as String,
      relatedBooksPlaceholder:
          jsonSerialization['relatedBooksPlaceholder'] as String,
      askAiPlaceholder: jsonSerialization['askAiPlaceholder'] as String,
    );
  }

  _i2.CourseSummary summary;

  String description;

  String faculty;

  String department;

  List<_i3.TimetableEntry> schedules;

  List<_i4.GradeComponentScore> grades;

  String documentsPlaceholder;

  String relatedBooksPlaceholder;

  String askAiPlaceholder;

  /// Returns a shallow copy of this [CourseDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseDetail copyWith({
    _i2.CourseSummary? summary,
    String? description,
    String? faculty,
    String? department,
    List<_i3.TimetableEntry>? schedules,
    List<_i4.GradeComponentScore>? grades,
    String? documentsPlaceholder,
    String? relatedBooksPlaceholder,
    String? askAiPlaceholder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseDetail',
      'summary': summary.toJson(),
      'description': description,
      'faculty': faculty,
      'department': department,
      'schedules': schedules.toJson(valueToJson: (v) => v.toJson()),
      'grades': grades.toJson(valueToJson: (v) => v.toJson()),
      'documentsPlaceholder': documentsPlaceholder,
      'relatedBooksPlaceholder': relatedBooksPlaceholder,
      'askAiPlaceholder': askAiPlaceholder,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CourseDetailImpl extends CourseDetail {
  _CourseDetailImpl({
    required _i2.CourseSummary summary,
    required String description,
    required String faculty,
    required String department,
    required List<_i3.TimetableEntry> schedules,
    required List<_i4.GradeComponentScore> grades,
    required String documentsPlaceholder,
    required String relatedBooksPlaceholder,
    required String askAiPlaceholder,
  }) : super._(
         summary: summary,
         description: description,
         faculty: faculty,
         department: department,
         schedules: schedules,
         grades: grades,
         documentsPlaceholder: documentsPlaceholder,
         relatedBooksPlaceholder: relatedBooksPlaceholder,
         askAiPlaceholder: askAiPlaceholder,
       );

  /// Returns a shallow copy of this [CourseDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseDetail copyWith({
    _i2.CourseSummary? summary,
    String? description,
    String? faculty,
    String? department,
    List<_i3.TimetableEntry>? schedules,
    List<_i4.GradeComponentScore>? grades,
    String? documentsPlaceholder,
    String? relatedBooksPlaceholder,
    String? askAiPlaceholder,
  }) {
    return CourseDetail(
      summary: summary ?? this.summary.copyWith(),
      description: description ?? this.description,
      faculty: faculty ?? this.faculty,
      department: department ?? this.department,
      schedules:
          schedules ?? this.schedules.map((e0) => e0.copyWith()).toList(),
      grades: grades ?? this.grades.map((e0) => e0.copyWith()).toList(),
      documentsPlaceholder: documentsPlaceholder ?? this.documentsPlaceholder,
      relatedBooksPlaceholder:
          relatedBooksPlaceholder ?? this.relatedBooksPlaceholder,
      askAiPlaceholder: askAiPlaceholder ?? this.askAiPlaceholder,
    );
  }
}
