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
import 'admin_announcement_page.dart' as _i4;
import 'admin_audit_log_page.dart' as _i5;
import 'admin_dashboard_stats.dart' as _i6;
import 'admin_student_detail.dart' as _i7;
import 'admin_student_item.dart' as _i8;
import 'admin_student_page.dart' as _i9;
import 'ai_conversations.dart' as _i10;
import 'ai_messages.dart' as _i11;
import 'ai_usage.dart' as _i12;
import 'ai_user_memory.dart' as _i13;
import 'announcement.dart' as _i14;
import 'announcement_summary.dart' as _i15;
import 'audit_log.dart' as _i16;
import 'book_access_decision.dart' as _i17;
import 'book_access_policy_update.dart' as _i18;
import 'book_access_type.dart' as _i19;
import 'book_copy.dart' as _i20;
import 'book_copy_status.dart' as _i21;
import 'book_detail.dart' as _i22;
import 'book_favorite_status.dart' as _i23;
import 'book_loan.dart' as _i24;
import 'book_loan_page.dart' as _i25;
import 'book_loan_status.dart' as _i26;
import 'book_loan_summary.dart' as _i27;
import 'book_summary.dart' as _i28;
import 'book_upload_ticket.dart' as _i29;
import 'campus_notification.dart' as _i30;
import 'campus_notification_summary.dart' as _i31;
import 'course.dart' as _i32;
import 'course_detail.dart' as _i33;
import 'course_offering.dart' as _i34;
import 'course_schedule.dart' as _i35;
import 'course_summary.dart' as _i36;
import 'curriculum_block_progress.dart' as _i37;
import 'curriculum_progress.dart' as _i38;
import 'dashboard_academic_summary.dart' as _i39;
import 'dashboard_greeting.dart' as _i40;
import 'enrollment.dart' as _i41;
import 'exam_schedule.dart' as _i42;
import 'exam_summary.dart' as _i43;
import 'favorite_book.dart' as _i44;
import 'grade_component.dart' as _i45;
import 'grade_component_score.dart' as _i46;
import 'grade_summary.dart' as _i47;
import 'greetings/greeting.dart' as _i48;
import 'knowledge_chunk.dart' as _i49;
import 'knowledge_document.dart' as _i50;
import 'library_author.dart' as _i51;
import 'library_book.dart' as _i52;
import 'library_book_author.dart' as _i53;
import 'library_book_category.dart' as _i54;
import 'library_book_course.dart' as _i55;
import 'library_book_file.dart' as _i56;
import 'library_category.dart' as _i57;
import 'library_explore.dart' as _i58;
import 'library_explore_section.dart' as _i59;
import 'library_filter_options.dart' as _i60;
import 'library_search_page.dart' as _i61;
import 'notification_list_page.dart' as _i62;
import 'rag_citation.dart' as _i63;
import 'reader_asset.dart' as _i64;
import 'reader_bookmark.dart' as _i65;
import 'reader_highlight.dart' as _i66;
import 'reader_note.dart' as _i67;
import 'reading_progress.dart' as _i68;
import 'reading_progress_sync_result.dart' as _i69;
import 'semester.dart' as _i70;
import 'semester_summary.dart' as _i71;
import 'student_ai_preference.dart' as _i72;
import 'student_grade.dart' as _i73;
import 'student_profile.dart' as _i74;
import 'study_suggestion.dart' as _i75;
import 'timetable_entry.dart' as _i76;
import 'vector_capability_probe.dart' as _i77;
import 'package:campusmate_client/src/protocol/course_summary.dart' as _i78;
import 'package:campusmate_client/src/protocol/timetable_entry.dart' as _i79;
import 'package:campusmate_client/src/protocol/exam_summary.dart' as _i80;
import 'package:campusmate_client/src/protocol/announcement_summary.dart'
    as _i81;
import 'package:campusmate_client/src/protocol/ai_conversations.dart' as _i82;
import 'package:campusmate_client/src/protocol/ai_messages.dart' as _i83;
import 'package:campusmate_client/src/protocol/ai_user_memory.dart' as _i84;
import 'package:campusmate_client/src/protocol/rag_citation.dart' as _i85;
import 'package:campusmate_client/src/protocol/book_loan_summary.dart' as _i86;
import 'package:campusmate_client/src/protocol/book_access_type.dart' as _i87;
import 'package:campusmate_client/src/protocol/reader_bookmark.dart' as _i88;
import 'package:campusmate_client/src/protocol/reader_note.dart' as _i89;
import 'package:campusmate_client/src/protocol/reader_highlight.dart' as _i90;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i91;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i92;
export 'academic_overview.dart';
export 'academic_year.dart';
export 'admin_announcement_page.dart';
export 'admin_audit_log_page.dart';
export 'admin_dashboard_stats.dart';
export 'admin_student_detail.dart';
export 'admin_student_item.dart';
export 'admin_student_page.dart';
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
export 'book_upload_ticket.dart';
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
    if (t == _i4.AdminAnnouncementPage) {
      return _i4.AdminAnnouncementPage.fromJson(data) as T;
    }
    if (t == _i5.AdminAuditLogPage) {
      return _i5.AdminAuditLogPage.fromJson(data) as T;
    }
    if (t == _i6.AdminDashboardStats) {
      return _i6.AdminDashboardStats.fromJson(data) as T;
    }
    if (t == _i7.AdminStudentDetail) {
      return _i7.AdminStudentDetail.fromJson(data) as T;
    }
    if (t == _i8.AdminStudentItem) {
      return _i8.AdminStudentItem.fromJson(data) as T;
    }
    if (t == _i9.AdminStudentPage) {
      return _i9.AdminStudentPage.fromJson(data) as T;
    }
    if (t == _i10.AiConversation) {
      return _i10.AiConversation.fromJson(data) as T;
    }
    if (t == _i11.AiMessage) {
      return _i11.AiMessage.fromJson(data) as T;
    }
    if (t == _i12.AiUsage) {
      return _i12.AiUsage.fromJson(data) as T;
    }
    if (t == _i13.AiUserMemory) {
      return _i13.AiUserMemory.fromJson(data) as T;
    }
    if (t == _i14.Announcement) {
      return _i14.Announcement.fromJson(data) as T;
    }
    if (t == _i15.AnnouncementSummary) {
      return _i15.AnnouncementSummary.fromJson(data) as T;
    }
    if (t == _i16.AuditLog) {
      return _i16.AuditLog.fromJson(data) as T;
    }
    if (t == _i17.BookAccessDecision) {
      return _i17.BookAccessDecision.fromJson(data) as T;
    }
    if (t == _i18.BookAccessPolicyUpdate) {
      return _i18.BookAccessPolicyUpdate.fromJson(data) as T;
    }
    if (t == _i19.BookAccessType) {
      return _i19.BookAccessType.fromJson(data) as T;
    }
    if (t == _i20.BookCopy) {
      return _i20.BookCopy.fromJson(data) as T;
    }
    if (t == _i21.BookCopyStatus) {
      return _i21.BookCopyStatus.fromJson(data) as T;
    }
    if (t == _i22.BookDetail) {
      return _i22.BookDetail.fromJson(data) as T;
    }
    if (t == _i23.BookFavoriteStatus) {
      return _i23.BookFavoriteStatus.fromJson(data) as T;
    }
    if (t == _i24.BookLoan) {
      return _i24.BookLoan.fromJson(data) as T;
    }
    if (t == _i25.BookLoanPage) {
      return _i25.BookLoanPage.fromJson(data) as T;
    }
    if (t == _i26.BookLoanStatus) {
      return _i26.BookLoanStatus.fromJson(data) as T;
    }
    if (t == _i27.BookLoanSummary) {
      return _i27.BookLoanSummary.fromJson(data) as T;
    }
    if (t == _i28.BookSummary) {
      return _i28.BookSummary.fromJson(data) as T;
    }
    if (t == _i29.BookUploadTicket) {
      return _i29.BookUploadTicket.fromJson(data) as T;
    }
    if (t == _i30.CampusNotification) {
      return _i30.CampusNotification.fromJson(data) as T;
    }
    if (t == _i31.CampusNotificationSummary) {
      return _i31.CampusNotificationSummary.fromJson(data) as T;
    }
    if (t == _i32.Course) {
      return _i32.Course.fromJson(data) as T;
    }
    if (t == _i33.CourseDetail) {
      return _i33.CourseDetail.fromJson(data) as T;
    }
    if (t == _i34.CourseOffering) {
      return _i34.CourseOffering.fromJson(data) as T;
    }
    if (t == _i35.CourseSchedule) {
      return _i35.CourseSchedule.fromJson(data) as T;
    }
    if (t == _i36.CourseSummary) {
      return _i36.CourseSummary.fromJson(data) as T;
    }
    if (t == _i37.CurriculumBlockProgress) {
      return _i37.CurriculumBlockProgress.fromJson(data) as T;
    }
    if (t == _i38.CurriculumProgress) {
      return _i38.CurriculumProgress.fromJson(data) as T;
    }
    if (t == _i39.DashboardAcademicSummary) {
      return _i39.DashboardAcademicSummary.fromJson(data) as T;
    }
    if (t == _i40.DashboardGreeting) {
      return _i40.DashboardGreeting.fromJson(data) as T;
    }
    if (t == _i41.Enrollment) {
      return _i41.Enrollment.fromJson(data) as T;
    }
    if (t == _i42.ExamSchedule) {
      return _i42.ExamSchedule.fromJson(data) as T;
    }
    if (t == _i43.ExamSummary) {
      return _i43.ExamSummary.fromJson(data) as T;
    }
    if (t == _i44.FavoriteBook) {
      return _i44.FavoriteBook.fromJson(data) as T;
    }
    if (t == _i45.GradeComponent) {
      return _i45.GradeComponent.fromJson(data) as T;
    }
    if (t == _i46.GradeComponentScore) {
      return _i46.GradeComponentScore.fromJson(data) as T;
    }
    if (t == _i47.GradeSummary) {
      return _i47.GradeSummary.fromJson(data) as T;
    }
    if (t == _i48.Greeting) {
      return _i48.Greeting.fromJson(data) as T;
    }
    if (t == _i49.KnowledgeChunk) {
      return _i49.KnowledgeChunk.fromJson(data) as T;
    }
    if (t == _i50.KnowledgeDocument) {
      return _i50.KnowledgeDocument.fromJson(data) as T;
    }
    if (t == _i51.LibraryAuthor) {
      return _i51.LibraryAuthor.fromJson(data) as T;
    }
    if (t == _i52.LibraryBook) {
      return _i52.LibraryBook.fromJson(data) as T;
    }
    if (t == _i53.LibraryBookAuthor) {
      return _i53.LibraryBookAuthor.fromJson(data) as T;
    }
    if (t == _i54.LibraryBookCategory) {
      return _i54.LibraryBookCategory.fromJson(data) as T;
    }
    if (t == _i55.LibraryBookCourse) {
      return _i55.LibraryBookCourse.fromJson(data) as T;
    }
    if (t == _i56.LibraryBookFile) {
      return _i56.LibraryBookFile.fromJson(data) as T;
    }
    if (t == _i57.LibraryCategory) {
      return _i57.LibraryCategory.fromJson(data) as T;
    }
    if (t == _i58.LibraryExplore) {
      return _i58.LibraryExplore.fromJson(data) as T;
    }
    if (t == _i59.LibraryExploreSection) {
      return _i59.LibraryExploreSection.fromJson(data) as T;
    }
    if (t == _i60.LibraryFilterOptions) {
      return _i60.LibraryFilterOptions.fromJson(data) as T;
    }
    if (t == _i61.LibrarySearchPage) {
      return _i61.LibrarySearchPage.fromJson(data) as T;
    }
    if (t == _i62.NotificationListPage) {
      return _i62.NotificationListPage.fromJson(data) as T;
    }
    if (t == _i63.RagCitation) {
      return _i63.RagCitation.fromJson(data) as T;
    }
    if (t == _i64.ReaderAsset) {
      return _i64.ReaderAsset.fromJson(data) as T;
    }
    if (t == _i65.ReaderBookmark) {
      return _i65.ReaderBookmark.fromJson(data) as T;
    }
    if (t == _i66.ReaderHighlight) {
      return _i66.ReaderHighlight.fromJson(data) as T;
    }
    if (t == _i67.ReaderNote) {
      return _i67.ReaderNote.fromJson(data) as T;
    }
    if (t == _i68.ReadingProgress) {
      return _i68.ReadingProgress.fromJson(data) as T;
    }
    if (t == _i69.ReadingProgressSyncResult) {
      return _i69.ReadingProgressSyncResult.fromJson(data) as T;
    }
    if (t == _i70.Semester) {
      return _i70.Semester.fromJson(data) as T;
    }
    if (t == _i71.SemesterSummary) {
      return _i71.SemesterSummary.fromJson(data) as T;
    }
    if (t == _i72.StudentAiPreference) {
      return _i72.StudentAiPreference.fromJson(data) as T;
    }
    if (t == _i73.StudentGrade) {
      return _i73.StudentGrade.fromJson(data) as T;
    }
    if (t == _i74.StudentProfile) {
      return _i74.StudentProfile.fromJson(data) as T;
    }
    if (t == _i75.StudySuggestion) {
      return _i75.StudySuggestion.fromJson(data) as T;
    }
    if (t == _i76.TimetableEntry) {
      return _i76.TimetableEntry.fromJson(data) as T;
    }
    if (t == _i77.VectorCapabilityProbe) {
      return _i77.VectorCapabilityProbe.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AcademicOverview?>()) {
      return (data != null ? _i2.AcademicOverview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AcademicYear?>()) {
      return (data != null ? _i3.AcademicYear.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AdminAnnouncementPage?>()) {
      return (data != null ? _i4.AdminAnnouncementPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.AdminAuditLogPage?>()) {
      return (data != null ? _i5.AdminAuditLogPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AdminDashboardStats?>()) {
      return (data != null ? _i6.AdminDashboardStats.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.AdminStudentDetail?>()) {
      return (data != null ? _i7.AdminStudentDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AdminStudentItem?>()) {
      return (data != null ? _i8.AdminStudentItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AdminStudentPage?>()) {
      return (data != null ? _i9.AdminStudentPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AiConversation?>()) {
      return (data != null ? _i10.AiConversation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.AiMessage?>()) {
      return (data != null ? _i11.AiMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AiUsage?>()) {
      return (data != null ? _i12.AiUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AiUserMemory?>()) {
      return (data != null ? _i13.AiUserMemory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Announcement?>()) {
      return (data != null ? _i14.Announcement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.AnnouncementSummary?>()) {
      return (data != null ? _i15.AnnouncementSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.AuditLog?>()) {
      return (data != null ? _i16.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.BookAccessDecision?>()) {
      return (data != null ? _i17.BookAccessDecision.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.BookAccessPolicyUpdate?>()) {
      return (data != null ? _i18.BookAccessPolicyUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.BookAccessType?>()) {
      return (data != null ? _i19.BookAccessType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.BookCopy?>()) {
      return (data != null ? _i20.BookCopy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.BookCopyStatus?>()) {
      return (data != null ? _i21.BookCopyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.BookDetail?>()) {
      return (data != null ? _i22.BookDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.BookFavoriteStatus?>()) {
      return (data != null ? _i23.BookFavoriteStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.BookLoan?>()) {
      return (data != null ? _i24.BookLoan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.BookLoanPage?>()) {
      return (data != null ? _i25.BookLoanPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.BookLoanStatus?>()) {
      return (data != null ? _i26.BookLoanStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.BookLoanSummary?>()) {
      return (data != null ? _i27.BookLoanSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.BookSummary?>()) {
      return (data != null ? _i28.BookSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.BookUploadTicket?>()) {
      return (data != null ? _i29.BookUploadTicket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CampusNotification?>()) {
      return (data != null ? _i30.CampusNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.CampusNotificationSummary?>()) {
      return (data != null
              ? _i31.CampusNotificationSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.Course?>()) {
      return (data != null ? _i32.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.CourseDetail?>()) {
      return (data != null ? _i33.CourseDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.CourseOffering?>()) {
      return (data != null ? _i34.CourseOffering.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.CourseSchedule?>()) {
      return (data != null ? _i35.CourseSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.CourseSummary?>()) {
      return (data != null ? _i36.CourseSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.CurriculumBlockProgress?>()) {
      return (data != null ? _i37.CurriculumBlockProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.CurriculumProgress?>()) {
      return (data != null ? _i38.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.DashboardAcademicSummary?>()) {
      return (data != null
              ? _i39.DashboardAcademicSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i40.DashboardGreeting?>()) {
      return (data != null ? _i40.DashboardGreeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.Enrollment?>()) {
      return (data != null ? _i41.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.ExamSchedule?>()) {
      return (data != null ? _i42.ExamSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.ExamSummary?>()) {
      return (data != null ? _i43.ExamSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.FavoriteBook?>()) {
      return (data != null ? _i44.FavoriteBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.GradeComponent?>()) {
      return (data != null ? _i45.GradeComponent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.GradeComponentScore?>()) {
      return (data != null ? _i46.GradeComponentScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.GradeSummary?>()) {
      return (data != null ? _i47.GradeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.Greeting?>()) {
      return (data != null ? _i48.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.KnowledgeChunk?>()) {
      return (data != null ? _i49.KnowledgeChunk.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.KnowledgeDocument?>()) {
      return (data != null ? _i50.KnowledgeDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.LibraryAuthor?>()) {
      return (data != null ? _i51.LibraryAuthor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.LibraryBook?>()) {
      return (data != null ? _i52.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.LibraryBookAuthor?>()) {
      return (data != null ? _i53.LibraryBookAuthor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.LibraryBookCategory?>()) {
      return (data != null ? _i54.LibraryBookCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.LibraryBookCourse?>()) {
      return (data != null ? _i55.LibraryBookCourse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.LibraryBookFile?>()) {
      return (data != null ? _i56.LibraryBookFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.LibraryCategory?>()) {
      return (data != null ? _i57.LibraryCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.LibraryExplore?>()) {
      return (data != null ? _i58.LibraryExplore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.LibraryExploreSection?>()) {
      return (data != null ? _i59.LibraryExploreSection.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.LibraryFilterOptions?>()) {
      return (data != null ? _i60.LibraryFilterOptions.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i61.LibrarySearchPage?>()) {
      return (data != null ? _i61.LibrarySearchPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.NotificationListPage?>()) {
      return (data != null ? _i62.NotificationListPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i63.RagCitation?>()) {
      return (data != null ? _i63.RagCitation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.ReaderAsset?>()) {
      return (data != null ? _i64.ReaderAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.ReaderBookmark?>()) {
      return (data != null ? _i65.ReaderBookmark.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.ReaderHighlight?>()) {
      return (data != null ? _i66.ReaderHighlight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.ReaderNote?>()) {
      return (data != null ? _i67.ReaderNote.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.ReadingProgress?>()) {
      return (data != null ? _i68.ReadingProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.ReadingProgressSyncResult?>()) {
      return (data != null
              ? _i69.ReadingProgressSyncResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i70.Semester?>()) {
      return (data != null ? _i70.Semester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.SemesterSummary?>()) {
      return (data != null ? _i71.SemesterSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.StudentAiPreference?>()) {
      return (data != null ? _i72.StudentAiPreference.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i73.StudentGrade?>()) {
      return (data != null ? _i73.StudentGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.StudentProfile?>()) {
      return (data != null ? _i74.StudentProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.StudySuggestion?>()) {
      return (data != null ? _i75.StudySuggestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.TimetableEntry?>()) {
      return (data != null ? _i76.TimetableEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.VectorCapabilityProbe?>()) {
      return (data != null ? _i77.VectorCapabilityProbe.fromJson(data) : null)
          as T;
    }
    if (t == List<_i71.SemesterSummary>) {
      return (data as List)
              .map((e) => deserialize<_i71.SemesterSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i36.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i76.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i76.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i43.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.Announcement>) {
      return (data as List)
              .map((e) => deserialize<_i14.Announcement>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.AuditLog>) {
      return (data as List).map((e) => deserialize<_i16.AuditLog>(e)).toList()
          as T;
    }
    if (t == List<_i8.AdminStudentItem>) {
      return (data as List)
              .map((e) => deserialize<_i8.AdminStudentItem>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i27.BookLoanSummary>) {
      return (data as List)
              .map((e) => deserialize<_i27.BookLoanSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i46.GradeComponentScore>) {
      return (data as List)
              .map((e) => deserialize<_i46.GradeComponentScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.CurriculumBlockProgress>) {
      return (data as List)
              .map((e) => deserialize<_i37.CurriculumBlockProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i59.LibraryExploreSection>) {
      return (data as List)
              .map((e) => deserialize<_i59.LibraryExploreSection>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.BookSummary>) {
      return (data as List)
              .map((e) => deserialize<_i28.BookSummary>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i19.BookAccessType>) {
      return (data as List)
              .map((e) => deserialize<_i19.BookAccessType>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.CampusNotificationSummary>) {
      return (data as List)
              .map((e) => deserialize<_i31.CampusNotificationSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i78.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i79.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i80.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.AnnouncementSummary>) {
      return (data as List)
              .map((e) => deserialize<_i81.AnnouncementSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.AiConversation>) {
      return (data as List)
              .map((e) => deserialize<_i82.AiConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i83.AiMessage>) {
      return (data as List).map((e) => deserialize<_i83.AiMessage>(e)).toList()
          as T;
    }
    if (t == List<_i84.AiUserMemory>) {
      return (data as List)
              .map((e) => deserialize<_i84.AiUserMemory>(e))
              .toList()
          as T;
    }
    if (t == List<_i85.RagCitation>) {
      return (data as List)
              .map((e) => deserialize<_i85.RagCitation>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.BookLoanSummary>) {
      return (data as List)
              .map((e) => deserialize<_i86.BookLoanSummary>(e))
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
    if (t == List<_i87.BookAccessType>) {
      return (data as List)
              .map((e) => deserialize<_i87.BookAccessType>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i87.BookAccessType>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i87.BookAccessType>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i88.ReaderBookmark>) {
      return (data as List)
              .map((e) => deserialize<_i88.ReaderBookmark>(e))
              .toList()
          as T;
    }
    if (t == List<_i89.ReaderNote>) {
      return (data as List).map((e) => deserialize<_i89.ReaderNote>(e)).toList()
          as T;
    }
    if (t == List<_i90.ReaderHighlight>) {
      return (data as List)
              .map((e) => deserialize<_i90.ReaderHighlight>(e))
              .toList()
          as T;
    }
    try {
      return _i91.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i92.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AcademicOverview => 'AcademicOverview',
      _i3.AcademicYear => 'AcademicYear',
      _i4.AdminAnnouncementPage => 'AdminAnnouncementPage',
      _i5.AdminAuditLogPage => 'AdminAuditLogPage',
      _i6.AdminDashboardStats => 'AdminDashboardStats',
      _i7.AdminStudentDetail => 'AdminStudentDetail',
      _i8.AdminStudentItem => 'AdminStudentItem',
      _i9.AdminStudentPage => 'AdminStudentPage',
      _i10.AiConversation => 'AiConversation',
      _i11.AiMessage => 'AiMessage',
      _i12.AiUsage => 'AiUsage',
      _i13.AiUserMemory => 'AiUserMemory',
      _i14.Announcement => 'Announcement',
      _i15.AnnouncementSummary => 'AnnouncementSummary',
      _i16.AuditLog => 'AuditLog',
      _i17.BookAccessDecision => 'BookAccessDecision',
      _i18.BookAccessPolicyUpdate => 'BookAccessPolicyUpdate',
      _i19.BookAccessType => 'BookAccessType',
      _i20.BookCopy => 'BookCopy',
      _i21.BookCopyStatus => 'BookCopyStatus',
      _i22.BookDetail => 'BookDetail',
      _i23.BookFavoriteStatus => 'BookFavoriteStatus',
      _i24.BookLoan => 'BookLoan',
      _i25.BookLoanPage => 'BookLoanPage',
      _i26.BookLoanStatus => 'BookLoanStatus',
      _i27.BookLoanSummary => 'BookLoanSummary',
      _i28.BookSummary => 'BookSummary',
      _i29.BookUploadTicket => 'BookUploadTicket',
      _i30.CampusNotification => 'CampusNotification',
      _i31.CampusNotificationSummary => 'CampusNotificationSummary',
      _i32.Course => 'Course',
      _i33.CourseDetail => 'CourseDetail',
      _i34.CourseOffering => 'CourseOffering',
      _i35.CourseSchedule => 'CourseSchedule',
      _i36.CourseSummary => 'CourseSummary',
      _i37.CurriculumBlockProgress => 'CurriculumBlockProgress',
      _i38.CurriculumProgress => 'CurriculumProgress',
      _i39.DashboardAcademicSummary => 'DashboardAcademicSummary',
      _i40.DashboardGreeting => 'DashboardGreeting',
      _i41.Enrollment => 'Enrollment',
      _i42.ExamSchedule => 'ExamSchedule',
      _i43.ExamSummary => 'ExamSummary',
      _i44.FavoriteBook => 'FavoriteBook',
      _i45.GradeComponent => 'GradeComponent',
      _i46.GradeComponentScore => 'GradeComponentScore',
      _i47.GradeSummary => 'GradeSummary',
      _i48.Greeting => 'Greeting',
      _i49.KnowledgeChunk => 'KnowledgeChunk',
      _i50.KnowledgeDocument => 'KnowledgeDocument',
      _i51.LibraryAuthor => 'LibraryAuthor',
      _i52.LibraryBook => 'LibraryBook',
      _i53.LibraryBookAuthor => 'LibraryBookAuthor',
      _i54.LibraryBookCategory => 'LibraryBookCategory',
      _i55.LibraryBookCourse => 'LibraryBookCourse',
      _i56.LibraryBookFile => 'LibraryBookFile',
      _i57.LibraryCategory => 'LibraryCategory',
      _i58.LibraryExplore => 'LibraryExplore',
      _i59.LibraryExploreSection => 'LibraryExploreSection',
      _i60.LibraryFilterOptions => 'LibraryFilterOptions',
      _i61.LibrarySearchPage => 'LibrarySearchPage',
      _i62.NotificationListPage => 'NotificationListPage',
      _i63.RagCitation => 'RagCitation',
      _i64.ReaderAsset => 'ReaderAsset',
      _i65.ReaderBookmark => 'ReaderBookmark',
      _i66.ReaderHighlight => 'ReaderHighlight',
      _i67.ReaderNote => 'ReaderNote',
      _i68.ReadingProgress => 'ReadingProgress',
      _i69.ReadingProgressSyncResult => 'ReadingProgressSyncResult',
      _i70.Semester => 'Semester',
      _i71.SemesterSummary => 'SemesterSummary',
      _i72.StudentAiPreference => 'StudentAiPreference',
      _i73.StudentGrade => 'StudentGrade',
      _i74.StudentProfile => 'StudentProfile',
      _i75.StudySuggestion => 'StudySuggestion',
      _i76.TimetableEntry => 'TimetableEntry',
      _i77.VectorCapabilityProbe => 'VectorCapabilityProbe',
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
      case _i4.AdminAnnouncementPage():
        return 'AdminAnnouncementPage';
      case _i5.AdminAuditLogPage():
        return 'AdminAuditLogPage';
      case _i6.AdminDashboardStats():
        return 'AdminDashboardStats';
      case _i7.AdminStudentDetail():
        return 'AdminStudentDetail';
      case _i8.AdminStudentItem():
        return 'AdminStudentItem';
      case _i9.AdminStudentPage():
        return 'AdminStudentPage';
      case _i10.AiConversation():
        return 'AiConversation';
      case _i11.AiMessage():
        return 'AiMessage';
      case _i12.AiUsage():
        return 'AiUsage';
      case _i13.AiUserMemory():
        return 'AiUserMemory';
      case _i14.Announcement():
        return 'Announcement';
      case _i15.AnnouncementSummary():
        return 'AnnouncementSummary';
      case _i16.AuditLog():
        return 'AuditLog';
      case _i17.BookAccessDecision():
        return 'BookAccessDecision';
      case _i18.BookAccessPolicyUpdate():
        return 'BookAccessPolicyUpdate';
      case _i19.BookAccessType():
        return 'BookAccessType';
      case _i20.BookCopy():
        return 'BookCopy';
      case _i21.BookCopyStatus():
        return 'BookCopyStatus';
      case _i22.BookDetail():
        return 'BookDetail';
      case _i23.BookFavoriteStatus():
        return 'BookFavoriteStatus';
      case _i24.BookLoan():
        return 'BookLoan';
      case _i25.BookLoanPage():
        return 'BookLoanPage';
      case _i26.BookLoanStatus():
        return 'BookLoanStatus';
      case _i27.BookLoanSummary():
        return 'BookLoanSummary';
      case _i28.BookSummary():
        return 'BookSummary';
      case _i29.BookUploadTicket():
        return 'BookUploadTicket';
      case _i30.CampusNotification():
        return 'CampusNotification';
      case _i31.CampusNotificationSummary():
        return 'CampusNotificationSummary';
      case _i32.Course():
        return 'Course';
      case _i33.CourseDetail():
        return 'CourseDetail';
      case _i34.CourseOffering():
        return 'CourseOffering';
      case _i35.CourseSchedule():
        return 'CourseSchedule';
      case _i36.CourseSummary():
        return 'CourseSummary';
      case _i37.CurriculumBlockProgress():
        return 'CurriculumBlockProgress';
      case _i38.CurriculumProgress():
        return 'CurriculumProgress';
      case _i39.DashboardAcademicSummary():
        return 'DashboardAcademicSummary';
      case _i40.DashboardGreeting():
        return 'DashboardGreeting';
      case _i41.Enrollment():
        return 'Enrollment';
      case _i42.ExamSchedule():
        return 'ExamSchedule';
      case _i43.ExamSummary():
        return 'ExamSummary';
      case _i44.FavoriteBook():
        return 'FavoriteBook';
      case _i45.GradeComponent():
        return 'GradeComponent';
      case _i46.GradeComponentScore():
        return 'GradeComponentScore';
      case _i47.GradeSummary():
        return 'GradeSummary';
      case _i48.Greeting():
        return 'Greeting';
      case _i49.KnowledgeChunk():
        return 'KnowledgeChunk';
      case _i50.KnowledgeDocument():
        return 'KnowledgeDocument';
      case _i51.LibraryAuthor():
        return 'LibraryAuthor';
      case _i52.LibraryBook():
        return 'LibraryBook';
      case _i53.LibraryBookAuthor():
        return 'LibraryBookAuthor';
      case _i54.LibraryBookCategory():
        return 'LibraryBookCategory';
      case _i55.LibraryBookCourse():
        return 'LibraryBookCourse';
      case _i56.LibraryBookFile():
        return 'LibraryBookFile';
      case _i57.LibraryCategory():
        return 'LibraryCategory';
      case _i58.LibraryExplore():
        return 'LibraryExplore';
      case _i59.LibraryExploreSection():
        return 'LibraryExploreSection';
      case _i60.LibraryFilterOptions():
        return 'LibraryFilterOptions';
      case _i61.LibrarySearchPage():
        return 'LibrarySearchPage';
      case _i62.NotificationListPage():
        return 'NotificationListPage';
      case _i63.RagCitation():
        return 'RagCitation';
      case _i64.ReaderAsset():
        return 'ReaderAsset';
      case _i65.ReaderBookmark():
        return 'ReaderBookmark';
      case _i66.ReaderHighlight():
        return 'ReaderHighlight';
      case _i67.ReaderNote():
        return 'ReaderNote';
      case _i68.ReadingProgress():
        return 'ReadingProgress';
      case _i69.ReadingProgressSyncResult():
        return 'ReadingProgressSyncResult';
      case _i70.Semester():
        return 'Semester';
      case _i71.SemesterSummary():
        return 'SemesterSummary';
      case _i72.StudentAiPreference():
        return 'StudentAiPreference';
      case _i73.StudentGrade():
        return 'StudentGrade';
      case _i74.StudentProfile():
        return 'StudentProfile';
      case _i75.StudySuggestion():
        return 'StudySuggestion';
      case _i76.TimetableEntry():
        return 'TimetableEntry';
      case _i77.VectorCapabilityProbe():
        return 'VectorCapabilityProbe';
    }
    className = _i91.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i92.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AdminAnnouncementPage') {
      return deserialize<_i4.AdminAnnouncementPage>(data['data']);
    }
    if (dataClassName == 'AdminAuditLogPage') {
      return deserialize<_i5.AdminAuditLogPage>(data['data']);
    }
    if (dataClassName == 'AdminDashboardStats') {
      return deserialize<_i6.AdminDashboardStats>(data['data']);
    }
    if (dataClassName == 'AdminStudentDetail') {
      return deserialize<_i7.AdminStudentDetail>(data['data']);
    }
    if (dataClassName == 'AdminStudentItem') {
      return deserialize<_i8.AdminStudentItem>(data['data']);
    }
    if (dataClassName == 'AdminStudentPage') {
      return deserialize<_i9.AdminStudentPage>(data['data']);
    }
    if (dataClassName == 'AiConversation') {
      return deserialize<_i10.AiConversation>(data['data']);
    }
    if (dataClassName == 'AiMessage') {
      return deserialize<_i11.AiMessage>(data['data']);
    }
    if (dataClassName == 'AiUsage') {
      return deserialize<_i12.AiUsage>(data['data']);
    }
    if (dataClassName == 'AiUserMemory') {
      return deserialize<_i13.AiUserMemory>(data['data']);
    }
    if (dataClassName == 'Announcement') {
      return deserialize<_i14.Announcement>(data['data']);
    }
    if (dataClassName == 'AnnouncementSummary') {
      return deserialize<_i15.AnnouncementSummary>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_i16.AuditLog>(data['data']);
    }
    if (dataClassName == 'BookAccessDecision') {
      return deserialize<_i17.BookAccessDecision>(data['data']);
    }
    if (dataClassName == 'BookAccessPolicyUpdate') {
      return deserialize<_i18.BookAccessPolicyUpdate>(data['data']);
    }
    if (dataClassName == 'BookAccessType') {
      return deserialize<_i19.BookAccessType>(data['data']);
    }
    if (dataClassName == 'BookCopy') {
      return deserialize<_i20.BookCopy>(data['data']);
    }
    if (dataClassName == 'BookCopyStatus') {
      return deserialize<_i21.BookCopyStatus>(data['data']);
    }
    if (dataClassName == 'BookDetail') {
      return deserialize<_i22.BookDetail>(data['data']);
    }
    if (dataClassName == 'BookFavoriteStatus') {
      return deserialize<_i23.BookFavoriteStatus>(data['data']);
    }
    if (dataClassName == 'BookLoan') {
      return deserialize<_i24.BookLoan>(data['data']);
    }
    if (dataClassName == 'BookLoanPage') {
      return deserialize<_i25.BookLoanPage>(data['data']);
    }
    if (dataClassName == 'BookLoanStatus') {
      return deserialize<_i26.BookLoanStatus>(data['data']);
    }
    if (dataClassName == 'BookLoanSummary') {
      return deserialize<_i27.BookLoanSummary>(data['data']);
    }
    if (dataClassName == 'BookSummary') {
      return deserialize<_i28.BookSummary>(data['data']);
    }
    if (dataClassName == 'BookUploadTicket') {
      return deserialize<_i29.BookUploadTicket>(data['data']);
    }
    if (dataClassName == 'CampusNotification') {
      return deserialize<_i30.CampusNotification>(data['data']);
    }
    if (dataClassName == 'CampusNotificationSummary') {
      return deserialize<_i31.CampusNotificationSummary>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i32.Course>(data['data']);
    }
    if (dataClassName == 'CourseDetail') {
      return deserialize<_i33.CourseDetail>(data['data']);
    }
    if (dataClassName == 'CourseOffering') {
      return deserialize<_i34.CourseOffering>(data['data']);
    }
    if (dataClassName == 'CourseSchedule') {
      return deserialize<_i35.CourseSchedule>(data['data']);
    }
    if (dataClassName == 'CourseSummary') {
      return deserialize<_i36.CourseSummary>(data['data']);
    }
    if (dataClassName == 'CurriculumBlockProgress') {
      return deserialize<_i37.CurriculumBlockProgress>(data['data']);
    }
    if (dataClassName == 'CurriculumProgress') {
      return deserialize<_i38.CurriculumProgress>(data['data']);
    }
    if (dataClassName == 'DashboardAcademicSummary') {
      return deserialize<_i39.DashboardAcademicSummary>(data['data']);
    }
    if (dataClassName == 'DashboardGreeting') {
      return deserialize<_i40.DashboardGreeting>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i41.Enrollment>(data['data']);
    }
    if (dataClassName == 'ExamSchedule') {
      return deserialize<_i42.ExamSchedule>(data['data']);
    }
    if (dataClassName == 'ExamSummary') {
      return deserialize<_i43.ExamSummary>(data['data']);
    }
    if (dataClassName == 'FavoriteBook') {
      return deserialize<_i44.FavoriteBook>(data['data']);
    }
    if (dataClassName == 'GradeComponent') {
      return deserialize<_i45.GradeComponent>(data['data']);
    }
    if (dataClassName == 'GradeComponentScore') {
      return deserialize<_i46.GradeComponentScore>(data['data']);
    }
    if (dataClassName == 'GradeSummary') {
      return deserialize<_i47.GradeSummary>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i48.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeChunk') {
      return deserialize<_i49.KnowledgeChunk>(data['data']);
    }
    if (dataClassName == 'KnowledgeDocument') {
      return deserialize<_i50.KnowledgeDocument>(data['data']);
    }
    if (dataClassName == 'LibraryAuthor') {
      return deserialize<_i51.LibraryAuthor>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i52.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookAuthor') {
      return deserialize<_i53.LibraryBookAuthor>(data['data']);
    }
    if (dataClassName == 'LibraryBookCategory') {
      return deserialize<_i54.LibraryBookCategory>(data['data']);
    }
    if (dataClassName == 'LibraryBookCourse') {
      return deserialize<_i55.LibraryBookCourse>(data['data']);
    }
    if (dataClassName == 'LibraryBookFile') {
      return deserialize<_i56.LibraryBookFile>(data['data']);
    }
    if (dataClassName == 'LibraryCategory') {
      return deserialize<_i57.LibraryCategory>(data['data']);
    }
    if (dataClassName == 'LibraryExplore') {
      return deserialize<_i58.LibraryExplore>(data['data']);
    }
    if (dataClassName == 'LibraryExploreSection') {
      return deserialize<_i59.LibraryExploreSection>(data['data']);
    }
    if (dataClassName == 'LibraryFilterOptions') {
      return deserialize<_i60.LibraryFilterOptions>(data['data']);
    }
    if (dataClassName == 'LibrarySearchPage') {
      return deserialize<_i61.LibrarySearchPage>(data['data']);
    }
    if (dataClassName == 'NotificationListPage') {
      return deserialize<_i62.NotificationListPage>(data['data']);
    }
    if (dataClassName == 'RagCitation') {
      return deserialize<_i63.RagCitation>(data['data']);
    }
    if (dataClassName == 'ReaderAsset') {
      return deserialize<_i64.ReaderAsset>(data['data']);
    }
    if (dataClassName == 'ReaderBookmark') {
      return deserialize<_i65.ReaderBookmark>(data['data']);
    }
    if (dataClassName == 'ReaderHighlight') {
      return deserialize<_i66.ReaderHighlight>(data['data']);
    }
    if (dataClassName == 'ReaderNote') {
      return deserialize<_i67.ReaderNote>(data['data']);
    }
    if (dataClassName == 'ReadingProgress') {
      return deserialize<_i68.ReadingProgress>(data['data']);
    }
    if (dataClassName == 'ReadingProgressSyncResult') {
      return deserialize<_i69.ReadingProgressSyncResult>(data['data']);
    }
    if (dataClassName == 'Semester') {
      return deserialize<_i70.Semester>(data['data']);
    }
    if (dataClassName == 'SemesterSummary') {
      return deserialize<_i71.SemesterSummary>(data['data']);
    }
    if (dataClassName == 'StudentAiPreference') {
      return deserialize<_i72.StudentAiPreference>(data['data']);
    }
    if (dataClassName == 'StudentGrade') {
      return deserialize<_i73.StudentGrade>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_i74.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudySuggestion') {
      return deserialize<_i75.StudySuggestion>(data['data']);
    }
    if (dataClassName == 'TimetableEntry') {
      return deserialize<_i76.TimetableEntry>(data['data']);
    }
    if (dataClassName == 'VectorCapabilityProbe') {
      return deserialize<_i77.VectorCapabilityProbe>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i91.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i92.Protocol().deserializeByClassName(data);
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
      return _i91.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i92.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
