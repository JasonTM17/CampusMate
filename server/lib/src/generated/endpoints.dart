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
import '../notifications/notification_endpoint.dart' as _i10;
import '../student/student_profile_endpoint.dart' as _i11;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i12;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i13;

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
      'notification': _i10.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'studentProfile': _i11.StudentProfileEndpoint()
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
                  (endpoints['notification'] as _i10.NotificationEndpoint).list(
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
                  (endpoints['notification'] as _i10.NotificationEndpoint)
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
                  (endpoints['notification'] as _i10.NotificationEndpoint)
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
                  (endpoints['notification'] as _i10.NotificationEndpoint)
                      .markAllRead(
                        session,
                        category: params['category'],
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
                  (endpoints['studentProfile'] as _i11.StudentProfileEndpoint)
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
                  (endpoints['studentProfile'] as _i11.StudentProfileEndpoint)
                      .updateMyProfile(
                        session,
                        fullName: params['fullName'],
                        className: params['className'],
                      ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i12.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i13.Endpoints()
      ..initializeEndpoints(server);
  }
}
