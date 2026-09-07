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
import 'academic_overview.dart' as _i2;
import 'academic_year.dart' as _i3;
import 'ai_conversations.dart' as _i4;
import 'ai_messages.dart' as _i5;
import 'ai_usage.dart' as _i6;
import 'course.dart' as _i7;
import 'course_detail.dart' as _i8;
import 'course_offering.dart' as _i9;
import 'course_schedule.dart' as _i10;
import 'course_summary.dart' as _i11;
import 'curriculum_block_progress.dart' as _i12;
import 'curriculum_progress.dart' as _i13;
import 'enrollment.dart' as _i14;
import 'exam_schedule.dart' as _i15;
import 'exam_summary.dart' as _i16;
import 'grade_component.dart' as _i17;
import 'grade_component_score.dart' as _i18;
import 'grade_summary.dart' as _i19;
import 'greetings/greeting.dart' as _i20;
import 'semester.dart' as _i21;
import 'semester_summary.dart' as _i22;
import 'student_grade.dart' as _i23;
import 'student_profile.dart' as _i24;
import 'timetable_entry.dart' as _i25;
import 'vector_capability_probe.dart' as _i26;
import 'package:campusmate_client/src/protocol/course_summary.dart' as _i27;
import 'package:campusmate_client/src/protocol/timetable_entry.dart' as _i28;
import 'package:campusmate_client/src/protocol/exam_summary.dart' as _i29;
import 'package:campusmate_client/src/protocol/ai_conversations.dart' as _i30;
import 'package:campusmate_client/src/protocol/ai_messages.dart' as _i31;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i32;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i33;
export 'academic_overview.dart';
export 'academic_year.dart';
export 'ai_conversations.dart';
export 'ai_messages.dart';
export 'ai_usage.dart';
export 'course.dart';
export 'course_detail.dart';
export 'course_offering.dart';
export 'course_schedule.dart';
export 'course_summary.dart';
export 'curriculum_block_progress.dart';
export 'curriculum_progress.dart';
export 'enrollment.dart';
export 'exam_schedule.dart';
export 'exam_summary.dart';
export 'grade_component.dart';
export 'grade_component_score.dart';
export 'grade_summary.dart';
export 'greetings/greeting.dart';
export 'semester.dart';
export 'semester_summary.dart';
export 'student_grade.dart';
export 'student_profile.dart';
export 'timetable_entry.dart';
export 'vector_capability_probe.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AcademicOverview) {
      return _i2.AcademicOverview.fromJson(data) as T;
    }
    if (t == _i3.AcademicYear) {
      return _i3.AcademicYear.fromJson(data) as T;
    }
    if (t == _i4.AiConversation) {
      return _i4.AiConversation.fromJson(data) as T;
    }
    if (t == _i5.AiMessage) {
      return _i5.AiMessage.fromJson(data) as T;
    }
    if (t == _i6.AiUsage) {
      return _i6.AiUsage.fromJson(data) as T;
    }
    if (t == _i7.Course) {
      return _i7.Course.fromJson(data) as T;
    }
    if (t == _i8.CourseDetail) {
      return _i8.CourseDetail.fromJson(data) as T;
    }
    if (t == _i9.CourseOffering) {
      return _i9.CourseOffering.fromJson(data) as T;
    }
    if (t == _i10.CourseSchedule) {
      return _i10.CourseSchedule.fromJson(data) as T;
    }
    if (t == _i11.CourseSummary) {
      return _i11.CourseSummary.fromJson(data) as T;
    }
    if (t == _i12.CurriculumBlockProgress) {
      return _i12.CurriculumBlockProgress.fromJson(data) as T;
    }
    if (t == _i13.CurriculumProgress) {
      return _i13.CurriculumProgress.fromJson(data) as T;
    }
    if (t == _i14.Enrollment) {
      return _i14.Enrollment.fromJson(data) as T;
    }
    if (t == _i15.ExamSchedule) {
      return _i15.ExamSchedule.fromJson(data) as T;
    }
    if (t == _i16.ExamSummary) {
      return _i16.ExamSummary.fromJson(data) as T;
    }
    if (t == _i17.GradeComponent) {
      return _i17.GradeComponent.fromJson(data) as T;
    }
    if (t == _i18.GradeComponentScore) {
      return _i18.GradeComponentScore.fromJson(data) as T;
    }
    if (t == _i19.GradeSummary) {
      return _i19.GradeSummary.fromJson(data) as T;
    }
    if (t == _i20.Greeting) {
      return _i20.Greeting.fromJson(data) as T;
    }
    if (t == _i21.Semester) {
      return _i21.Semester.fromJson(data) as T;
    }
    if (t == _i22.SemesterSummary) {
      return _i22.SemesterSummary.fromJson(data) as T;
    }
    if (t == _i23.StudentGrade) {
      return _i23.StudentGrade.fromJson(data) as T;
    }
    if (t == _i24.StudentProfile) {
      return _i24.StudentProfile.fromJson(data) as T;
    }
    if (t == _i25.TimetableEntry) {
      return _i25.TimetableEntry.fromJson(data) as T;
    }
    if (t == _i26.VectorCapabilityProbe) {
      return _i26.VectorCapabilityProbe.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AcademicOverview?>()) {
      return (data != null ? _i2.AcademicOverview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AcademicYear?>()) {
      return (data != null ? _i3.AcademicYear.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AiConversation?>()) {
      return (data != null ? _i4.AiConversation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AiMessage?>()) {
      return (data != null ? _i5.AiMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AiUsage?>()) {
      return (data != null ? _i6.AiUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Course?>()) {
      return (data != null ? _i7.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CourseDetail?>()) {
      return (data != null ? _i8.CourseDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CourseOffering?>()) {
      return (data != null ? _i9.CourseOffering.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CourseSchedule?>()) {
      return (data != null ? _i10.CourseSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CourseSummary?>()) {
      return (data != null ? _i11.CourseSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CurriculumBlockProgress?>()) {
      return (data != null ? _i12.CurriculumBlockProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.CurriculumProgress?>()) {
      return (data != null ? _i13.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.Enrollment?>()) {
      return (data != null ? _i14.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.ExamSchedule?>()) {
      return (data != null ? _i15.ExamSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ExamSummary?>()) {
      return (data != null ? _i16.ExamSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.GradeComponent?>()) {
      return (data != null ? _i17.GradeComponent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.GradeComponentScore?>()) {
      return (data != null ? _i18.GradeComponentScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.GradeSummary?>()) {
      return (data != null ? _i19.GradeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Greeting?>()) {
      return (data != null ? _i20.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Semester?>()) {
      return (data != null ? _i21.Semester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.SemesterSummary?>()) {
      return (data != null ? _i22.SemesterSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.StudentGrade?>()) {
      return (data != null ? _i23.StudentGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.StudentProfile?>()) {
      return (data != null ? _i24.StudentProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.TimetableEntry?>()) {
      return (data != null ? _i25.TimetableEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.VectorCapabilityProbe?>()) {
      return (data != null ? _i26.VectorCapabilityProbe.fromJson(data) : null)
          as T;
    }
    if (t == List<_i22.SemesterSummary>) {
      return (data as List)
              .map((e) => deserialize<_i22.SemesterSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i11.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i25.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i16.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.GradeComponentScore>) {
      return (data as List)
              .map((e) => deserialize<_i18.GradeComponentScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i12.CurriculumBlockProgress>) {
      return (data as List)
              .map((e) => deserialize<_i12.CurriculumBlockProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i27.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i28.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i29.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.AiConversation>) {
      return (data as List)
              .map((e) => deserialize<_i30.AiConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.AiMessage>) {
      return (data as List).map((e) => deserialize<_i31.AiMessage>(e)).toList()
          as T;
    }
    try {
      return _i32.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i33.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AcademicOverview => 'AcademicOverview',
      _i3.AcademicYear => 'AcademicYear',
      _i4.AiConversation => 'AiConversation',
      _i5.AiMessage => 'AiMessage',
      _i6.AiUsage => 'AiUsage',
      _i7.Course => 'Course',
      _i8.CourseDetail => 'CourseDetail',
      _i9.CourseOffering => 'CourseOffering',
      _i10.CourseSchedule => 'CourseSchedule',
      _i11.CourseSummary => 'CourseSummary',
      _i12.CurriculumBlockProgress => 'CurriculumBlockProgress',
      _i13.CurriculumProgress => 'CurriculumProgress',
      _i14.Enrollment => 'Enrollment',
      _i15.ExamSchedule => 'ExamSchedule',
      _i16.ExamSummary => 'ExamSummary',
      _i17.GradeComponent => 'GradeComponent',
      _i18.GradeComponentScore => 'GradeComponentScore',
      _i19.GradeSummary => 'GradeSummary',
      _i20.Greeting => 'Greeting',
      _i21.Semester => 'Semester',
      _i22.SemesterSummary => 'SemesterSummary',
      _i23.StudentGrade => 'StudentGrade',
      _i24.StudentProfile => 'StudentProfile',
      _i25.TimetableEntry => 'TimetableEntry',
      _i26.VectorCapabilityProbe => 'VectorCapabilityProbe',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('campusmate.', '');
    }

    switch (data) {
      case _i2.AcademicOverview():
        return 'AcademicOverview';
      case _i3.AcademicYear():
        return 'AcademicYear';
      case _i4.AiConversation():
        return 'AiConversation';
      case _i5.AiMessage():
        return 'AiMessage';
      case _i6.AiUsage():
        return 'AiUsage';
      case _i7.Course():
        return 'Course';
      case _i8.CourseDetail():
        return 'CourseDetail';
      case _i9.CourseOffering():
        return 'CourseOffering';
      case _i10.CourseSchedule():
        return 'CourseSchedule';
      case _i11.CourseSummary():
        return 'CourseSummary';
      case _i12.CurriculumBlockProgress():
        return 'CurriculumBlockProgress';
      case _i13.CurriculumProgress():
        return 'CurriculumProgress';
      case _i14.Enrollment():
        return 'Enrollment';
      case _i15.ExamSchedule():
        return 'ExamSchedule';
      case _i16.ExamSummary():
        return 'ExamSummary';
      case _i17.GradeComponent():
        return 'GradeComponent';
      case _i18.GradeComponentScore():
        return 'GradeComponentScore';
      case _i19.GradeSummary():
        return 'GradeSummary';
      case _i20.Greeting():
        return 'Greeting';
      case _i21.Semester():
        return 'Semester';
      case _i22.SemesterSummary():
        return 'SemesterSummary';
      case _i23.StudentGrade():
        return 'StudentGrade';
      case _i24.StudentProfile():
        return 'StudentProfile';
      case _i25.TimetableEntry():
        return 'TimetableEntry';
      case _i26.VectorCapabilityProbe():
        return 'VectorCapabilityProbe';
    }
    className = _i32.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i33.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AcademicOverview') {
      return deserialize<_i2.AcademicOverview>(data['data']);
    }
    if (dataClassName == 'AcademicYear') {
      return deserialize<_i3.AcademicYear>(data['data']);
    }
    if (dataClassName == 'AiConversation') {
      return deserialize<_i4.AiConversation>(data['data']);
    }
    if (dataClassName == 'AiMessage') {
      return deserialize<_i5.AiMessage>(data['data']);
    }
    if (dataClassName == 'AiUsage') {
      return deserialize<_i6.AiUsage>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i7.Course>(data['data']);
    }
    if (dataClassName == 'CourseDetail') {
      return deserialize<_i8.CourseDetail>(data['data']);
    }
    if (dataClassName == 'CourseOffering') {
      return deserialize<_i9.CourseOffering>(data['data']);
    }
    if (dataClassName == 'CourseSchedule') {
      return deserialize<_i10.CourseSchedule>(data['data']);
    }
    if (dataClassName == 'CourseSummary') {
      return deserialize<_i11.CourseSummary>(data['data']);
    }
    if (dataClassName == 'CurriculumBlockProgress') {
      return deserialize<_i12.CurriculumBlockProgress>(data['data']);
    }
    if (dataClassName == 'CurriculumProgress') {
      return deserialize<_i13.CurriculumProgress>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i14.Enrollment>(data['data']);
    }
    if (dataClassName == 'ExamSchedule') {
      return deserialize<_i15.ExamSchedule>(data['data']);
    }
    if (dataClassName == 'ExamSummary') {
      return deserialize<_i16.ExamSummary>(data['data']);
    }
    if (dataClassName == 'GradeComponent') {
      return deserialize<_i17.GradeComponent>(data['data']);
    }
    if (dataClassName == 'GradeComponentScore') {
      return deserialize<_i18.GradeComponentScore>(data['data']);
    }
    if (dataClassName == 'GradeSummary') {
      return deserialize<_i19.GradeSummary>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i20.Greeting>(data['data']);
    }
    if (dataClassName == 'Semester') {
      return deserialize<_i21.Semester>(data['data']);
    }
    if (dataClassName == 'SemesterSummary') {
      return deserialize<_i22.SemesterSummary>(data['data']);
    }
    if (dataClassName == 'StudentGrade') {
      return deserialize<_i23.StudentGrade>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_i24.StudentProfile>(data['data']);
    }
    if (dataClassName == 'TimetableEntry') {
      return deserialize<_i25.TimetableEntry>(data['data']);
    }
    if (dataClassName == 'VectorCapabilityProbe') {
      return deserialize<_i26.VectorCapabilityProbe>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i32.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i33.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i32.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i33.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
