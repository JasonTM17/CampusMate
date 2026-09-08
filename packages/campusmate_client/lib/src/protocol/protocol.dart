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
import 'book_access_decision.dart' as _i9;
import 'book_access_type.dart' as _i10;
import 'book_detail.dart' as _i11;
import 'book_favorite_status.dart' as _i12;
import 'book_summary.dart' as _i13;
import 'campus_notification.dart' as _i14;
import 'campus_notification_summary.dart' as _i15;
import 'course.dart' as _i16;
import 'course_detail.dart' as _i17;
import 'course_offering.dart' as _i18;
import 'course_schedule.dart' as _i19;
import 'course_summary.dart' as _i20;
import 'curriculum_block_progress.dart' as _i21;
import 'curriculum_progress.dart' as _i22;
import 'dashboard_academic_summary.dart' as _i23;
import 'dashboard_greeting.dart' as _i24;
import 'enrollment.dart' as _i25;
import 'exam_schedule.dart' as _i26;
import 'exam_summary.dart' as _i27;
import 'favorite_book.dart' as _i28;
import 'grade_component.dart' as _i29;
import 'grade_component_score.dart' as _i30;
import 'grade_summary.dart' as _i31;
import 'greetings/greeting.dart' as _i32;
import 'library_author.dart' as _i33;
import 'library_book.dart' as _i34;
import 'library_book_author.dart' as _i35;
import 'library_book_category.dart' as _i36;
import 'library_book_course.dart' as _i37;
import 'library_book_file.dart' as _i38;
import 'library_category.dart' as _i39;
import 'library_explore.dart' as _i40;
import 'library_explore_section.dart' as _i41;
import 'library_filter_options.dart' as _i42;
import 'library_search_page.dart' as _i43;
import 'notification_list_page.dart' as _i44;
import 'semester.dart' as _i45;
import 'semester_summary.dart' as _i46;
import 'student_grade.dart' as _i47;
import 'student_profile.dart' as _i48;
import 'timetable_entry.dart' as _i49;
import 'vector_capability_probe.dart' as _i50;
import 'package:campusmate_client/src/protocol/course_summary.dart' as _i51;
import 'package:campusmate_client/src/protocol/timetable_entry.dart' as _i52;
import 'package:campusmate_client/src/protocol/exam_summary.dart' as _i53;
import 'package:campusmate_client/src/protocol/announcement_summary.dart'
    as _i54;
import 'package:campusmate_client/src/protocol/ai_conversations.dart' as _i55;
import 'package:campusmate_client/src/protocol/ai_messages.dart' as _i56;
import 'package:campusmate_client/src/protocol/book_access_type.dart' as _i57;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i58;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i59;
export 'academic_overview.dart';
export 'academic_year.dart';
export 'ai_conversations.dart';
export 'ai_messages.dart';
export 'ai_usage.dart';
export 'announcement.dart';
export 'announcement_summary.dart';
export 'book_access_decision.dart';
export 'book_access_type.dart';
export 'book_detail.dart';
export 'book_favorite_status.dart';
export 'book_summary.dart';
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
export 'favorite_book.dart';
export 'grade_component.dart';
export 'grade_component_score.dart';
export 'grade_summary.dart';
export 'greetings/greeting.dart';
export 'library_author.dart';
export 'library_book.dart';
export 'library_book_author.dart';
export 'library_book_category.dart';
export 'library_book_course.dart';
export 'library_book_file.dart';
export 'library_category.dart';
export 'library_explore.dart';
export 'library_explore_section.dart';
export 'library_filter_options.dart';
export 'library_search_page.dart';
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
    if (t == _i9.BookAccessDecision) {
      return _i9.BookAccessDecision.fromJson(data) as T;
    }
    if (t == _i10.BookAccessType) {
      return _i10.BookAccessType.fromJson(data) as T;
    }
    if (t == _i11.BookDetail) {
      return _i11.BookDetail.fromJson(data) as T;
    }
    if (t == _i12.BookFavoriteStatus) {
      return _i12.BookFavoriteStatus.fromJson(data) as T;
    }
    if (t == _i13.BookSummary) {
      return _i13.BookSummary.fromJson(data) as T;
    }
    if (t == _i14.CampusNotification) {
      return _i14.CampusNotification.fromJson(data) as T;
    }
    if (t == _i15.CampusNotificationSummary) {
      return _i15.CampusNotificationSummary.fromJson(data) as T;
    }
    if (t == _i16.Course) {
      return _i16.Course.fromJson(data) as T;
    }
    if (t == _i17.CourseDetail) {
      return _i17.CourseDetail.fromJson(data) as T;
    }
    if (t == _i18.CourseOffering) {
      return _i18.CourseOffering.fromJson(data) as T;
    }
    if (t == _i19.CourseSchedule) {
      return _i19.CourseSchedule.fromJson(data) as T;
    }
    if (t == _i20.CourseSummary) {
      return _i20.CourseSummary.fromJson(data) as T;
    }
    if (t == _i21.CurriculumBlockProgress) {
      return _i21.CurriculumBlockProgress.fromJson(data) as T;
    }
    if (t == _i22.CurriculumProgress) {
      return _i22.CurriculumProgress.fromJson(data) as T;
    }
    if (t == _i23.DashboardAcademicSummary) {
      return _i23.DashboardAcademicSummary.fromJson(data) as T;
    }
    if (t == _i24.DashboardGreeting) {
      return _i24.DashboardGreeting.fromJson(data) as T;
    }
    if (t == _i25.Enrollment) {
      return _i25.Enrollment.fromJson(data) as T;
    }
    if (t == _i26.ExamSchedule) {
      return _i26.ExamSchedule.fromJson(data) as T;
    }
    if (t == _i27.ExamSummary) {
      return _i27.ExamSummary.fromJson(data) as T;
    }
    if (t == _i28.FavoriteBook) {
      return _i28.FavoriteBook.fromJson(data) as T;
    }
    if (t == _i29.GradeComponent) {
      return _i29.GradeComponent.fromJson(data) as T;
    }
    if (t == _i30.GradeComponentScore) {
      return _i30.GradeComponentScore.fromJson(data) as T;
    }
    if (t == _i31.GradeSummary) {
      return _i31.GradeSummary.fromJson(data) as T;
    }
    if (t == _i32.Greeting) {
      return _i32.Greeting.fromJson(data) as T;
    }
    if (t == _i33.LibraryAuthor) {
      return _i33.LibraryAuthor.fromJson(data) as T;
    }
    if (t == _i34.LibraryBook) {
      return _i34.LibraryBook.fromJson(data) as T;
    }
    if (t == _i35.LibraryBookAuthor) {
      return _i35.LibraryBookAuthor.fromJson(data) as T;
    }
    if (t == _i36.LibraryBookCategory) {
      return _i36.LibraryBookCategory.fromJson(data) as T;
    }
    if (t == _i37.LibraryBookCourse) {
      return _i37.LibraryBookCourse.fromJson(data) as T;
    }
    if (t == _i38.LibraryBookFile) {
      return _i38.LibraryBookFile.fromJson(data) as T;
    }
    if (t == _i39.LibraryCategory) {
      return _i39.LibraryCategory.fromJson(data) as T;
    }
    if (t == _i40.LibraryExplore) {
      return _i40.LibraryExplore.fromJson(data) as T;
    }
    if (t == _i41.LibraryExploreSection) {
      return _i41.LibraryExploreSection.fromJson(data) as T;
    }
    if (t == _i42.LibraryFilterOptions) {
      return _i42.LibraryFilterOptions.fromJson(data) as T;
    }
    if (t == _i43.LibrarySearchPage) {
      return _i43.LibrarySearchPage.fromJson(data) as T;
    }
    if (t == _i44.NotificationListPage) {
      return _i44.NotificationListPage.fromJson(data) as T;
    }
    if (t == _i45.Semester) {
      return _i45.Semester.fromJson(data) as T;
    }
    if (t == _i46.SemesterSummary) {
      return _i46.SemesterSummary.fromJson(data) as T;
    }
    if (t == _i47.StudentGrade) {
      return _i47.StudentGrade.fromJson(data) as T;
    }
    if (t == _i48.StudentProfile) {
      return _i48.StudentProfile.fromJson(data) as T;
    }
    if (t == _i49.TimetableEntry) {
      return _i49.TimetableEntry.fromJson(data) as T;
    }
    if (t == _i50.VectorCapabilityProbe) {
      return _i50.VectorCapabilityProbe.fromJson(data) as T;
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
    if (t == _i1.getType<_i9.BookAccessDecision?>()) {
      return (data != null ? _i9.BookAccessDecision.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.BookAccessType?>()) {
      return (data != null ? _i10.BookAccessType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.BookDetail?>()) {
      return (data != null ? _i11.BookDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.BookFavoriteStatus?>()) {
      return (data != null ? _i12.BookFavoriteStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.BookSummary?>()) {
      return (data != null ? _i13.BookSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CampusNotification?>()) {
      return (data != null ? _i14.CampusNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.CampusNotificationSummary?>()) {
      return (data != null
              ? _i15.CampusNotificationSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i16.Course?>()) {
      return (data != null ? _i16.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.CourseDetail?>()) {
      return (data != null ? _i17.CourseDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CourseOffering?>()) {
      return (data != null ? _i18.CourseOffering.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.CourseSchedule?>()) {
      return (data != null ? _i19.CourseSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.CourseSummary?>()) {
      return (data != null ? _i20.CourseSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.CurriculumBlockProgress?>()) {
      return (data != null ? _i21.CurriculumBlockProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.CurriculumProgress?>()) {
      return (data != null ? _i22.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.DashboardAcademicSummary?>()) {
      return (data != null
              ? _i23.DashboardAcademicSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i24.DashboardGreeting?>()) {
      return (data != null ? _i24.DashboardGreeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Enrollment?>()) {
      return (data != null ? _i25.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.ExamSchedule?>()) {
      return (data != null ? _i26.ExamSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.ExamSummary?>()) {
      return (data != null ? _i27.ExamSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.FavoriteBook?>()) {
      return (data != null ? _i28.FavoriteBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.GradeComponent?>()) {
      return (data != null ? _i29.GradeComponent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.GradeComponentScore?>()) {
      return (data != null ? _i30.GradeComponentScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.GradeSummary?>()) {
      return (data != null ? _i31.GradeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.Greeting?>()) {
      return (data != null ? _i32.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.LibraryAuthor?>()) {
      return (data != null ? _i33.LibraryAuthor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.LibraryBook?>()) {
      return (data != null ? _i34.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.LibraryBookAuthor?>()) {
      return (data != null ? _i35.LibraryBookAuthor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.LibraryBookCategory?>()) {
      return (data != null ? _i36.LibraryBookCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.LibraryBookCourse?>()) {
      return (data != null ? _i37.LibraryBookCourse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.LibraryBookFile?>()) {
      return (data != null ? _i38.LibraryBookFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.LibraryCategory?>()) {
      return (data != null ? _i39.LibraryCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.LibraryExplore?>()) {
      return (data != null ? _i40.LibraryExplore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.LibraryExploreSection?>()) {
      return (data != null ? _i41.LibraryExploreSection.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.LibraryFilterOptions?>()) {
      return (data != null ? _i42.LibraryFilterOptions.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.LibrarySearchPage?>()) {
      return (data != null ? _i43.LibrarySearchPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.NotificationListPage?>()) {
      return (data != null ? _i44.NotificationListPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.Semester?>()) {
      return (data != null ? _i45.Semester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SemesterSummary?>()) {
      return (data != null ? _i46.SemesterSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.StudentGrade?>()) {
      return (data != null ? _i47.StudentGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.StudentProfile?>()) {
      return (data != null ? _i48.StudentProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.TimetableEntry?>()) {
      return (data != null ? _i49.TimetableEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.VectorCapabilityProbe?>()) {
      return (data != null ? _i50.VectorCapabilityProbe.fromJson(data) : null)
          as T;
    }
    if (t == List<_i46.SemesterSummary>) {
      return (data as List)
              .map((e) => deserialize<_i46.SemesterSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i20.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i49.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i49.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i27.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i30.GradeComponentScore>) {
      return (data as List)
              .map((e) => deserialize<_i30.GradeComponentScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.CurriculumBlockProgress>) {
      return (data as List)
              .map((e) => deserialize<_i21.CurriculumBlockProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.LibraryExploreSection>) {
      return (data as List)
              .map((e) => deserialize<_i41.LibraryExploreSection>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.BookSummary>) {
      return (data as List)
              .map((e) => deserialize<_i13.BookSummary>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i10.BookAccessType>) {
      return (data as List)
              .map((e) => deserialize<_i10.BookAccessType>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.CampusNotificationSummary>) {
      return (data as List)
              .map((e) => deserialize<_i15.CampusNotificationSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i51.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i52.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i53.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.AnnouncementSummary>) {
      return (data as List)
              .map((e) => deserialize<_i54.AnnouncementSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i55.AiConversation>) {
      return (data as List)
              .map((e) => deserialize<_i55.AiConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i56.AiMessage>) {
      return (data as List).map((e) => deserialize<_i56.AiMessage>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i57.BookAccessType>) {
      return (data as List)
              .map((e) => deserialize<_i57.BookAccessType>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i57.BookAccessType>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i57.BookAccessType>(e))
                    .toList()
              : null)
          as T;
    }
    try {
      return _i58.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i59.Protocol().deserialize<T>(data, t);
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
      _i9.BookAccessDecision => 'BookAccessDecision',
      _i10.BookAccessType => 'BookAccessType',
      _i11.BookDetail => 'BookDetail',
      _i12.BookFavoriteStatus => 'BookFavoriteStatus',
      _i13.BookSummary => 'BookSummary',
      _i14.CampusNotification => 'CampusNotification',
      _i15.CampusNotificationSummary => 'CampusNotificationSummary',
      _i16.Course => 'Course',
      _i17.CourseDetail => 'CourseDetail',
      _i18.CourseOffering => 'CourseOffering',
      _i19.CourseSchedule => 'CourseSchedule',
      _i20.CourseSummary => 'CourseSummary',
      _i21.CurriculumBlockProgress => 'CurriculumBlockProgress',
      _i22.CurriculumProgress => 'CurriculumProgress',
      _i23.DashboardAcademicSummary => 'DashboardAcademicSummary',
      _i24.DashboardGreeting => 'DashboardGreeting',
      _i25.Enrollment => 'Enrollment',
      _i26.ExamSchedule => 'ExamSchedule',
      _i27.ExamSummary => 'ExamSummary',
      _i28.FavoriteBook => 'FavoriteBook',
      _i29.GradeComponent => 'GradeComponent',
      _i30.GradeComponentScore => 'GradeComponentScore',
      _i31.GradeSummary => 'GradeSummary',
      _i32.Greeting => 'Greeting',
      _i33.LibraryAuthor => 'LibraryAuthor',
      _i34.LibraryBook => 'LibraryBook',
      _i35.LibraryBookAuthor => 'LibraryBookAuthor',
      _i36.LibraryBookCategory => 'LibraryBookCategory',
      _i37.LibraryBookCourse => 'LibraryBookCourse',
      _i38.LibraryBookFile => 'LibraryBookFile',
      _i39.LibraryCategory => 'LibraryCategory',
      _i40.LibraryExplore => 'LibraryExplore',
      _i41.LibraryExploreSection => 'LibraryExploreSection',
      _i42.LibraryFilterOptions => 'LibraryFilterOptions',
      _i43.LibrarySearchPage => 'LibrarySearchPage',
      _i44.NotificationListPage => 'NotificationListPage',
      _i45.Semester => 'Semester',
      _i46.SemesterSummary => 'SemesterSummary',
      _i47.StudentGrade => 'StudentGrade',
      _i48.StudentProfile => 'StudentProfile',
      _i49.TimetableEntry => 'TimetableEntry',
      _i50.VectorCapabilityProbe => 'VectorCapabilityProbe',
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
      case _i9.BookAccessDecision():
        return 'BookAccessDecision';
      case _i10.BookAccessType():
        return 'BookAccessType';
      case _i11.BookDetail():
        return 'BookDetail';
      case _i12.BookFavoriteStatus():
        return 'BookFavoriteStatus';
      case _i13.BookSummary():
        return 'BookSummary';
      case _i14.CampusNotification():
        return 'CampusNotification';
      case _i15.CampusNotificationSummary():
        return 'CampusNotificationSummary';
      case _i16.Course():
        return 'Course';
      case _i17.CourseDetail():
        return 'CourseDetail';
      case _i18.CourseOffering():
        return 'CourseOffering';
      case _i19.CourseSchedule():
        return 'CourseSchedule';
      case _i20.CourseSummary():
        return 'CourseSummary';
      case _i21.CurriculumBlockProgress():
        return 'CurriculumBlockProgress';
      case _i22.CurriculumProgress():
        return 'CurriculumProgress';
      case _i23.DashboardAcademicSummary():
        return 'DashboardAcademicSummary';
      case _i24.DashboardGreeting():
        return 'DashboardGreeting';
      case _i25.Enrollment():
        return 'Enrollment';
      case _i26.ExamSchedule():
        return 'ExamSchedule';
      case _i27.ExamSummary():
        return 'ExamSummary';
      case _i28.FavoriteBook():
        return 'FavoriteBook';
      case _i29.GradeComponent():
        return 'GradeComponent';
      case _i30.GradeComponentScore():
        return 'GradeComponentScore';
      case _i31.GradeSummary():
        return 'GradeSummary';
      case _i32.Greeting():
        return 'Greeting';
      case _i33.LibraryAuthor():
        return 'LibraryAuthor';
      case _i34.LibraryBook():
        return 'LibraryBook';
      case _i35.LibraryBookAuthor():
        return 'LibraryBookAuthor';
      case _i36.LibraryBookCategory():
        return 'LibraryBookCategory';
      case _i37.LibraryBookCourse():
        return 'LibraryBookCourse';
      case _i38.LibraryBookFile():
        return 'LibraryBookFile';
      case _i39.LibraryCategory():
        return 'LibraryCategory';
      case _i40.LibraryExplore():
        return 'LibraryExplore';
      case _i41.LibraryExploreSection():
        return 'LibraryExploreSection';
      case _i42.LibraryFilterOptions():
        return 'LibraryFilterOptions';
      case _i43.LibrarySearchPage():
        return 'LibrarySearchPage';
      case _i44.NotificationListPage():
        return 'NotificationListPage';
      case _i45.Semester():
        return 'Semester';
      case _i46.SemesterSummary():
        return 'SemesterSummary';
      case _i47.StudentGrade():
        return 'StudentGrade';
      case _i48.StudentProfile():
        return 'StudentProfile';
      case _i49.TimetableEntry():
        return 'TimetableEntry';
      case _i50.VectorCapabilityProbe():
        return 'VectorCapabilityProbe';
    }
    className = _i58.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i59.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'BookAccessDecision') {
      return deserialize<_i9.BookAccessDecision>(data['data']);
    }
    if (dataClassName == 'BookAccessType') {
      return deserialize<_i10.BookAccessType>(data['data']);
    }
    if (dataClassName == 'BookDetail') {
      return deserialize<_i11.BookDetail>(data['data']);
    }
    if (dataClassName == 'BookFavoriteStatus') {
      return deserialize<_i12.BookFavoriteStatus>(data['data']);
    }
    if (dataClassName == 'BookSummary') {
      return deserialize<_i13.BookSummary>(data['data']);
    }
    if (dataClassName == 'CampusNotification') {
      return deserialize<_i14.CampusNotification>(data['data']);
    }
    if (dataClassName == 'CampusNotificationSummary') {
      return deserialize<_i15.CampusNotificationSummary>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i16.Course>(data['data']);
    }
    if (dataClassName == 'CourseDetail') {
      return deserialize<_i17.CourseDetail>(data['data']);
    }
    if (dataClassName == 'CourseOffering') {
      return deserialize<_i18.CourseOffering>(data['data']);
    }
    if (dataClassName == 'CourseSchedule') {
      return deserialize<_i19.CourseSchedule>(data['data']);
    }
    if (dataClassName == 'CourseSummary') {
      return deserialize<_i20.CourseSummary>(data['data']);
    }
    if (dataClassName == 'CurriculumBlockProgress') {
      return deserialize<_i21.CurriculumBlockProgress>(data['data']);
    }
    if (dataClassName == 'CurriculumProgress') {
      return deserialize<_i22.CurriculumProgress>(data['data']);
    }
    if (dataClassName == 'DashboardAcademicSummary') {
      return deserialize<_i23.DashboardAcademicSummary>(data['data']);
    }
    if (dataClassName == 'DashboardGreeting') {
      return deserialize<_i24.DashboardGreeting>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i25.Enrollment>(data['data']);
    }
    if (dataClassName == 'ExamSchedule') {
      return deserialize<_i26.ExamSchedule>(data['data']);
    }
    if (dataClassName == 'ExamSummary') {
      return deserialize<_i27.ExamSummary>(data['data']);
    }
    if (dataClassName == 'FavoriteBook') {
      return deserialize<_i28.FavoriteBook>(data['data']);
    }
    if (dataClassName == 'GradeComponent') {
      return deserialize<_i29.GradeComponent>(data['data']);
    }
    if (dataClassName == 'GradeComponentScore') {
      return deserialize<_i30.GradeComponentScore>(data['data']);
    }
    if (dataClassName == 'GradeSummary') {
      return deserialize<_i31.GradeSummary>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i32.Greeting>(data['data']);
    }
    if (dataClassName == 'LibraryAuthor') {
      return deserialize<_i33.LibraryAuthor>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i34.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookAuthor') {
      return deserialize<_i35.LibraryBookAuthor>(data['data']);
    }
    if (dataClassName == 'LibraryBookCategory') {
      return deserialize<_i36.LibraryBookCategory>(data['data']);
    }
    if (dataClassName == 'LibraryBookCourse') {
      return deserialize<_i37.LibraryBookCourse>(data['data']);
    }
    if (dataClassName == 'LibraryBookFile') {
      return deserialize<_i38.LibraryBookFile>(data['data']);
    }
    if (dataClassName == 'LibraryCategory') {
      return deserialize<_i39.LibraryCategory>(data['data']);
    }
    if (dataClassName == 'LibraryExplore') {
      return deserialize<_i40.LibraryExplore>(data['data']);
    }
    if (dataClassName == 'LibraryExploreSection') {
      return deserialize<_i41.LibraryExploreSection>(data['data']);
    }
    if (dataClassName == 'LibraryFilterOptions') {
      return deserialize<_i42.LibraryFilterOptions>(data['data']);
    }
    if (dataClassName == 'LibrarySearchPage') {
      return deserialize<_i43.LibrarySearchPage>(data['data']);
    }
    if (dataClassName == 'NotificationListPage') {
      return deserialize<_i44.NotificationListPage>(data['data']);
    }
    if (dataClassName == 'Semester') {
      return deserialize<_i45.Semester>(data['data']);
    }
    if (dataClassName == 'SemesterSummary') {
      return deserialize<_i46.SemesterSummary>(data['data']);
    }
    if (dataClassName == 'StudentGrade') {
      return deserialize<_i47.StudentGrade>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_i48.StudentProfile>(data['data']);
    }
    if (dataClassName == 'TimetableEntry') {
      return deserialize<_i49.TimetableEntry>(data['data']);
    }
    if (dataClassName == 'VectorCapabilityProbe') {
      return deserialize<_i50.VectorCapabilityProbe>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i58.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i59.Protocol().deserializeByClassName(data);
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
      return _i58.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i59.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
