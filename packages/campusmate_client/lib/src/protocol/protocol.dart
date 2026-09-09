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
import 'ai_user_memory.dart' as _i7;
import 'announcement.dart' as _i8;
import 'announcement_summary.dart' as _i9;
import 'audit_log.dart' as _i10;
import 'book_access_decision.dart' as _i11;
import 'book_access_policy_update.dart' as _i12;
import 'book_access_type.dart' as _i13;
import 'book_copy.dart' as _i14;
import 'book_copy_status.dart' as _i15;
import 'book_detail.dart' as _i16;
import 'book_favorite_status.dart' as _i17;
import 'book_loan.dart' as _i18;
import 'book_loan_page.dart' as _i19;
import 'book_loan_status.dart' as _i20;
import 'book_loan_summary.dart' as _i21;
import 'book_summary.dart' as _i22;
import 'campus_notification.dart' as _i23;
import 'campus_notification_summary.dart' as _i24;
import 'course.dart' as _i25;
import 'course_detail.dart' as _i26;
import 'course_offering.dart' as _i27;
import 'course_schedule.dart' as _i28;
import 'course_summary.dart' as _i29;
import 'curriculum_block_progress.dart' as _i30;
import 'curriculum_progress.dart' as _i31;
import 'dashboard_academic_summary.dart' as _i32;
import 'dashboard_greeting.dart' as _i33;
import 'enrollment.dart' as _i34;
import 'exam_schedule.dart' as _i35;
import 'exam_summary.dart' as _i36;
import 'favorite_book.dart' as _i37;
import 'grade_component.dart' as _i38;
import 'grade_component_score.dart' as _i39;
import 'grade_summary.dart' as _i40;
import 'greetings/greeting.dart' as _i41;
import 'knowledge_chunk.dart' as _i42;
import 'knowledge_document.dart' as _i43;
import 'library_author.dart' as _i44;
import 'library_book.dart' as _i45;
import 'library_book_author.dart' as _i46;
import 'library_book_category.dart' as _i47;
import 'library_book_course.dart' as _i48;
import 'library_book_file.dart' as _i49;
import 'library_category.dart' as _i50;
import 'library_explore.dart' as _i51;
import 'library_explore_section.dart' as _i52;
import 'library_filter_options.dart' as _i53;
import 'library_search_page.dart' as _i54;
import 'notification_list_page.dart' as _i55;
import 'rag_citation.dart' as _i56;
import 'reader_asset.dart' as _i57;
import 'reader_bookmark.dart' as _i58;
import 'reader_highlight.dart' as _i59;
import 'reader_note.dart' as _i60;
import 'reading_progress.dart' as _i61;
import 'reading_progress_sync_result.dart' as _i62;
import 'semester.dart' as _i63;
import 'semester_summary.dart' as _i64;
import 'student_ai_preference.dart' as _i65;
import 'student_grade.dart' as _i66;
import 'student_profile.dart' as _i67;
import 'study_suggestion.dart' as _i68;
import 'timetable_entry.dart' as _i69;
import 'vector_capability_probe.dart' as _i70;
import 'package:campusmate_client/src/protocol/course_summary.dart' as _i71;
import 'package:campusmate_client/src/protocol/timetable_entry.dart' as _i72;
import 'package:campusmate_client/src/protocol/exam_summary.dart' as _i73;
import 'package:campusmate_client/src/protocol/announcement_summary.dart'
    as _i74;
import 'package:campusmate_client/src/protocol/ai_conversations.dart' as _i75;
import 'package:campusmate_client/src/protocol/ai_messages.dart' as _i76;
import 'package:campusmate_client/src/protocol/ai_user_memory.dart' as _i77;
import 'package:campusmate_client/src/protocol/rag_citation.dart' as _i78;
import 'package:campusmate_client/src/protocol/book_loan_summary.dart' as _i79;
import 'package:campusmate_client/src/protocol/book_access_type.dart' as _i80;
import 'package:campusmate_client/src/protocol/reader_bookmark.dart' as _i81;
import 'package:campusmate_client/src/protocol/reader_note.dart' as _i82;
import 'package:campusmate_client/src/protocol/reader_highlight.dart' as _i83;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i84;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i85;
export 'academic_overview.dart';
export 'academic_year.dart';
export 'ai_conversations.dart';
export 'ai_messages.dart';
export 'ai_usage.dart';
export 'ai_user_memory.dart';
export 'announcement.dart';
export 'announcement_summary.dart';
export 'audit_log.dart';
export 'book_access_decision.dart';
export 'book_access_policy_update.dart';
export 'book_access_type.dart';
export 'book_copy.dart';
export 'book_copy_status.dart';
export 'book_detail.dart';
export 'book_favorite_status.dart';
export 'book_loan.dart';
export 'book_loan_page.dart';
export 'book_loan_status.dart';
export 'book_loan_summary.dart';
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
export 'knowledge_chunk.dart';
export 'knowledge_document.dart';
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
export 'rag_citation.dart';
export 'reader_asset.dart';
export 'reader_bookmark.dart';
export 'reader_highlight.dart';
export 'reader_note.dart';
export 'reading_progress.dart';
export 'reading_progress_sync_result.dart';
export 'semester.dart';
export 'semester_summary.dart';
export 'student_ai_preference.dart';
export 'student_grade.dart';
export 'student_profile.dart';
export 'study_suggestion.dart';
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
    if (t == _i7.AiUserMemory) {
      return _i7.AiUserMemory.fromJson(data) as T;
    }
    if (t == _i8.Announcement) {
      return _i8.Announcement.fromJson(data) as T;
    }
    if (t == _i9.AnnouncementSummary) {
      return _i9.AnnouncementSummary.fromJson(data) as T;
    }
    if (t == _i10.AuditLog) {
      return _i10.AuditLog.fromJson(data) as T;
    }
    if (t == _i11.BookAccessDecision) {
      return _i11.BookAccessDecision.fromJson(data) as T;
    }
    if (t == _i12.BookAccessPolicyUpdate) {
      return _i12.BookAccessPolicyUpdate.fromJson(data) as T;
    }
    if (t == _i13.BookAccessType) {
      return _i13.BookAccessType.fromJson(data) as T;
    }
    if (t == _i14.BookCopy) {
      return _i14.BookCopy.fromJson(data) as T;
    }
    if (t == _i15.BookCopyStatus) {
      return _i15.BookCopyStatus.fromJson(data) as T;
    }
    if (t == _i16.BookDetail) {
      return _i16.BookDetail.fromJson(data) as T;
    }
    if (t == _i17.BookFavoriteStatus) {
      return _i17.BookFavoriteStatus.fromJson(data) as T;
    }
    if (t == _i18.BookLoan) {
      return _i18.BookLoan.fromJson(data) as T;
    }
    if (t == _i19.BookLoanPage) {
      return _i19.BookLoanPage.fromJson(data) as T;
    }
    if (t == _i20.BookLoanStatus) {
      return _i20.BookLoanStatus.fromJson(data) as T;
    }
    if (t == _i21.BookLoanSummary) {
      return _i21.BookLoanSummary.fromJson(data) as T;
    }
    if (t == _i22.BookSummary) {
      return _i22.BookSummary.fromJson(data) as T;
    }
    if (t == _i23.CampusNotification) {
      return _i23.CampusNotification.fromJson(data) as T;
    }
    if (t == _i24.CampusNotificationSummary) {
      return _i24.CampusNotificationSummary.fromJson(data) as T;
    }
    if (t == _i25.Course) {
      return _i25.Course.fromJson(data) as T;
    }
    if (t == _i26.CourseDetail) {
      return _i26.CourseDetail.fromJson(data) as T;
    }
    if (t == _i27.CourseOffering) {
      return _i27.CourseOffering.fromJson(data) as T;
    }
    if (t == _i28.CourseSchedule) {
      return _i28.CourseSchedule.fromJson(data) as T;
    }
    if (t == _i29.CourseSummary) {
      return _i29.CourseSummary.fromJson(data) as T;
    }
    if (t == _i30.CurriculumBlockProgress) {
      return _i30.CurriculumBlockProgress.fromJson(data) as T;
    }
    if (t == _i31.CurriculumProgress) {
      return _i31.CurriculumProgress.fromJson(data) as T;
    }
    if (t == _i32.DashboardAcademicSummary) {
      return _i32.DashboardAcademicSummary.fromJson(data) as T;
    }
    if (t == _i33.DashboardGreeting) {
      return _i33.DashboardGreeting.fromJson(data) as T;
    }
    if (t == _i34.Enrollment) {
      return _i34.Enrollment.fromJson(data) as T;
    }
    if (t == _i35.ExamSchedule) {
      return _i35.ExamSchedule.fromJson(data) as T;
    }
    if (t == _i36.ExamSummary) {
      return _i36.ExamSummary.fromJson(data) as T;
    }
    if (t == _i37.FavoriteBook) {
      return _i37.FavoriteBook.fromJson(data) as T;
    }
    if (t == _i38.GradeComponent) {
      return _i38.GradeComponent.fromJson(data) as T;
    }
    if (t == _i39.GradeComponentScore) {
      return _i39.GradeComponentScore.fromJson(data) as T;
    }
    if (t == _i40.GradeSummary) {
      return _i40.GradeSummary.fromJson(data) as T;
    }
    if (t == _i41.Greeting) {
      return _i41.Greeting.fromJson(data) as T;
    }
    if (t == _i42.KnowledgeChunk) {
      return _i42.KnowledgeChunk.fromJson(data) as T;
    }
    if (t == _i43.KnowledgeDocument) {
      return _i43.KnowledgeDocument.fromJson(data) as T;
    }
    if (t == _i44.LibraryAuthor) {
      return _i44.LibraryAuthor.fromJson(data) as T;
    }
    if (t == _i45.LibraryBook) {
      return _i45.LibraryBook.fromJson(data) as T;
    }
    if (t == _i46.LibraryBookAuthor) {
      return _i46.LibraryBookAuthor.fromJson(data) as T;
    }
    if (t == _i47.LibraryBookCategory) {
      return _i47.LibraryBookCategory.fromJson(data) as T;
    }
    if (t == _i48.LibraryBookCourse) {
      return _i48.LibraryBookCourse.fromJson(data) as T;
    }
    if (t == _i49.LibraryBookFile) {
      return _i49.LibraryBookFile.fromJson(data) as T;
    }
    if (t == _i50.LibraryCategory) {
      return _i50.LibraryCategory.fromJson(data) as T;
    }
    if (t == _i51.LibraryExplore) {
      return _i51.LibraryExplore.fromJson(data) as T;
    }
    if (t == _i52.LibraryExploreSection) {
      return _i52.LibraryExploreSection.fromJson(data) as T;
    }
    if (t == _i53.LibraryFilterOptions) {
      return _i53.LibraryFilterOptions.fromJson(data) as T;
    }
    if (t == _i54.LibrarySearchPage) {
      return _i54.LibrarySearchPage.fromJson(data) as T;
    }
    if (t == _i55.NotificationListPage) {
      return _i55.NotificationListPage.fromJson(data) as T;
    }
    if (t == _i56.RagCitation) {
      return _i56.RagCitation.fromJson(data) as T;
    }
    if (t == _i57.ReaderAsset) {
      return _i57.ReaderAsset.fromJson(data) as T;
    }
    if (t == _i58.ReaderBookmark) {
      return _i58.ReaderBookmark.fromJson(data) as T;
    }
    if (t == _i59.ReaderHighlight) {
      return _i59.ReaderHighlight.fromJson(data) as T;
    }
    if (t == _i60.ReaderNote) {
      return _i60.ReaderNote.fromJson(data) as T;
    }
    if (t == _i61.ReadingProgress) {
      return _i61.ReadingProgress.fromJson(data) as T;
    }
    if (t == _i62.ReadingProgressSyncResult) {
      return _i62.ReadingProgressSyncResult.fromJson(data) as T;
    }
    if (t == _i63.Semester) {
      return _i63.Semester.fromJson(data) as T;
    }
    if (t == _i64.SemesterSummary) {
      return _i64.SemesterSummary.fromJson(data) as T;
    }
    if (t == _i65.StudentAiPreference) {
      return _i65.StudentAiPreference.fromJson(data) as T;
    }
    if (t == _i66.StudentGrade) {
      return _i66.StudentGrade.fromJson(data) as T;
    }
    if (t == _i67.StudentProfile) {
      return _i67.StudentProfile.fromJson(data) as T;
    }
    if (t == _i68.StudySuggestion) {
      return _i68.StudySuggestion.fromJson(data) as T;
    }
    if (t == _i69.TimetableEntry) {
      return _i69.TimetableEntry.fromJson(data) as T;
    }
    if (t == _i70.VectorCapabilityProbe) {
      return _i70.VectorCapabilityProbe.fromJson(data) as T;
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
    if (t == _i1.getType<_i7.AiUserMemory?>()) {
      return (data != null ? _i7.AiUserMemory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Announcement?>()) {
      return (data != null ? _i8.Announcement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AnnouncementSummary?>()) {
      return (data != null ? _i9.AnnouncementSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.AuditLog?>()) {
      return (data != null ? _i10.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.BookAccessDecision?>()) {
      return (data != null ? _i11.BookAccessDecision.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.BookAccessPolicyUpdate?>()) {
      return (data != null ? _i12.BookAccessPolicyUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.BookAccessType?>()) {
      return (data != null ? _i13.BookAccessType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.BookCopy?>()) {
      return (data != null ? _i14.BookCopy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.BookCopyStatus?>()) {
      return (data != null ? _i15.BookCopyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.BookDetail?>()) {
      return (data != null ? _i16.BookDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.BookFavoriteStatus?>()) {
      return (data != null ? _i17.BookFavoriteStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.BookLoan?>()) {
      return (data != null ? _i18.BookLoan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.BookLoanPage?>()) {
      return (data != null ? _i19.BookLoanPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.BookLoanStatus?>()) {
      return (data != null ? _i20.BookLoanStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.BookLoanSummary?>()) {
      return (data != null ? _i21.BookLoanSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.BookSummary?>()) {
      return (data != null ? _i22.BookSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.CampusNotification?>()) {
      return (data != null ? _i23.CampusNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.CampusNotificationSummary?>()) {
      return (data != null
              ? _i24.CampusNotificationSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i25.Course?>()) {
      return (data != null ? _i25.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.CourseDetail?>()) {
      return (data != null ? _i26.CourseDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.CourseOffering?>()) {
      return (data != null ? _i27.CourseOffering.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.CourseSchedule?>()) {
      return (data != null ? _i28.CourseSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CourseSummary?>()) {
      return (data != null ? _i29.CourseSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CurriculumBlockProgress?>()) {
      return (data != null ? _i30.CurriculumBlockProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.CurriculumProgress?>()) {
      return (data != null ? _i31.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.DashboardAcademicSummary?>()) {
      return (data != null
              ? _i32.DashboardAcademicSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i33.DashboardGreeting?>()) {
      return (data != null ? _i33.DashboardGreeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.Enrollment?>()) {
      return (data != null ? _i34.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.ExamSchedule?>()) {
      return (data != null ? _i35.ExamSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.ExamSummary?>()) {
      return (data != null ? _i36.ExamSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.FavoriteBook?>()) {
      return (data != null ? _i37.FavoriteBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.GradeComponent?>()) {
      return (data != null ? _i38.GradeComponent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.GradeComponentScore?>()) {
      return (data != null ? _i39.GradeComponentScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.GradeSummary?>()) {
      return (data != null ? _i40.GradeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.Greeting?>()) {
      return (data != null ? _i41.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.KnowledgeChunk?>()) {
      return (data != null ? _i42.KnowledgeChunk.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.KnowledgeDocument?>()) {
      return (data != null ? _i43.KnowledgeDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.LibraryAuthor?>()) {
      return (data != null ? _i44.LibraryAuthor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.LibraryBook?>()) {
      return (data != null ? _i45.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.LibraryBookAuthor?>()) {
      return (data != null ? _i46.LibraryBookAuthor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.LibraryBookCategory?>()) {
      return (data != null ? _i47.LibraryBookCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.LibraryBookCourse?>()) {
      return (data != null ? _i48.LibraryBookCourse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.LibraryBookFile?>()) {
      return (data != null ? _i49.LibraryBookFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.LibraryCategory?>()) {
      return (data != null ? _i50.LibraryCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.LibraryExplore?>()) {
      return (data != null ? _i51.LibraryExplore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.LibraryExploreSection?>()) {
      return (data != null ? _i52.LibraryExploreSection.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.LibraryFilterOptions?>()) {
      return (data != null ? _i53.LibraryFilterOptions.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.LibrarySearchPage?>()) {
      return (data != null ? _i54.LibrarySearchPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.NotificationListPage?>()) {
      return (data != null ? _i55.NotificationListPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.RagCitation?>()) {
      return (data != null ? _i56.RagCitation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.ReaderAsset?>()) {
      return (data != null ? _i57.ReaderAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.ReaderBookmark?>()) {
      return (data != null ? _i58.ReaderBookmark.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.ReaderHighlight?>()) {
      return (data != null ? _i59.ReaderHighlight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.ReaderNote?>()) {
      return (data != null ? _i60.ReaderNote.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.ReadingProgress?>()) {
      return (data != null ? _i61.ReadingProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.ReadingProgressSyncResult?>()) {
      return (data != null
              ? _i62.ReadingProgressSyncResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i63.Semester?>()) {
      return (data != null ? _i63.Semester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.SemesterSummary?>()) {
      return (data != null ? _i64.SemesterSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.StudentAiPreference?>()) {
      return (data != null ? _i65.StudentAiPreference.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.StudentGrade?>()) {
      return (data != null ? _i66.StudentGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.StudentProfile?>()) {
      return (data != null ? _i67.StudentProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.StudySuggestion?>()) {
      return (data != null ? _i68.StudySuggestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.TimetableEntry?>()) {
      return (data != null ? _i69.TimetableEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.VectorCapabilityProbe?>()) {
      return (data != null ? _i70.VectorCapabilityProbe.fromJson(data) : null)
          as T;
    }
    if (t == List<_i64.SemesterSummary>) {
      return (data as List)
              .map((e) => deserialize<_i64.SemesterSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i29.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i69.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i69.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i36.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i21.BookLoanSummary>) {
      return (data as List)
              .map((e) => deserialize<_i21.BookLoanSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.GradeComponentScore>) {
      return (data as List)
              .map((e) => deserialize<_i39.GradeComponentScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.CurriculumBlockProgress>) {
      return (data as List)
              .map((e) => deserialize<_i30.CurriculumBlockProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.LibraryExploreSection>) {
      return (data as List)
              .map((e) => deserialize<_i52.LibraryExploreSection>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.BookSummary>) {
      return (data as List)
              .map((e) => deserialize<_i22.BookSummary>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i13.BookAccessType>) {
      return (data as List)
              .map((e) => deserialize<_i13.BookAccessType>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.CampusNotificationSummary>) {
      return (data as List)
              .map((e) => deserialize<_i24.CampusNotificationSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i71.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i71.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i72.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i73.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i73.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i74.AnnouncementSummary>) {
      return (data as List)
              .map((e) => deserialize<_i74.AnnouncementSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.AiConversation>) {
      return (data as List)
              .map((e) => deserialize<_i75.AiConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i76.AiMessage>) {
      return (data as List).map((e) => deserialize<_i76.AiMessage>(e)).toList()
          as T;
    }
    if (t == List<_i77.AiUserMemory>) {
      return (data as List)
              .map((e) => deserialize<_i77.AiUserMemory>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.RagCitation>) {
      return (data as List)
              .map((e) => deserialize<_i78.RagCitation>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.BookLoanSummary>) {
      return (data as List)
              .map((e) => deserialize<_i79.BookLoanSummary>(e))
              .toList()
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
    if (t == List<_i80.BookAccessType>) {
      return (data as List)
              .map((e) => deserialize<_i80.BookAccessType>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i80.BookAccessType>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i80.BookAccessType>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i81.ReaderBookmark>) {
      return (data as List)
              .map((e) => deserialize<_i81.ReaderBookmark>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.ReaderNote>) {
      return (data as List).map((e) => deserialize<_i82.ReaderNote>(e)).toList()
          as T;
    }
    if (t == List<_i83.ReaderHighlight>) {
      return (data as List)
              .map((e) => deserialize<_i83.ReaderHighlight>(e))
              .toList()
          as T;
    }
    try {
      return _i84.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i85.Protocol().deserialize<T>(data, t);
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
      _i7.AiUserMemory => 'AiUserMemory',
      _i8.Announcement => 'Announcement',
      _i9.AnnouncementSummary => 'AnnouncementSummary',
      _i10.AuditLog => 'AuditLog',
      _i11.BookAccessDecision => 'BookAccessDecision',
      _i12.BookAccessPolicyUpdate => 'BookAccessPolicyUpdate',
      _i13.BookAccessType => 'BookAccessType',
      _i14.BookCopy => 'BookCopy',
      _i15.BookCopyStatus => 'BookCopyStatus',
      _i16.BookDetail => 'BookDetail',
      _i17.BookFavoriteStatus => 'BookFavoriteStatus',
      _i18.BookLoan => 'BookLoan',
      _i19.BookLoanPage => 'BookLoanPage',
      _i20.BookLoanStatus => 'BookLoanStatus',
      _i21.BookLoanSummary => 'BookLoanSummary',
      _i22.BookSummary => 'BookSummary',
      _i23.CampusNotification => 'CampusNotification',
      _i24.CampusNotificationSummary => 'CampusNotificationSummary',
      _i25.Course => 'Course',
      _i26.CourseDetail => 'CourseDetail',
      _i27.CourseOffering => 'CourseOffering',
      _i28.CourseSchedule => 'CourseSchedule',
      _i29.CourseSummary => 'CourseSummary',
      _i30.CurriculumBlockProgress => 'CurriculumBlockProgress',
      _i31.CurriculumProgress => 'CurriculumProgress',
      _i32.DashboardAcademicSummary => 'DashboardAcademicSummary',
      _i33.DashboardGreeting => 'DashboardGreeting',
      _i34.Enrollment => 'Enrollment',
      _i35.ExamSchedule => 'ExamSchedule',
      _i36.ExamSummary => 'ExamSummary',
      _i37.FavoriteBook => 'FavoriteBook',
      _i38.GradeComponent => 'GradeComponent',
      _i39.GradeComponentScore => 'GradeComponentScore',
      _i40.GradeSummary => 'GradeSummary',
      _i41.Greeting => 'Greeting',
      _i42.KnowledgeChunk => 'KnowledgeChunk',
      _i43.KnowledgeDocument => 'KnowledgeDocument',
      _i44.LibraryAuthor => 'LibraryAuthor',
      _i45.LibraryBook => 'LibraryBook',
      _i46.LibraryBookAuthor => 'LibraryBookAuthor',
      _i47.LibraryBookCategory => 'LibraryBookCategory',
      _i48.LibraryBookCourse => 'LibraryBookCourse',
      _i49.LibraryBookFile => 'LibraryBookFile',
      _i50.LibraryCategory => 'LibraryCategory',
      _i51.LibraryExplore => 'LibraryExplore',
      _i52.LibraryExploreSection => 'LibraryExploreSection',
      _i53.LibraryFilterOptions => 'LibraryFilterOptions',
      _i54.LibrarySearchPage => 'LibrarySearchPage',
      _i55.NotificationListPage => 'NotificationListPage',
      _i56.RagCitation => 'RagCitation',
      _i57.ReaderAsset => 'ReaderAsset',
      _i58.ReaderBookmark => 'ReaderBookmark',
      _i59.ReaderHighlight => 'ReaderHighlight',
      _i60.ReaderNote => 'ReaderNote',
      _i61.ReadingProgress => 'ReadingProgress',
      _i62.ReadingProgressSyncResult => 'ReadingProgressSyncResult',
      _i63.Semester => 'Semester',
      _i64.SemesterSummary => 'SemesterSummary',
      _i65.StudentAiPreference => 'StudentAiPreference',
      _i66.StudentGrade => 'StudentGrade',
      _i67.StudentProfile => 'StudentProfile',
      _i68.StudySuggestion => 'StudySuggestion',
      _i69.TimetableEntry => 'TimetableEntry',
      _i70.VectorCapabilityProbe => 'VectorCapabilityProbe',
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
      case _i7.AiUserMemory():
        return 'AiUserMemory';
      case _i8.Announcement():
        return 'Announcement';
      case _i9.AnnouncementSummary():
        return 'AnnouncementSummary';
      case _i10.AuditLog():
        return 'AuditLog';
      case _i11.BookAccessDecision():
        return 'BookAccessDecision';
      case _i12.BookAccessPolicyUpdate():
        return 'BookAccessPolicyUpdate';
      case _i13.BookAccessType():
        return 'BookAccessType';
      case _i14.BookCopy():
        return 'BookCopy';
      case _i15.BookCopyStatus():
        return 'BookCopyStatus';
      case _i16.BookDetail():
        return 'BookDetail';
      case _i17.BookFavoriteStatus():
        return 'BookFavoriteStatus';
      case _i18.BookLoan():
        return 'BookLoan';
      case _i19.BookLoanPage():
        return 'BookLoanPage';
      case _i20.BookLoanStatus():
        return 'BookLoanStatus';
      case _i21.BookLoanSummary():
        return 'BookLoanSummary';
      case _i22.BookSummary():
        return 'BookSummary';
      case _i23.CampusNotification():
        return 'CampusNotification';
      case _i24.CampusNotificationSummary():
        return 'CampusNotificationSummary';
      case _i25.Course():
        return 'Course';
      case _i26.CourseDetail():
        return 'CourseDetail';
      case _i27.CourseOffering():
        return 'CourseOffering';
      case _i28.CourseSchedule():
        return 'CourseSchedule';
      case _i29.CourseSummary():
        return 'CourseSummary';
      case _i30.CurriculumBlockProgress():
        return 'CurriculumBlockProgress';
      case _i31.CurriculumProgress():
        return 'CurriculumProgress';
      case _i32.DashboardAcademicSummary():
        return 'DashboardAcademicSummary';
      case _i33.DashboardGreeting():
        return 'DashboardGreeting';
      case _i34.Enrollment():
        return 'Enrollment';
      case _i35.ExamSchedule():
        return 'ExamSchedule';
      case _i36.ExamSummary():
        return 'ExamSummary';
      case _i37.FavoriteBook():
        return 'FavoriteBook';
      case _i38.GradeComponent():
        return 'GradeComponent';
      case _i39.GradeComponentScore():
        return 'GradeComponentScore';
      case _i40.GradeSummary():
        return 'GradeSummary';
      case _i41.Greeting():
        return 'Greeting';
      case _i42.KnowledgeChunk():
        return 'KnowledgeChunk';
      case _i43.KnowledgeDocument():
        return 'KnowledgeDocument';
      case _i44.LibraryAuthor():
        return 'LibraryAuthor';
      case _i45.LibraryBook():
        return 'LibraryBook';
      case _i46.LibraryBookAuthor():
        return 'LibraryBookAuthor';
      case _i47.LibraryBookCategory():
        return 'LibraryBookCategory';
      case _i48.LibraryBookCourse():
        return 'LibraryBookCourse';
      case _i49.LibraryBookFile():
        return 'LibraryBookFile';
      case _i50.LibraryCategory():
        return 'LibraryCategory';
      case _i51.LibraryExplore():
        return 'LibraryExplore';
      case _i52.LibraryExploreSection():
        return 'LibraryExploreSection';
      case _i53.LibraryFilterOptions():
        return 'LibraryFilterOptions';
      case _i54.LibrarySearchPage():
        return 'LibrarySearchPage';
      case _i55.NotificationListPage():
        return 'NotificationListPage';
      case _i56.RagCitation():
        return 'RagCitation';
      case _i57.ReaderAsset():
        return 'ReaderAsset';
      case _i58.ReaderBookmark():
        return 'ReaderBookmark';
      case _i59.ReaderHighlight():
        return 'ReaderHighlight';
      case _i60.ReaderNote():
        return 'ReaderNote';
      case _i61.ReadingProgress():
        return 'ReadingProgress';
      case _i62.ReadingProgressSyncResult():
        return 'ReadingProgressSyncResult';
      case _i63.Semester():
        return 'Semester';
      case _i64.SemesterSummary():
        return 'SemesterSummary';
      case _i65.StudentAiPreference():
        return 'StudentAiPreference';
      case _i66.StudentGrade():
        return 'StudentGrade';
      case _i67.StudentProfile():
        return 'StudentProfile';
      case _i68.StudySuggestion():
        return 'StudySuggestion';
      case _i69.TimetableEntry():
        return 'TimetableEntry';
      case _i70.VectorCapabilityProbe():
        return 'VectorCapabilityProbe';
    }
    className = _i84.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i85.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AiUserMemory') {
      return deserialize<_i7.AiUserMemory>(data['data']);
    }
    if (dataClassName == 'Announcement') {
      return deserialize<_i8.Announcement>(data['data']);
    }
    if (dataClassName == 'AnnouncementSummary') {
      return deserialize<_i9.AnnouncementSummary>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_i10.AuditLog>(data['data']);
    }
    if (dataClassName == 'BookAccessDecision') {
      return deserialize<_i11.BookAccessDecision>(data['data']);
    }
    if (dataClassName == 'BookAccessPolicyUpdate') {
      return deserialize<_i12.BookAccessPolicyUpdate>(data['data']);
    }
    if (dataClassName == 'BookAccessType') {
      return deserialize<_i13.BookAccessType>(data['data']);
    }
    if (dataClassName == 'BookCopy') {
      return deserialize<_i14.BookCopy>(data['data']);
    }
    if (dataClassName == 'BookCopyStatus') {
      return deserialize<_i15.BookCopyStatus>(data['data']);
    }
    if (dataClassName == 'BookDetail') {
      return deserialize<_i16.BookDetail>(data['data']);
    }
    if (dataClassName == 'BookFavoriteStatus') {
      return deserialize<_i17.BookFavoriteStatus>(data['data']);
    }
    if (dataClassName == 'BookLoan') {
      return deserialize<_i18.BookLoan>(data['data']);
    }
    if (dataClassName == 'BookLoanPage') {
      return deserialize<_i19.BookLoanPage>(data['data']);
    }
    if (dataClassName == 'BookLoanStatus') {
      return deserialize<_i20.BookLoanStatus>(data['data']);
    }
    if (dataClassName == 'BookLoanSummary') {
      return deserialize<_i21.BookLoanSummary>(data['data']);
    }
    if (dataClassName == 'BookSummary') {
      return deserialize<_i22.BookSummary>(data['data']);
    }
    if (dataClassName == 'CampusNotification') {
      return deserialize<_i23.CampusNotification>(data['data']);
    }
    if (dataClassName == 'CampusNotificationSummary') {
      return deserialize<_i24.CampusNotificationSummary>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i25.Course>(data['data']);
    }
    if (dataClassName == 'CourseDetail') {
      return deserialize<_i26.CourseDetail>(data['data']);
    }
    if (dataClassName == 'CourseOffering') {
      return deserialize<_i27.CourseOffering>(data['data']);
    }
    if (dataClassName == 'CourseSchedule') {
      return deserialize<_i28.CourseSchedule>(data['data']);
    }
    if (dataClassName == 'CourseSummary') {
      return deserialize<_i29.CourseSummary>(data['data']);
    }
    if (dataClassName == 'CurriculumBlockProgress') {
      return deserialize<_i30.CurriculumBlockProgress>(data['data']);
    }
    if (dataClassName == 'CurriculumProgress') {
      return deserialize<_i31.CurriculumProgress>(data['data']);
    }
    if (dataClassName == 'DashboardAcademicSummary') {
      return deserialize<_i32.DashboardAcademicSummary>(data['data']);
    }
    if (dataClassName == 'DashboardGreeting') {
      return deserialize<_i33.DashboardGreeting>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i34.Enrollment>(data['data']);
    }
    if (dataClassName == 'ExamSchedule') {
      return deserialize<_i35.ExamSchedule>(data['data']);
    }
    if (dataClassName == 'ExamSummary') {
      return deserialize<_i36.ExamSummary>(data['data']);
    }
    if (dataClassName == 'FavoriteBook') {
      return deserialize<_i37.FavoriteBook>(data['data']);
    }
    if (dataClassName == 'GradeComponent') {
      return deserialize<_i38.GradeComponent>(data['data']);
    }
    if (dataClassName == 'GradeComponentScore') {
      return deserialize<_i39.GradeComponentScore>(data['data']);
    }
    if (dataClassName == 'GradeSummary') {
      return deserialize<_i40.GradeSummary>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i41.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeChunk') {
      return deserialize<_i42.KnowledgeChunk>(data['data']);
    }
    if (dataClassName == 'KnowledgeDocument') {
      return deserialize<_i43.KnowledgeDocument>(data['data']);
    }
    if (dataClassName == 'LibraryAuthor') {
      return deserialize<_i44.LibraryAuthor>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i45.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookAuthor') {
      return deserialize<_i46.LibraryBookAuthor>(data['data']);
    }
    if (dataClassName == 'LibraryBookCategory') {
      return deserialize<_i47.LibraryBookCategory>(data['data']);
    }
    if (dataClassName == 'LibraryBookCourse') {
      return deserialize<_i48.LibraryBookCourse>(data['data']);
    }
    if (dataClassName == 'LibraryBookFile') {
      return deserialize<_i49.LibraryBookFile>(data['data']);
    }
    if (dataClassName == 'LibraryCategory') {
      return deserialize<_i50.LibraryCategory>(data['data']);
    }
    if (dataClassName == 'LibraryExplore') {
      return deserialize<_i51.LibraryExplore>(data['data']);
    }
    if (dataClassName == 'LibraryExploreSection') {
      return deserialize<_i52.LibraryExploreSection>(data['data']);
    }
    if (dataClassName == 'LibraryFilterOptions') {
      return deserialize<_i53.LibraryFilterOptions>(data['data']);
    }
    if (dataClassName == 'LibrarySearchPage') {
      return deserialize<_i54.LibrarySearchPage>(data['data']);
    }
    if (dataClassName == 'NotificationListPage') {
      return deserialize<_i55.NotificationListPage>(data['data']);
    }
    if (dataClassName == 'RagCitation') {
      return deserialize<_i56.RagCitation>(data['data']);
    }
    if (dataClassName == 'ReaderAsset') {
      return deserialize<_i57.ReaderAsset>(data['data']);
    }
    if (dataClassName == 'ReaderBookmark') {
      return deserialize<_i58.ReaderBookmark>(data['data']);
    }
    if (dataClassName == 'ReaderHighlight') {
      return deserialize<_i59.ReaderHighlight>(data['data']);
    }
    if (dataClassName == 'ReaderNote') {
      return deserialize<_i60.ReaderNote>(data['data']);
    }
    if (dataClassName == 'ReadingProgress') {
      return deserialize<_i61.ReadingProgress>(data['data']);
    }
    if (dataClassName == 'ReadingProgressSyncResult') {
      return deserialize<_i62.ReadingProgressSyncResult>(data['data']);
    }
    if (dataClassName == 'Semester') {
      return deserialize<_i63.Semester>(data['data']);
    }
    if (dataClassName == 'SemesterSummary') {
      return deserialize<_i64.SemesterSummary>(data['data']);
    }
    if (dataClassName == 'StudentAiPreference') {
      return deserialize<_i65.StudentAiPreference>(data['data']);
    }
    if (dataClassName == 'StudentGrade') {
      return deserialize<_i66.StudentGrade>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_i67.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudySuggestion') {
      return deserialize<_i68.StudySuggestion>(data['data']);
    }
    if (dataClassName == 'TimetableEntry') {
      return deserialize<_i69.TimetableEntry>(data['data']);
    }
    if (dataClassName == 'VectorCapabilityProbe') {
      return deserialize<_i70.VectorCapabilityProbe>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i84.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i85.Protocol().deserializeByClassName(data);
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
      return _i84.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i85.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
