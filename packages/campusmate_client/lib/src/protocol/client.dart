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
import 'dart:async' as _i2;
import 'package:campusmate_client/src/protocol/academic_overview.dart' as _i3;
import 'package:campusmate_client/src/protocol/course_summary.dart' as _i4;
import 'package:campusmate_client/src/protocol/course_detail.dart' as _i5;
import 'package:campusmate_client/src/protocol/timetable_entry.dart' as _i6;
import 'package:campusmate_client/src/protocol/grade_summary.dart' as _i7;
import 'package:campusmate_client/src/protocol/exam_summary.dart' as _i8;
import 'package:campusmate_client/src/protocol/curriculum_progress.dart' as _i9;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i10;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i11;
import 'package:campusmate_client/src/protocol/dashboard_greeting.dart' as _i12;
import 'package:campusmate_client/src/protocol/dashboard_academic_summary.dart'
    as _i13;
import 'package:campusmate_client/src/protocol/announcement_summary.dart'
    as _i14;
import 'package:campusmate_client/src/protocol/ai_conversations.dart' as _i15;
import 'package:campusmate_client/src/protocol/ai_messages.dart' as _i16;
import 'package:campusmate_client/src/protocol/student_ai_preference.dart'
    as _i17;
import 'package:campusmate_client/src/protocol/ai_user_memory.dart' as _i18;
import 'package:campusmate_client/src/protocol/study_suggestion.dart' as _i19;
import 'package:campusmate_client/src/protocol/rag_citation.dart' as _i20;
import 'package:campusmate_client/src/protocol/greetings/greeting.dart' as _i21;
import 'package:campusmate_client/src/protocol/book_loan_summary.dart' as _i22;
import 'package:campusmate_client/src/protocol/book_loan_page.dart' as _i23;
import 'package:campusmate_client/src/protocol/library_explore.dart' as _i24;
import 'package:campusmate_client/src/protocol/library_search_page.dart'
    as _i25;
import 'package:campusmate_client/src/protocol/book_access_type.dart' as _i26;
import 'package:campusmate_client/src/protocol/book_detail.dart' as _i27;
import 'package:campusmate_client/src/protocol/book_favorite_status.dart'
    as _i28;
import 'package:campusmate_client/src/protocol/book_access_policy_update.dart'
    as _i29;
import 'package:campusmate_client/src/protocol/notification_list_page.dart'
    as _i30;
import 'package:campusmate_client/src/protocol/campus_notification_summary.dart'
    as _i31;
import 'package:campusmate_client/src/protocol/reader_asset.dart' as _i32;
import 'package:campusmate_client/src/protocol/reading_progress_sync_result.dart'
    as _i33;
import 'package:campusmate_client/src/protocol/reading_progress.dart' as _i34;
import 'package:campusmate_client/src/protocol/reader_bookmark.dart' as _i35;
import 'package:campusmate_client/src/protocol/reader_note.dart' as _i36;
import 'package:campusmate_client/src/protocol/reader_highlight.dart' as _i37;
import 'package:campusmate_client/src/protocol/student_profile.dart' as _i38;
import 'protocol.dart' as _i39;

/// {@category Endpoint}
class EndpointAcademic extends _i1.EndpointRef {
  EndpointAcademic(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'academic';

  _i2.Future<_i3.AcademicOverview> getOverview() =>
      caller.callServerEndpoint<_i3.AcademicOverview>(
        'academic',
        'getOverview',
        {},
      );
}

/// {@category Endpoint}
class EndpointCourses extends _i1.EndpointRef {
  EndpointCourses(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'courses';

  _i2.Future<List<_i4.CourseSummary>> getMyCourses({int? semesterId}) =>
      caller.callServerEndpoint<List<_i4.CourseSummary>>(
        'courses',
        'getMyCourses',
        {'semesterId': semesterId},
      );

  _i2.Future<_i5.CourseDetail> getCourseDetail({required int offeringId}) =>
      caller.callServerEndpoint<_i5.CourseDetail>(
        'courses',
        'getCourseDetail',
        {'offeringId': offeringId},
      );
}

/// {@category Endpoint}
class EndpointTimetable extends _i1.EndpointRef {
  EndpointTimetable(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'timetable';

  _i2.Future<List<_i6.TimetableEntry>> getWeekly({
    DateTime? weekStart,
    DateTime? now,
  }) => caller.callServerEndpoint<List<_i6.TimetableEntry>>(
    'timetable',
    'getWeekly',
    {
      'weekStart': weekStart,
      'now': now,
    },
  );

  _i2.Future<List<_i6.TimetableEntry>> getDaily({
    DateTime? day,
    DateTime? now,
  }) => caller.callServerEndpoint<List<_i6.TimetableEntry>>(
    'timetable',
    'getDaily',
    {
      'day': day,
      'now': now,
    },
  );
}

/// {@category Endpoint}
class EndpointGrades extends _i1.EndpointRef {
  EndpointGrades(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'grades';

  _i2.Future<_i7.GradeSummary> getBySemester({int? semesterId}) =>
      caller.callServerEndpoint<_i7.GradeSummary>(
        'grades',
        'getBySemester',
        {'semesterId': semesterId},
      );

  _i2.Future<_i7.GradeSummary> getCumulative() =>
      caller.callServerEndpoint<_i7.GradeSummary>(
        'grades',
        'getCumulative',
        {},
      );
}

/// {@category Endpoint}
class EndpointExams extends _i1.EndpointRef {
  EndpointExams(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'exams';

  _i2.Future<List<_i8.ExamSummary>> getUpcoming({DateTime? now}) =>
      caller.callServerEndpoint<List<_i8.ExamSummary>>(
        'exams',
        'getUpcoming',
        {'now': now},
      );

  _i2.Future<_i8.ExamSummary> getDetail({
    required int examId,
    DateTime? now,
  }) => caller.callServerEndpoint<_i8.ExamSummary>(
    'exams',
    'getDetail',
    {
      'examId': examId,
      'now': now,
    },
  );
}

/// {@category Endpoint}
class EndpointProgress extends _i1.EndpointRef {
  EndpointProgress(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'progress';

  _i2.Future<_i9.CurriculumProgress> getCurriculumProgress() =>
      caller.callServerEndpoint<_i9.CurriculumProgress>(
        'progress',
        'getCurriculumProgress',
        {},
      );
}

/// Small protected surface used by phase-02 to prove role isolation.
///
/// The real admin feature is delivered in phase-11; keeping this endpoint
/// narrow gives the auth phase a concrete server-side 403 contract now.
/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<String> getAccessSummary() => caller.callServerEndpoint<String>(
    'admin',
    'getAccessSummary',
    {},
  );
}

/// Temporary streaming spike endpoint (phase-08 step 1).
///
/// Proves the Serverpod WebSocket streaming pattern end-to-end — mock token
/// generator on the server, `Stream<String>` on the Flutter client — before
/// the real chat architecture is committed (ADR-008). This endpoint is
/// replaced by the real `AiEndpoint` once the pattern is validated and is
/// removed before phase-08 exits.
/// {@category Endpoint}
class EndpointAiSpike extends _i1.EndpointRef {
  EndpointAiSpike(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'aiSpike';

  /// Streams a mock Vietnamese assistant reply back token-by-token, echoing
  /// the caller's [prompt] so the client can verify round-trip streaming.
  _i2.Stream<String> mockStream(String prompt) =>
      caller.callStreamingServerEndpoint<_i2.Stream<String>, String>(
        'aiSpike',
        'mockStream',
        {'prompt': prompt},
        {},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i10.EndpointEmailIdpBase {
  EndpointEmailIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<_i11.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i11.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i2.Future<_i1.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i2.Future<String> verifyRegistrationCode({
    required _i1.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i2.Future<_i11.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i11.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i2.Future<_i1.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i2.Future<String> verifyPasswordResetCode({
    required _i1.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i11.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i2.Future<_i11.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i11.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointDashboard extends _i1.EndpointRef {
  EndpointDashboard(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  _i2.Future<_i12.DashboardGreeting> getGreeting({DateTime? now}) =>
      caller.callServerEndpoint<_i12.DashboardGreeting>(
        'dashboard',
        'getGreeting',
        {'now': now},
      );

  _i2.Future<_i13.DashboardAcademicSummary> getAcademicSummary() =>
      caller.callServerEndpoint<_i13.DashboardAcademicSummary>(
        'dashboard',
        'getAcademicSummary',
        {},
      );

  _i2.Future<List<_i6.TimetableEntry>> getTodayClasses({DateTime? now}) =>
      caller.callServerEndpoint<List<_i6.TimetableEntry>>(
        'dashboard',
        'getTodayClasses',
        {'now': now},
      );

  _i2.Future<_i6.TimetableEntry?> getNextClass({DateTime? now}) =>
      caller.callServerEndpoint<_i6.TimetableEntry?>(
        'dashboard',
        'getNextClass',
        {'now': now},
      );

  _i2.Future<_i8.ExamSummary?> getUpcomingExam({DateTime? now}) =>
      caller.callServerEndpoint<_i8.ExamSummary?>(
        'dashboard',
        'getUpcomingExam',
        {'now': now},
      );

  _i2.Future<List<_i14.AnnouncementSummary>> getAnnouncements({
    required int limit,
  }) => caller.callServerEndpoint<List<_i14.AnnouncementSummary>>(
    'dashboard',
    'getAnnouncements',
    {'limit': limit},
  );
}

/// AI assistant endpoints (phase-08 & phase-09): conversation lifecycle,
/// message history, streaming chat with personalized student context,
/// AI user memories, student AI preferences, and study suggestions.
///
/// Authorization rule (§31): every read/write is scoped to the authenticated
/// user via `session.authenticated.userIdentifier`. A request can never read
/// or write another user's conversation — the `userId` predicate is in every
/// query, so tenant isolation holds even if a client forges an id.
/// {@category Endpoint}
class EndpointAi extends _i1.EndpointRef {
  EndpointAi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ai';

  /// Loads the user's conversations, newest first.
  _i2.Future<List<_i15.AiConversation>> listConversations() =>
      caller.callServerEndpoint<List<_i15.AiConversation>>(
        'ai',
        'listConversations',
        {},
      );

  /// Creates a new empty conversation owned by the caller.
  _i2.Future<_i15.AiConversation> createConversation({required String title}) =>
      caller.callServerEndpoint<_i15.AiConversation>(
        'ai',
        'createConversation',
        {'title': title},
      );

  /// Deletes one of the caller's conversations (messages cascade).
  _i2.Future<void> deleteConversation({required int conversationId}) =>
      caller.callServerEndpoint<void>(
        'ai',
        'deleteConversation',
        {'conversationId': conversationId},
      );

  /// Returns the caller's messages for a conversation, oldest first.
  _i2.Future<List<_i16.AiMessage>> getMessages({required int conversationId}) =>
      caller.callServerEndpoint<List<_i16.AiMessage>>(
        'ai',
        'getMessages',
        {'conversationId': conversationId},
      );

  /// Streams an assistant reply to [userMessage] within [conversationId].
  ///
  /// In Phase 09, builds personalized context via [StudentContextBuilder]
  /// incorporating academic schedules, upcoming exams, active loans, and
  /// user memories, while obeying least-data budgeting and privacy controls.
  _i2.Stream<String> sendMessage({
    required int conversationId,
    required String userMessage,
    int? bookId,
    String? selectedText,
  }) => caller.callStreamingServerEndpoint<_i2.Stream<String>, String>(
    'ai',
    'sendMessage',
    {
      'conversationId': conversationId,
      'userMessage': userMessage,
      'bookId': bookId,
      'selectedText': selectedText,
    },
    {},
  );

  /// Gets the caller's AI preferences (creates default if not set).
  _i2.Future<_i17.StudentAiPreference> getPreferences() =>
      caller.callServerEndpoint<_i17.StudentAiPreference>(
        'ai',
        'getPreferences',
        {},
      );

  /// Updates the caller's AI preferences.
  _i2.Future<_i17.StudentAiPreference> updatePreferences({
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) => caller.callServerEndpoint<_i17.StudentAiPreference>(
    'ai',
    'updatePreferences',
    {
      'explanationStyle': explanationStyle,
      'personalizationEnabled': personalizationEnabled,
      'memoryEnabled': memoryEnabled,
    },
  );

  /// Lists the caller's AI memories.
  _i2.Future<List<_i18.AiUserMemory>> getMemories({required bool activeOnly}) =>
      caller.callServerEndpoint<List<_i18.AiUserMemory>>(
        'ai',
        'getMemories',
        {'activeOnly': activeOnly},
      );

  /// Adds a new personal memory for the caller.
  _i2.Future<_i18.AiUserMemory> addMemory({
    required String content,
    String? source,
  }) => caller.callServerEndpoint<_i18.AiUserMemory>(
    'ai',
    'addMemory',
    {
      'content': content,
      'source': source,
    },
  );

  /// Enables or disables a specific memory.
  _i2.Future<_i18.AiUserMemory> toggleMemory({
    required int memoryId,
    required bool disabled,
  }) => caller.callServerEndpoint<_i18.AiUserMemory>(
    'ai',
    'toggleMemory',
    {
      'memoryId': memoryId,
      'disabled': disabled,
    },
  );

  /// Permanently deletes a specific memory.
  _i2.Future<void> deleteMemory({required int memoryId}) =>
      caller.callServerEndpoint<void>(
        'ai',
        'deleteMemory',
        {'memoryId': memoryId},
      );

  /// Returns a personalized study suggestion for the dashboard card.
  _i2.Future<_i19.StudySuggestion?> getStudySuggestion() =>
      caller.callServerEndpoint<_i19.StudySuggestion?>(
        'ai',
        'getStudySuggestion',
        {},
      );

  /// Searches authorized knowledge base documents using vector similarity.
  /// (Kongming C7: DB-level authorization filter).
  _i2.Future<List<_i20.RagCitation>> searchKnowledge({
    required String query,
    int? bookId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i20.RagCitation>>(
    'ai',
    'searchKnowledge',
    {
      'query': query,
      'bookId': bookId,
      'limit': limit,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i21.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i21.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointLending extends _i1.EndpointRef {
  EndpointLending(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'lending';

  _i2.Future<_i22.BookLoanSummary> borrowBook({required int bookId}) =>
      caller.callServerEndpoint<_i22.BookLoanSummary>(
        'lending',
        'borrowBook',
        {'bookId': bookId},
      );

  _i2.Future<_i22.BookLoanSummary> returnLoan({required int loanId}) =>
      caller.callServerEndpoint<_i22.BookLoanSummary>(
        'lending',
        'returnLoan',
        {'loanId': loanId},
      );

  _i2.Future<_i23.BookLoanPage> myLoans({
    String? cursor,
    required int limit,
    required bool activeOnly,
  }) => caller.callServerEndpoint<_i23.BookLoanPage>(
    'lending',
    'myLoans',
    {
      'cursor': cursor,
      'limit': limit,
      'activeOnly': activeOnly,
    },
  );

  _i2.Future<List<_i22.BookLoanSummary>> activeLoansForBook({
    required int bookId,
  }) => caller.callServerEndpoint<List<_i22.BookLoanSummary>>(
    'lending',
    'activeLoansForBook',
    {'bookId': bookId},
  );
}

/// {@category Endpoint}
class EndpointLibrary extends _i1.EndpointRef {
  EndpointLibrary(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'library';

  _i2.Future<_i24.LibraryExplore> explore({required int limitPerSection}) =>
      caller.callServerEndpoint<_i24.LibraryExplore>(
        'library',
        'explore',
        {'limitPerSection': limitPerSection},
      );

  _i2.Future<_i25.LibrarySearchPage> search({
    String? query,
    String? cursor,
    required int limit,
    List<String>? formats,
    List<String>? languages,
    List<String>? categories,
    List<String>? authors,
    List<int>? years,
    List<_i26.BookAccessType>? accessTypes,
    required bool relatedToMyCourses,
  }) => caller.callServerEndpoint<_i25.LibrarySearchPage>(
    'library',
    'search',
    {
      'query': query,
      'cursor': cursor,
      'limit': limit,
      'formats': formats,
      'languages': languages,
      'categories': categories,
      'authors': authors,
      'years': years,
      'accessTypes': accessTypes,
      'relatedToMyCourses': relatedToMyCourses,
    },
  );

  _i2.Future<_i27.BookDetail> getBookDetail({required int bookId}) =>
      caller.callServerEndpoint<_i27.BookDetail>(
        'library',
        'getBookDetail',
        {'bookId': bookId},
      );

  _i2.Future<_i28.BookFavoriteStatus> toggleFavorite({required int bookId}) =>
      caller.callServerEndpoint<_i28.BookFavoriteStatus>(
        'library',
        'toggleFavorite',
        {'bookId': bookId},
      );

  _i2.Future<_i29.BookAccessPolicyUpdate> updateAccessPolicy({
    required int bookId,
    required _i26.BookAccessType accessType,
  }) => caller.callServerEndpoint<_i29.BookAccessPolicyUpdate>(
    'library',
    'updateAccessPolicy',
    {
      'bookId': bookId,
      'accessType': accessType,
    },
  );
}

/// {@category Endpoint}
class EndpointNotification extends _i1.EndpointRef {
  EndpointNotification(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _i2.Future<_i30.NotificationListPage> list({
    String? cursor,
    required int limit,
    String? category,
  }) => caller.callServerEndpoint<_i30.NotificationListPage>(
    'notification',
    'list',
    {
      'cursor': cursor,
      'limit': limit,
      'category': category,
    },
  );

  _i2.Future<int> unreadCount({String? category}) =>
      caller.callServerEndpoint<int>(
        'notification',
        'unreadCount',
        {'category': category},
      );

  _i2.Future<_i31.CampusNotificationSummary> markRead({
    required int notificationId,
  }) => caller.callServerEndpoint<_i31.CampusNotificationSummary>(
    'notification',
    'markRead',
    {'notificationId': notificationId},
  );

  _i2.Future<int> markAllRead({String? category}) =>
      caller.callServerEndpoint<int>(
        'notification',
        'markAllRead',
        {'category': category},
      );
}

/// {@category Endpoint}
class EndpointReader extends _i1.EndpointRef {
  EndpointReader(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reader';

  _i2.Future<_i32.ReaderAsset> getReaderAsset({
    required int bookId,
    required String format,
  }) => caller.callServerEndpoint<_i32.ReaderAsset>(
    'reader',
    'getReaderAsset',
    {
      'bookId': bookId,
      'format': format,
    },
  );

  _i2.Future<_i33.ReadingProgressSyncResult> syncProgress({
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime clientUpdatedAt,
  }) => caller.callServerEndpoint<_i33.ReadingProgressSyncResult>(
    'reader',
    'syncProgress',
    {
      'bookId': bookId,
      'progressPercent': progressPercent,
      'currentLocation': currentLocation,
      'clientUpdatedAt': clientUpdatedAt,
    },
  );

  _i2.Future<_i34.ReadingProgress?> getProgress({required int bookId}) =>
      caller.callServerEndpoint<_i34.ReadingProgress?>(
        'reader',
        'getProgress',
        {'bookId': bookId},
      );

  _i2.Future<List<_i35.ReaderBookmark>> getBookmarks({required int bookId}) =>
      caller.callServerEndpoint<List<_i35.ReaderBookmark>>(
        'reader',
        'getBookmarks',
        {'bookId': bookId},
      );

  _i2.Future<_i35.ReaderBookmark> addBookmark({
    required int bookId,
    required String location,
    required String title,
  }) => caller.callServerEndpoint<_i35.ReaderBookmark>(
    'reader',
    'addBookmark',
    {
      'bookId': bookId,
      'location': location,
      'title': title,
    },
  );

  _i2.Future<void> removeBookmark({required int bookmarkId}) =>
      caller.callServerEndpoint<void>(
        'reader',
        'removeBookmark',
        {'bookmarkId': bookmarkId},
      );

  _i2.Future<List<_i36.ReaderNote>> getNotes({required int bookId}) =>
      caller.callServerEndpoint<List<_i36.ReaderNote>>(
        'reader',
        'getNotes',
        {'bookId': bookId},
      );

  _i2.Future<_i36.ReaderNote> saveNote({
    required int bookId,
    required String location,
    required String content,
    int? noteId,
  }) => caller.callServerEndpoint<_i36.ReaderNote>(
    'reader',
    'saveNote',
    {
      'bookId': bookId,
      'location': location,
      'content': content,
      'noteId': noteId,
    },
  );

  _i2.Future<void> deleteNote({required int noteId}) =>
      caller.callServerEndpoint<void>(
        'reader',
        'deleteNote',
        {'noteId': noteId},
      );

  _i2.Future<List<_i37.ReaderHighlight>> getHighlights({required int bookId}) =>
      caller.callServerEndpoint<List<_i37.ReaderHighlight>>(
        'reader',
        'getHighlights',
        {'bookId': bookId},
      );

  _i2.Future<_i37.ReaderHighlight> addHighlight({
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
  }) => caller.callServerEndpoint<_i37.ReaderHighlight>(
    'reader',
    'addHighlight',
    {
      'bookId': bookId,
      'location': location,
      'text': text,
      'colorToken': colorToken,
    },
  );

  _i2.Future<void> removeHighlight({required int highlightId}) =>
      caller.callServerEndpoint<void>(
        'reader',
        'removeHighlight',
        {'highlightId': highlightId},
      );
}

/// Authenticated student profile operations.
///
/// The endpoint deliberately exposes no user-id parameter. The authenticated
/// session is the only source of ownership for reads and writes.
/// {@category Endpoint}
class EndpointStudentProfile extends _i1.EndpointRef {
  EndpointStudentProfile(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studentProfile';

  _i2.Future<_i38.StudentProfile> getMyProfile() =>
      caller.callServerEndpoint<_i38.StudentProfile>(
        'studentProfile',
        'getMyProfile',
        {},
      );

  /// Updates the fields that a student may edit themselves.
  ///
  /// Student code, academic results, faculty and major remain server-managed
  /// so client input cannot rewrite institutional data.
  _i2.Future<_i38.StudentProfile> updateMyProfile({
    required String fullName,
    required String className,
  }) => caller.callServerEndpoint<_i38.StudentProfile>(
    'studentProfile',
    'updateMyProfile',
    {
      'fullName': fullName,
      'className': className,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i10.Caller(client);
    serverpod_auth_core = _i11.Caller(client);
  }

  late final _i10.Caller serverpod_auth_idp;

  late final _i11.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i39.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    academic = EndpointAcademic(this);
    courses = EndpointCourses(this);
    timetable = EndpointTimetable(this);
    grades = EndpointGrades(this);
    exams = EndpointExams(this);
    progress = EndpointProgress(this);
    admin = EndpointAdmin(this);
    aiSpike = EndpointAiSpike(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    dashboard = EndpointDashboard(this);
    ai = EndpointAi(this);
    greeting = EndpointGreeting(this);
    lending = EndpointLending(this);
    library = EndpointLibrary(this);
    notification = EndpointNotification(this);
    reader = EndpointReader(this);
    studentProfile = EndpointStudentProfile(this);
    modules = Modules(this);
  }

  late final EndpointAcademic academic;

  late final EndpointCourses courses;

  late final EndpointTimetable timetable;

  late final EndpointGrades grades;

  late final EndpointExams exams;

  late final EndpointProgress progress;

  late final EndpointAdmin admin;

  late final EndpointAiSpike aiSpike;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointDashboard dashboard;

  late final EndpointAi ai;

  late final EndpointGreeting greeting;

  late final EndpointLending lending;

  late final EndpointLibrary library;

  late final EndpointNotification notification;

  late final EndpointReader reader;

  late final EndpointStudentProfile studentProfile;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'academic': academic,
    'courses': courses,
    'timetable': timetable,
    'grades': grades,
    'exams': exams,
    'progress': progress,
    'admin': admin,
    'aiSpike': aiSpike,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'dashboard': dashboard,
    'ai': ai,
    'greeting': greeting,
    'lending': lending,
    'library': library,
    'notification': notification,
    'reader': reader,
    'studentProfile': studentProfile,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
