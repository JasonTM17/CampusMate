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
import '../academic/academic_endpoint.dart' as _i2;
import '../admin/admin_endpoint.dart' as _i3;
import '../ai/ai_spike_endpoint.dart' as _i4;
import '../auth/email_idp_endpoint.dart' as _i5;
import '../auth/jwt_refresh_endpoint.dart' as _i6;
import '../dashboard/dashboard_endpoint.dart' as _i7;
import '../endpoints/ai_endpoint.dart' as _i8;
import '../greetings/greeting_endpoint.dart' as _i9;
import '../lending/lending_endpoint.dart' as _i10;
import '../library/library_endpoint.dart' as _i11;
import '../notifications/notification_endpoint.dart' as _i12;
import '../reader/reader_endpoint.dart' as _i13;
import '../student/student_profile_endpoint.dart' as _i14;
import 'package:campusmate_server/src/generated/book_access_type.dart' as _i15;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i16;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i17;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'academic': _i2.AcademicEndpoint()
        ..initialize(
          server,
          'academic',
          null,
        ),
      'courses': _i2.CoursesEndpoint()
        ..initialize(
          server,
          'courses',
          null,
        ),
      'timetable': _i2.TimetableEndpoint()
        ..initialize(
          server,
          'timetable',
          null,
        ),
      'grades': _i2.GradesEndpoint()
        ..initialize(
          server,
          'grades',
          null,
        ),
      'exams': _i2.ExamsEndpoint()
        ..initialize(
          server,
          'exams',
          null,
        ),
      'progress': _i2.ProgressEndpoint()
        ..initialize(
          server,
          'progress',
          null,
        ),
      'admin': _i3.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'aiSpike': _i4.AiSpikeEndpoint()
        ..initialize(
          server,
          'aiSpike',
          null,
        ),
      'emailIdp': _i5.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i6.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'dashboard': _i7.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'ai': _i8.AiEndpoint()
        ..initialize(
          server,
          'ai',
          null,
        ),
      'greeting': _i9.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'lending': _i10.LendingEndpoint()
        ..initialize(
          server,
          'lending',
          null,
        ),
      'library': _i11.LibraryEndpoint()
        ..initialize(
          server,
          'library',
          null,
        ),
      'notification': _i12.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'reader': _i13.ReaderEndpoint()
        ..initialize(
          server,
          'reader',
          null,
        ),
      'studentProfile': _i14.StudentProfileEndpoint()
        ..initialize(
          server,
          'studentProfile',
          null,
        ),
    };
    connectors['academic'] = _i1.EndpointConnector(
      name: 'academic',
      endpoint: endpoints['academic']!,
      methodConnectors: {
        'getOverview': _i1.MethodConnector(
          name: 'getOverview',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['academic'] as _i2.AcademicEndpoint)
                  .getOverview(session),
        ),
      },
    );
    connectors['courses'] = _i1.EndpointConnector(
      name: 'courses',
      endpoint: endpoints['courses']!,
      methodConnectors: {
        'getMyCourses': _i1.MethodConnector(
          name: 'getMyCourses',
          params: {
            'semesterId': _i1.ParameterDescription(
              name: 'semesterId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courses'] as _i2.CoursesEndpoint).getMyCourses(
                    session,
                    semesterId: params['semesterId'],
                  ),
        ),
        'getCourseDetail': _i1.MethodConnector(
          name: 'getCourseDetail',
          params: {
            'offeringId': _i1.ParameterDescription(
              name: 'offeringId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courses'] as _i2.CoursesEndpoint).getCourseDetail(
                    session,
                    offeringId: params['offeringId'],
                  ),
        ),
      },
    );
    connectors['timetable'] = _i1.EndpointConnector(
      name: 'timetable',
      endpoint: endpoints['timetable']!,
      methodConnectors: {
        'getWeekly': _i1.MethodConnector(
          name: 'getWeekly',
          params: {
            'weekStart': _i1.ParameterDescription(
              name: 'weekStart',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'now': _i1.ParameterDescription(
              name: 'now',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timetable'] as _i2.TimetableEndpoint).getWeekly(
                    session,
                    weekStart: params['weekStart'],
                    now: params['now'],
                  ),
        ),
        'getDaily': _i1.MethodConnector(
          name: 'getDaily',
          params: {
            'day': _i1.ParameterDescription(
              name: 'day',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'now': _i1.ParameterDescription(
              name: 'now',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timetable'] as _i2.TimetableEndpoint).getDaily(
                    session,
                    day: params['day'],
                    now: params['now'],
                  ),
        ),
      },
    );
    connectors['grades'] = _i1.EndpointConnector(
      name: 'grades',
      endpoint: endpoints['grades']!,
      methodConnectors: {
        'getBySemester': _i1.MethodConnector(
          name: 'getBySemester',
          params: {
            'semesterId': _i1.ParameterDescription(
              name: 'semesterId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['grades'] as _i2.GradesEndpoint).getBySemester(
                    session,
                    semesterId: params['semesterId'],
                  ),
        ),
        'getCumulative': _i1.MethodConnector(
          name: 'getCumulative',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['grades'] as _i2.GradesEndpoint)
                  .getCumulative(session),
        ),
      },
    );
    connectors['exams'] = _i1.EndpointConnector(
      name: 'exams',
      endpoint: endpoints['exams']!,
      methodConnectors: {
        'getUpcoming': _i1.MethodConnector(
          name: 'getUpcoming',
          params: {
            'now': _i1.ParameterDescription(
              name: 'now',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exams'] as _i2.ExamsEndpoint).getUpcoming(
                session,
                now: params['now'],
              ),
        ),
        'getDetail': _i1.MethodConnector(
          name: 'getDetail',
          params: {
            'examId': _i1.ParameterDescription(
              name: 'examId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'now': _i1.ParameterDescription(
              name: 'now',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exams'] as _i2.ExamsEndpoint).getDetail(
                session,
                examId: params['examId'],
                now: params['now'],
              ),
        ),
      },
    );
    connectors['progress'] = _i1.EndpointConnector(
      name: 'progress',
      endpoint: endpoints['progress']!,
      methodConnectors: {
        'getCurriculumProgress': _i1.MethodConnector(
          name: 'getCurriculumProgress',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['progress'] as _i2.ProgressEndpoint)
                  .getCurriculumProgress(session),
        ),
      },
    );
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'getAccessSummary': _i1.MethodConnector(
          name: 'getAccessSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i3.AdminEndpoint)
                  .getAccessSummary(session),
        ),
      },
    );
    connectors['aiSpike'] = _i1.EndpointConnector(
      name: 'aiSpike',
      endpoint: endpoints['aiSpike']!,
      methodConnectors: {
        'mockStream': _i1.MethodStreamConnector(
          name: 'mockStream',
          params: {
            'prompt': _i1.ParameterDescription(
              name: 'prompt',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['aiSpike'] as _i4.AiSpikeEndpoint).mockStream(
                session,
                params['prompt'],
              ),
        ),
      },
    );
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i6.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['dashboard'] = _i1.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getGreeting': _i1.MethodConnector(
          name: 'getGreeting',
          params: {
            'now': _i1.ParameterDescription(
              name: 'now',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dashboard'] as _i7.DashboardEndpoint).getGreeting(
                    session,
                    now: params['now'],
                  ),
        ),
        'getAcademicSummary': _i1.MethodConnector(
          name: 'getAcademicSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getAcademicSummary(session),
        ),
        'getTodayClasses': _i1.MethodConnector(
          name: 'getTodayClasses',
          params: {
            'now': _i1.ParameterDescription(
              name: 'now',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getTodayClasses(
                    session,
                    now: params['now'],
                  ),
        ),
        'getNextClass': _i1.MethodConnector(
          name: 'getNextClass',
          params: {
            'now': _i1.ParameterDescription(
              name: 'now',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getNextClass(
                    session,
                    now: params['now'],
                  ),
        ),
        'getUpcomingExam': _i1.MethodConnector(
          name: 'getUpcomingExam',
          params: {
            'now': _i1.ParameterDescription(
              name: 'now',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getUpcomingExam(
                    session,
                    now: params['now'],
                  ),
        ),
        'getAnnouncements': _i1.MethodConnector(
          name: 'getAnnouncements',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getAnnouncements(
                    session,
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['ai'] = _i1.EndpointConnector(
      name: 'ai',
      endpoint: endpoints['ai']!,
      methodConnectors: {
        'listConversations': _i1.MethodConnector(
          name: 'listConversations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).listConversations(
                session,
              ),
        ),
        'createConversation': _i1.MethodConnector(
          name: 'createConversation',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).createConversation(
                session,
                title: params['title'],
              ),
        ),
        'deleteConversation': _i1.MethodConnector(
          name: 'deleteConversation',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).deleteConversation(
                session,
                conversationId: params['conversationId'],
              ),
        ),
        'getMessages': _i1.MethodConnector(
          name: 'getMessages',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).getMessages(
                session,
                conversationId: params['conversationId'],
              ),
        ),
        'getPreferences': _i1.MethodConnector(
          name: 'getPreferences',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ai'] as _i8.AiEndpoint).getPreferences(session),
        ),
        'updatePreferences': _i1.MethodConnector(
          name: 'updatePreferences',
          params: {
            'explanationStyle': _i1.ParameterDescription(
              name: 'explanationStyle',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'personalizationEnabled': _i1.ParameterDescription(
              name: 'personalizationEnabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'memoryEnabled': _i1.ParameterDescription(
              name: 'memoryEnabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).updatePreferences(
                session,
                explanationStyle: params['explanationStyle'],
                personalizationEnabled: params['personalizationEnabled'],
                memoryEnabled: params['memoryEnabled'],
              ),
        ),
        'getMemories': _i1.MethodConnector(
          name: 'getMemories',
          params: {
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).getMemories(
                session,
                activeOnly: params['activeOnly'],
              ),
        ),
        'addMemory': _i1.MethodConnector(
          name: 'addMemory',
          params: {
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'source': _i1.ParameterDescription(
              name: 'source',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).addMemory(
                session,
                content: params['content'],
                source: params['source'],
              ),
        ),
        'toggleMemory': _i1.MethodConnector(
          name: 'toggleMemory',
          params: {
            'memoryId': _i1.ParameterDescription(
              name: 'memoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'disabled': _i1.ParameterDescription(
              name: 'disabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).toggleMemory(
                session,
                memoryId: params['memoryId'],
                disabled: params['disabled'],
              ),
        ),
        'deleteMemory': _i1.MethodConnector(
          name: 'deleteMemory',
          params: {
            'memoryId': _i1.ParameterDescription(
              name: 'memoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).deleteMemory(
                session,
                memoryId: params['memoryId'],
              ),
        ),
        'getStudySuggestion': _i1.MethodConnector(
          name: 'getStudySuggestion',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).getStudySuggestion(
                session,
              ),
        ),
        'searchKnowledge': _i1.MethodConnector(
          name: 'searchKnowledge',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i8.AiEndpoint).searchKnowledge(
                session,
                query: params['query'],
                bookId: params['bookId'],
                limit: params['limit'],
              ),
        ),
        'sendMessage': _i1.MethodStreamConnector(
          name: 'sendMessage',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userMessage': _i1.ParameterDescription(
              name: 'userMessage',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'selectedText': _i1.ParameterDescription(
              name: 'selectedText',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['ai'] as _i8.AiEndpoint).sendMessage(
                session,
                conversationId: params['conversationId'],
                userMessage: params['userMessage'],
                bookId: params['bookId'],
                selectedText: params['selectedText'],
              ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i9.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    connectors['lending'] = _i1.EndpointConnector(
      name: 'lending',
      endpoint: endpoints['lending']!,
      methodConnectors: {
        'borrowBook': _i1.MethodConnector(
          name: 'borrowBook',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['lending'] as _i10.LendingEndpoint).borrowBook(
                    session,
                    bookId: params['bookId'],
                  ),
        ),
        'returnLoan': _i1.MethodConnector(
          name: 'returnLoan',
          params: {
            'loanId': _i1.ParameterDescription(
              name: 'loanId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['lending'] as _i10.LendingEndpoint).returnLoan(
                    session,
                    loanId: params['loanId'],
                  ),
        ),
        'myLoans': _i1.MethodConnector(
          name: 'myLoans',
          params: {
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lending'] as _i10.LendingEndpoint).myLoans(
                session,
                cursor: params['cursor'],
                limit: params['limit'],
                activeOnly: params['activeOnly'],
              ),
        ),
        'activeLoansForBook': _i1.MethodConnector(
          name: 'activeLoansForBook',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['lending'] as _i10.LendingEndpoint)
                  .activeLoansForBook(
                    session,
                    bookId: params['bookId'],
                  ),
        ),
      },
    );
    connectors['library'] = _i1.EndpointConnector(
      name: 'library',
      endpoint: endpoints['library']!,
      methodConnectors: {
        'explore': _i1.MethodConnector(
          name: 'explore',
          params: {
            'limitPerSection': _i1.ParameterDescription(
              name: 'limitPerSection',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _i11.LibraryEndpoint).explore(
                session,
                limitPerSection: params['limitPerSection'],
              ),
        ),
        'search': _i1.MethodConnector(
          name: 'search',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'formats': _i1.ParameterDescription(
              name: 'formats',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'languages': _i1.ParameterDescription(
              name: 'languages',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'categories': _i1.ParameterDescription(
              name: 'categories',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'authors': _i1.ParameterDescription(
              name: 'authors',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'years': _i1.ParameterDescription(
              name: 'years',
              type: _i1.getType<List<int>?>(),
              nullable: true,
            ),
            'accessTypes': _i1.ParameterDescription(
              name: 'accessTypes',
              type: _i1.getType<List<_i15.BookAccessType>?>(),
              nullable: true,
            ),
            'relatedToMyCourses': _i1.ParameterDescription(
              name: 'relatedToMyCourses',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _i11.LibraryEndpoint).search(
                session,
                query: params['query'],
                cursor: params['cursor'],
                limit: params['limit'],
                formats: params['formats'],
                languages: params['languages'],
                categories: params['categories'],
                authors: params['authors'],
                years: params['years'],
                accessTypes: params['accessTypes'],
                relatedToMyCourses: params['relatedToMyCourses'],
              ),
        ),
        'getBookDetail': _i1.MethodConnector(
          name: 'getBookDetail',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _i11.LibraryEndpoint).getBookDetail(
                    session,
                    bookId: params['bookId'],
                  ),
        ),
        'toggleFavorite': _i1.MethodConnector(
          name: 'toggleFavorite',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['library'] as _i11.LibraryEndpoint).toggleFavorite(
                    session,
                    bookId: params['bookId'],
                  ),
        ),
        'updateAccessPolicy': _i1.MethodConnector(
          name: 'updateAccessPolicy',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'accessType': _i1.ParameterDescription(
              name: 'accessType',
              type: _i1.getType<_i15.BookAccessType>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['library'] as _i11.LibraryEndpoint)
                  .updateAccessPolicy(
                    session,
                    bookId: params['bookId'],
                    accessType: params['accessType'],
                  ),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i12.NotificationEndpoint).list(
                    session,
                    cursor: params['cursor'],
                    limit: params['limit'],
                    category: params['category'],
                  ),
        ),
        'unreadCount': _i1.MethodConnector(
          name: 'unreadCount',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i12.NotificationEndpoint)
                      .unreadCount(
                        session,
                        category: params['category'],
                      ),
        ),
        'markRead': _i1.MethodConnector(
          name: 'markRead',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i12.NotificationEndpoint)
                      .markRead(
                        session,
                        notificationId: params['notificationId'],
                      ),
        ),
        'markAllRead': _i1.MethodConnector(
          name: 'markAllRead',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i12.NotificationEndpoint)
                      .markAllRead(
                        session,
                        category: params['category'],
                      ),
        ),
      },
    );
    connectors['reader'] = _i1.EndpointConnector(
      name: 'reader',
      endpoint: endpoints['reader']!,
      methodConnectors: {
        'getReaderAsset': _i1.MethodConnector(
          name: 'getReaderAsset',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'format': _i1.ParameterDescription(
              name: 'format',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).getReaderAsset(
                    session,
                    bookId: params['bookId'],
                    format: params['format'],
                  ),
        ),
        'syncProgress': _i1.MethodConnector(
          name: 'syncProgress',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'progressPercent': _i1.ParameterDescription(
              name: 'progressPercent',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'currentLocation': _i1.ParameterDescription(
              name: 'currentLocation',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'clientUpdatedAt': _i1.ParameterDescription(
              name: 'clientUpdatedAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).syncProgress(
                    session,
                    bookId: params['bookId'],
                    progressPercent: params['progressPercent'],
                    currentLocation: params['currentLocation'],
                    clientUpdatedAt: params['clientUpdatedAt'],
                  ),
        ),
        'getProgress': _i1.MethodConnector(
          name: 'getProgress',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).getProgress(
                    session,
                    bookId: params['bookId'],
                  ),
        ),
        'getBookmarks': _i1.MethodConnector(
          name: 'getBookmarks',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).getBookmarks(
                    session,
                    bookId: params['bookId'],
                  ),
        ),
        'addBookmark': _i1.MethodConnector(
          name: 'addBookmark',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).addBookmark(
                    session,
                    bookId: params['bookId'],
                    location: params['location'],
                    title: params['title'],
                  ),
        ),
        'removeBookmark': _i1.MethodConnector(
          name: 'removeBookmark',
          params: {
            'bookmarkId': _i1.ParameterDescription(
              name: 'bookmarkId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).removeBookmark(
                    session,
                    bookmarkId: params['bookmarkId'],
                  ),
        ),
        'getNotes': _i1.MethodConnector(
          name: 'getNotes',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['reader'] as _i13.ReaderEndpoint).getNotes(
                session,
                bookId: params['bookId'],
              ),
        ),
        'saveNote': _i1.MethodConnector(
          name: 'saveNote',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'noteId': _i1.ParameterDescription(
              name: 'noteId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['reader'] as _i13.ReaderEndpoint).saveNote(
                session,
                bookId: params['bookId'],
                location: params['location'],
                content: params['content'],
                noteId: params['noteId'],
              ),
        ),
        'deleteNote': _i1.MethodConnector(
          name: 'deleteNote',
          params: {
            'noteId': _i1.ParameterDescription(
              name: 'noteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).deleteNote(
                    session,
                    noteId: params['noteId'],
                  ),
        ),
        'getHighlights': _i1.MethodConnector(
          name: 'getHighlights',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).getHighlights(
                    session,
                    bookId: params['bookId'],
                  ),
        ),
        'addHighlight': _i1.MethodConnector(
          name: 'addHighlight',
          params: {
            'bookId': _i1.ParameterDescription(
              name: 'bookId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'colorToken': _i1.ParameterDescription(
              name: 'colorToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).addHighlight(
                    session,
                    bookId: params['bookId'],
                    location: params['location'],
                    text: params['text'],
                    colorToken: params['colorToken'],
                  ),
        ),
        'removeHighlight': _i1.MethodConnector(
          name: 'removeHighlight',
          params: {
            'highlightId': _i1.ParameterDescription(
              name: 'highlightId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reader'] as _i13.ReaderEndpoint).removeHighlight(
                    session,
                    highlightId: params['highlightId'],
                  ),
        ),
      },
    );
    connectors['studentProfile'] = _i1.EndpointConnector(
      name: 'studentProfile',
      endpoint: endpoints['studentProfile']!,
      methodConnectors: {
        'getMyProfile': _i1.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studentProfile'] as _i14.StudentProfileEndpoint)
                      .getMyProfile(session),
        ),
        'updateMyProfile': _i1.MethodConnector(
          name: 'updateMyProfile',
          params: {
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'className': _i1.ParameterDescription(
              name: 'className',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studentProfile'] as _i14.StudentProfileEndpoint)
                      .updateMyProfile(
                        session,
                        fullName: params['fullName'],
                        className: params['className'],
                      ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i16.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i17.Endpoints()
      ..initializeEndpoints(server);
  }
}
