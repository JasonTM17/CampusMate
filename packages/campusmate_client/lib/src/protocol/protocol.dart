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
import 'announcement.dart' as _i7;
import 'announcement_summary.dart' as _i8;
import 'campus_notification.dart' as _i9;
import 'campus_notification_summary.dart' as _i10;
import 'course.dart' as _i11;
import 'course_detail.dart' as _i12;
import 'course_offering.dart' as _i13;
import 'course_schedule.dart' as _i14;
import 'course_summary.dart' as _i15;
import 'curriculum_block_progress.dart' as _i16;
import 'curriculum_progress.dart' as _i17;
import 'dashboard_academic_summary.dart' as _i18;
import 'dashboard_greeting.dart' as _i19;
import 'enrollment.dart' as _i20;
import 'exam_schedule.dart' as _i21;
import 'exam_summary.dart' as _i22;
import 'grade_component.dart' as _i23;
import 'grade_component_score.dart' as _i24;
import 'grade_summary.dart' as _i25;
import 'greetings/greeting.dart' as _i26;
import 'notification_list_page.dart' as _i27;
import 'semester.dart' as _i28;
import 'semester_summary.dart' as _i29;
import 'student_grade.dart' as _i30;
import 'student_profile.dart' as _i31;
import 'timetable_entry.dart' as _i32;
import 'vector_capability_probe.dart' as _i33;
import 'package:campusmate_client/src/protocol/course_summary.dart' as _i34;
import 'package:campusmate_client/src/protocol/timetable_entry.dart' as _i35;
import 'package:campusmate_client/src/protocol/exam_summary.dart' as _i36;
import 'package:campusmate_client/src/protocol/announcement_summary.dart'
    as _i37;
import 'package:campusmate_client/src/protocol/ai_conversations.dart' as _i38;
import 'package:campusmate_client/src/protocol/ai_messages.dart' as _i39;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i40;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i41;
export 'academic_overview.dart';
export 'academic_year.dart';
export 'ai_conversations.dart';
export 'ai_messages.dart';
export 'ai_usage.dart';
export 'announcement.dart';
export 'announcement_summary.dart';
export 'campus_notification.dart';
export 'campus_notification_summary.dart';
export 'course.dart';
export 'course_detail.dart';
export 'course_offering.dart';
export 'course_schedule.dart';
export 'course_summary.dart';
export 'curriculum_block_progress.dart';
export 'curriculum_progress.dart';
export 'dashboard_academic_summary.dart';
export 'dashboard_greeting.dart';
export 'enrollment.dart';
export 'exam_schedule.dart';
export 'exam_summary.dart';
export 'grade_component.dart';
export 'grade_component_score.dart';
export 'grade_summary.dart';
export 'greetings/greeting.dart';
export 'notification_list_page.dart';
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
    if (t == _i7.Announcement) {
      return _i7.Announcement.fromJson(data) as T;
    }
    if (t == _i8.AnnouncementSummary) {
      return _i8.AnnouncementSummary.fromJson(data) as T;
    }
    if (t == _i9.CampusNotification) {
      return _i9.CampusNotification.fromJson(data) as T;
    }
    if (t == _i10.CampusNotificationSummary) {
      return _i10.CampusNotificationSummary.fromJson(data) as T;
    }
    if (t == _i11.Course) {
      return _i11.Course.fromJson(data) as T;
    }
    if (t == _i12.CourseDetail) {
      return _i12.CourseDetail.fromJson(data) as T;
    }
    if (t == _i13.CourseOffering) {
      return _i13.CourseOffering.fromJson(data) as T;
    }
    if (t == _i14.CourseSchedule) {
      return _i14.CourseSchedule.fromJson(data) as T;
    }
    if (t == _i15.CourseSummary) {
      return _i15.CourseSummary.fromJson(data) as T;
    }
    if (t == _i16.CurriculumBlockProgress) {
      return _i16.CurriculumBlockProgress.fromJson(data) as T;
    }
    if (t == _i17.CurriculumProgress) {
      return _i17.CurriculumProgress.fromJson(data) as T;
    }
    if (t == _i18.DashboardAcademicSummary) {
      return _i18.DashboardAcademicSummary.fromJson(data) as T;
    }
    if (t == _i19.DashboardGreeting) {
      return _i19.DashboardGreeting.fromJson(data) as T;
    }
    if (t == _i20.Enrollment) {
      return _i20.Enrollment.fromJson(data) as T;
    }
    if (t == _i21.ExamSchedule) {
      return _i21.ExamSchedule.fromJson(data) as T;
    }
    if (t == _i22.ExamSummary) {
      return _i22.ExamSummary.fromJson(data) as T;
    }
    if (t == _i23.GradeComponent) {
      return _i23.GradeComponent.fromJson(data) as T;
    }
    if (t == _i24.GradeComponentScore) {
      return _i24.GradeComponentScore.fromJson(data) as T;
    }
    if (t == _i25.GradeSummary) {
      return _i25.GradeSummary.fromJson(data) as T;
    }
    if (t == _i26.Greeting) {
      return _i26.Greeting.fromJson(data) as T;
    }
    if (t == _i27.NotificationListPage) {
      return _i27.NotificationListPage.fromJson(data) as T;
    }
    if (t == _i28.Semester) {
      return _i28.Semester.fromJson(data) as T;
    }
    if (t == _i29.SemesterSummary) {
      return _i29.SemesterSummary.fromJson(data) as T;
    }
    if (t == _i30.StudentGrade) {
      return _i30.StudentGrade.fromJson(data) as T;
    }
    if (t == _i31.StudentProfile) {
      return _i31.StudentProfile.fromJson(data) as T;
    }
    if (t == _i32.TimetableEntry) {
      return _i32.TimetableEntry.fromJson(data) as T;
    }
    if (t == _i33.VectorCapabilityProbe) {
      return _i33.VectorCapabilityProbe.fromJson(data) as T;
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
    if (t == _i1.getType<_i7.Announcement?>()) {
      return (data != null ? _i7.Announcement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AnnouncementSummary?>()) {
      return (data != null ? _i8.AnnouncementSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.CampusNotification?>()) {
      return (data != null ? _i9.CampusNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CampusNotificationSummary?>()) {
      return (data != null
              ? _i10.CampusNotificationSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.Course?>()) {
      return (data != null ? _i11.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CourseDetail?>()) {
      return (data != null ? _i12.CourseDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CourseOffering?>()) {
      return (data != null ? _i13.CourseOffering.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CourseSchedule?>()) {
      return (data != null ? _i14.CourseSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CourseSummary?>()) {
      return (data != null ? _i15.CourseSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CurriculumBlockProgress?>()) {
      return (data != null ? _i16.CurriculumBlockProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.CurriculumProgress?>()) {
      return (data != null ? _i17.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.DashboardAcademicSummary?>()) {
      return (data != null
              ? _i18.DashboardAcademicSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i19.DashboardGreeting?>()) {
      return (data != null ? _i19.DashboardGreeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Enrollment?>()) {
      return (data != null ? _i20.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.ExamSchedule?>()) {
      return (data != null ? _i21.ExamSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.ExamSummary?>()) {
      return (data != null ? _i22.ExamSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.GradeComponent?>()) {
      return (data != null ? _i23.GradeComponent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.GradeComponentScore?>()) {
      return (data != null ? _i24.GradeComponentScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.GradeSummary?>()) {
      return (data != null ? _i25.GradeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.Greeting?>()) {
      return (data != null ? _i26.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.NotificationListPage?>()) {
      return (data != null ? _i27.NotificationListPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.Semester?>()) {
      return (data != null ? _i28.Semester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SemesterSummary?>()) {
      return (data != null ? _i29.SemesterSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.StudentGrade?>()) {
      return (data != null ? _i30.StudentGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.StudentProfile?>()) {
      return (data != null ? _i31.StudentProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.TimetableEntry?>()) {
      return (data != null ? _i32.TimetableEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.VectorCapabilityProbe?>()) {
      return (data != null ? _i33.VectorCapabilityProbe.fromJson(data) : null)
          as T;
    }
    if (t == List<_i29.SemesterSummary>) {
      return (data as List)
              .map((e) => deserialize<_i29.SemesterSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i15.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i32.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i22.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.GradeComponentScore>) {
      return (data as List)
              .map((e) => deserialize<_i24.GradeComponentScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.CurriculumBlockProgress>) {
      return (data as List)
              .map((e) => deserialize<_i16.CurriculumBlockProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i10.CampusNotificationSummary>) {
      return (data as List)
              .map((e) => deserialize<_i10.CampusNotificationSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i34.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i35.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i35.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i36.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.AnnouncementSummary>) {
      return (data as List)
              .map((e) => deserialize<_i37.AnnouncementSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.AiConversation>) {
      return (data as List)
              .map((e) => deserialize<_i38.AiConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.AiMessage>) {
      return (data as List).map((e) => deserialize<_i39.AiMessage>(e)).toList()
          as T;
    }
    try {
      return _i40.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i41.Protocol().deserialize<T>(data, t);
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
      _i7.Announcement => 'Announcement',
      _i8.AnnouncementSummary => 'AnnouncementSummary',
      _i9.CampusNotification => 'CampusNotification',
      _i10.CampusNotificationSummary => 'CampusNotificationSummary',
      _i11.Course => 'Course',
      _i12.CourseDetail => 'CourseDetail',
      _i13.CourseOffering => 'CourseOffering',
      _i14.CourseSchedule => 'CourseSchedule',
      _i15.CourseSummary => 'CourseSummary',
      _i16.CurriculumBlockProgress => 'CurriculumBlockProgress',
      _i17.CurriculumProgress => 'CurriculumProgress',
      _i18.DashboardAcademicSummary => 'DashboardAcademicSummary',
      _i19.DashboardGreeting => 'DashboardGreeting',
      _i20.Enrollment => 'Enrollment',
      _i21.ExamSchedule => 'ExamSchedule',
      _i22.ExamSummary => 'ExamSummary',
      _i23.GradeComponent => 'GradeComponent',
      _i24.GradeComponentScore => 'GradeComponentScore',
      _i25.GradeSummary => 'GradeSummary',
      _i26.Greeting => 'Greeting',
      _i27.NotificationListPage => 'NotificationListPage',
      _i28.Semester => 'Semester',
      _i29.SemesterSummary => 'SemesterSummary',
      _i30.StudentGrade => 'StudentGrade',
      _i31.StudentProfile => 'StudentProfile',
      _i32.TimetableEntry => 'TimetableEntry',
      _i33.VectorCapabilityProbe => 'VectorCapabilityProbe',
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
      case _i7.Announcement():
        return 'Announcement';
      case _i8.AnnouncementSummary():
        return 'AnnouncementSummary';
      case _i9.CampusNotification():
        return 'CampusNotification';
      case _i10.CampusNotificationSummary():
        return 'CampusNotificationSummary';
      case _i11.Course():
        return 'Course';
      case _i12.CourseDetail():
        return 'CourseDetail';
      case _i13.CourseOffering():
        return 'CourseOffering';
      case _i14.CourseSchedule():
        return 'CourseSchedule';
      case _i15.CourseSummary():
        return 'CourseSummary';
      case _i16.CurriculumBlockProgress():
        return 'CurriculumBlockProgress';
      case _i17.CurriculumProgress():
        return 'CurriculumProgress';
      case _i18.DashboardAcademicSummary():
        return 'DashboardAcademicSummary';
      case _i19.DashboardGreeting():
        return 'DashboardGreeting';
      case _i20.Enrollment():
        return 'Enrollment';
      case _i21.ExamSchedule():
        return 'ExamSchedule';
      case _i22.ExamSummary():
        return 'ExamSummary';
      case _i23.GradeComponent():
        return 'GradeComponent';
      case _i24.GradeComponentScore():
        return 'GradeComponentScore';
      case _i25.GradeSummary():
        return 'GradeSummary';
      case _i26.Greeting():
        return 'Greeting';
      case _i27.NotificationListPage():
        return 'NotificationListPage';
      case _i28.Semester():
        return 'Semester';
      case _i29.SemesterSummary():
        return 'SemesterSummary';
      case _i30.StudentGrade():
        return 'StudentGrade';
      case _i31.StudentProfile():
        return 'StudentProfile';
      case _i32.TimetableEntry():
        return 'TimetableEntry';
      case _i33.VectorCapabilityProbe():
        return 'VectorCapabilityProbe';
    }
    className = _i40.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i41.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Announcement') {
      return deserialize<_i7.Announcement>(data['data']);
    }
    if (dataClassName == 'AnnouncementSummary') {
      return deserialize<_i8.AnnouncementSummary>(data['data']);
    }
    if (dataClassName == 'CampusNotification') {
      return deserialize<_i9.CampusNotification>(data['data']);
    }
    if (dataClassName == 'CampusNotificationSummary') {
      return deserialize<_i10.CampusNotificationSummary>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i11.Course>(data['data']);
    }
    if (dataClassName == 'CourseDetail') {
      return deserialize<_i12.CourseDetail>(data['data']);
    }
    if (dataClassName == 'CourseOffering') {
      return deserialize<_i13.CourseOffering>(data['data']);
    }
    if (dataClassName == 'CourseSchedule') {
      return deserialize<_i14.CourseSchedule>(data['data']);
    }
    if (dataClassName == 'CourseSummary') {
      return deserialize<_i15.CourseSummary>(data['data']);
    }
    if (dataClassName == 'CurriculumBlockProgress') {
      return deserialize<_i16.CurriculumBlockProgress>(data['data']);
    }
    if (dataClassName == 'CurriculumProgress') {
      return deserialize<_i17.CurriculumProgress>(data['data']);
    }
    if (dataClassName == 'DashboardAcademicSummary') {
      return deserialize<_i18.DashboardAcademicSummary>(data['data']);
    }
    if (dataClassName == 'DashboardGreeting') {
      return deserialize<_i19.DashboardGreeting>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i20.Enrollment>(data['data']);
    }
    if (dataClassName == 'ExamSchedule') {
      return deserialize<_i21.ExamSchedule>(data['data']);
    }
    if (dataClassName == 'ExamSummary') {
      return deserialize<_i22.ExamSummary>(data['data']);
    }
    if (dataClassName == 'GradeComponent') {
      return deserialize<_i23.GradeComponent>(data['data']);
    }
    if (dataClassName == 'GradeComponentScore') {
      return deserialize<_i24.GradeComponentScore>(data['data']);
    }
    if (dataClassName == 'GradeSummary') {
      return deserialize<_i25.GradeSummary>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i26.Greeting>(data['data']);
    }
    if (dataClassName == 'NotificationListPage') {
      return deserialize<_i27.NotificationListPage>(data['data']);
    }
    if (dataClassName == 'Semester') {
      return deserialize<_i28.Semester>(data['data']);
    }
    if (dataClassName == 'SemesterSummary') {
      return deserialize<_i29.SemesterSummary>(data['data']);
    }
    if (dataClassName == 'StudentGrade') {
      return deserialize<_i30.StudentGrade>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_i31.StudentProfile>(data['data']);
    }
    if (dataClassName == 'TimetableEntry') {
      return deserialize<_i32.TimetableEntry>(data['data']);
    }
    if (dataClassName == 'VectorCapabilityProbe') {
      return deserialize<_i33.VectorCapabilityProbe>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i40.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i41.Protocol().deserializeByClassName(data);
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
      return _i40.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i41.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
