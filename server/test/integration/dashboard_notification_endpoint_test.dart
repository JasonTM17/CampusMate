@Timeout(Duration(minutes: 2))
library;

import 'package:campusmate_server/src/academic/academic_demo_seed.dart';
import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/dashboard/dashboard_demo_seed.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _userAId = '00000000-0000-4000-8000-000000000201';
const _userBId = '00000000-0000-4000-8000-000000000202';

void main() {
  withServerpod(
    'Given dashboard and notification endpoints',
    (sessionBuilder, endpoints) {
      final userA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _userAId,
          {campusMateStudentScope},
        ),
      );
      final userB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _userBId,
          {campusMateStudentScope},
        ),
      );
      final authenticatedWithoutStudentScope = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _userAId,
          const {},
        ),
      );

      test(
        'rejects unauthenticated and non-student dashboard access',
        () async {
          await expectLater(
            endpoints.dashboard.getGreeting(sessionBuilder),
            throwsA(isA<ServerpodUnauthenticatedException>()),
          );
          await expectLater(
            endpoints.dashboard.getGreeting(authenticatedWithoutStudentScope),
            throwsA(isA<ServerpodInsufficientAccessException>()),
          );
        },
      );

      test(
        'returns independent dashboard sections from academic data',
        () async {
          await _preparePhase04Seed(sessionBuilder, endpoints, userA, userB);

          final greeting = await endpoints.dashboard.getGreeting(
            userA,
            now: DateTime.utc(2026, 9, 8, 2),
          );
          final summary = await endpoints.dashboard.getAcademicSummary(userA);
          final today = await endpoints.dashboard.getTodayClasses(
            userA,
            now: DateTime.utc(2026, 9, 8, 1),
          );
          final nextClass = await endpoints.dashboard.getNextClass(
            userA,
            now: DateTime.utc(2026, 9, 8, 1),
          );
          final upcomingExam = await endpoints.dashboard.getUpcomingExam(
            userA,
            now: DateTime.utc(2026, 9, 8),
          );

          expect(greeting.message, contains('Nguyen Van A'));
          expect(summary.semesterName, 'Học kỳ 1 2026');
          expect(summary.activeCourses, 5);
          expect(summary.semesterCredits, greaterThan(0));
          expect(summary.creditsEarned, greaterThan(0));
          expect(today, hasLength(2));
          expect(nextClass, isNotNull);
          expect(upcomingExam, isNotNull);
          expect(upcomingExam!.daysUntil, greaterThanOrEqualTo(0));
        },
      );

      test(
        'filters announcements by audience, publish window, and archive',
        () async {
          await _preparePhase04Seed(sessionBuilder, endpoints, userA, userB);
          final session = sessionBuilder.build();
          final now = CampusClock.nowUtc();
          await Announcement.db.insertRow(
            session,
            Announcement(
              title: 'Future private announcement',
              body: 'This row must not be visible before publishAt.',
              audience: 'student',
              publishAt: now.add(const Duration(days: 1)),
              expiresAt: null,
              archived: false,
              createdAt: now,
              updatedAt: now,
            ),
          );

          final announcements = await endpoints.dashboard.getAnnouncements(
            userA,
            limit: 10,
          );

          expect(announcements, isNotEmpty);
          expect(
            announcements.map((row) => row.title),
            containsAll([
              'Khai giảng học kỳ 1',
              'Mở đăng ký thư viện số',
              'Bảo trì hệ thống học vụ',
            ]),
          );
          expect(
            announcements.map((row) => row.title),
            isNot(
              containsAll([
                'Thông báo cũ đã hết hạn',
                'Bản nháp lưu trữ',
                'Future private announcement',
              ]),
            ),
          );
        },
      );

      test(
        'seeds notifications idempotently with all six categories',
        () async {
          await _preparePhase04Seed(sessionBuilder, endpoints, userA, userB);

          final session = sessionBuilder.build();
          await seedDashboardNotificationDemoData(session);

          final rows = await CampusNotification.db.find(
            session,
            where: (t) => t.userId.equals(UuidValue.withValidation(_userAId)),
          );

          expect(rows, hasLength(6));
          expect(rows.map((row) => row.category).toSet(), {
            'academic',
            'library',
            'system',
            'ai',
            'course',
            'exam',
          });
          expect(rows.where((row) => row.targetType == 'exam'), hasLength(1));
        },
      );

      test('uses keyset cursor pagination without leaking filters', () async {
        await _preparePhase04Seed(sessionBuilder, endpoints, userA, userB);
        final session = sessionBuilder.build();
        final profileA = await _profileFor(session, _userAId);
        final tiedAt = DateTime.utc(2030, 1, 1, 7);

        for (var i = 0; i < 4; i++) {
          await CampusNotification.db.insertRow(
            session,
            CampusNotification(
              userId: profileA.authUserId,
              category: 'system',
              title: 'Cursor $i',
              body: 'Cursor body $i',
              targetType: null,
              targetId: null,
              readAt: null,
              createdAt: tiedAt,
            ),
          );
        }

        final firstPage = await endpoints.notification.list(
          userA,
          limit: 2,
          category: 'system',
        );
        final secondPage = await endpoints.notification.list(
          userA,
          cursor: firstPage.nextCursor,
          limit: 2,
          category: 'system',
        );

        expect(firstPage.items, hasLength(2));
        expect(secondPage.items, hasLength(2));
        expect(firstPage.nextCursor, isNotNull);
        expect(
          firstPage.items
              .map((row) => row.id)
              .toSet()
              .intersection(
                secondPage.items.map((row) => row.id).toSet(),
              ),
          isEmpty,
        );
        expect(firstPage.items.first.createdAt, tiedAt);

        await expectLater(
          endpoints.notification.list(
            userA,
            cursor: firstPage.nextCursor,
            limit: 2,
            category: 'exam',
          ),
          throwsA(
            isA<ServerpodClientException>().having(
              (error) => error.statusCode,
              'statusCode',
              400,
            ),
          ),
        );
      });

      test(
        'marks read and mark-all stay scoped to the authenticated user',
        () async {
          await _preparePhase04Seed(sessionBuilder, endpoints, userA, userB);

          final aPage = await endpoints.notification.list(userA, limit: 20);
          final bPage = await endpoints.notification.list(userB, limit: 20);
          final aFirst = aPage.items.first;
          final bFirst = bPage.items.first;

          final updated = await endpoints.notification.markRead(
            userA,
            notificationId: aFirst.id,
          );
          expect(updated.readAt, isNotNull);
          expect(await endpoints.notification.unreadCount(userA), 5);

          await expectLater(
            endpoints.notification.markRead(userA, notificationId: bFirst.id),
            throwsA(
              isA<ServerpodClientException>().having(
                (error) => error.statusCode,
                'statusCode',
                404,
              ),
            ),
          );

          final changed = await endpoints.notification.markAllRead(
            userA,
            category: 'exam',
          );
          expect(changed, 1);
          expect(
            await endpoints.notification.unreadCount(userA, category: 'exam'),
            0,
          );
          expect(await endpoints.notification.unreadCount(userB), 6);
        },
      );

      test('opens only the caller owned exam detail', () async {
        await _preparePhase04Seed(sessionBuilder, endpoints, userA, userB);

        final aExam = await endpoints.dashboard.getUpcomingExam(
          userA,
          now: DateTime.utc(2026, 9, 8),
        );
        final aExamIds = (await endpoints.exams.getUpcoming(
          userA,
          now: DateTime.utc(2026, 9, 8),
        )).map((row) => row.examId).toSet();
        final bExams = await endpoints.exams.getUpcoming(
          userB,
          now: DateTime.utc(2026, 9, 8),
        );
        final foreignExam = bExams.firstWhere(
          (row) => !aExamIds.contains(row.examId),
        );

        final detail = await endpoints.exams.getDetail(
          userA,
          examId: aExam!.examId,
        );
        expect(detail.examId, aExam.examId);

        await expectLater(
          endpoints.exams.getDetail(userA, examId: foreignExam.examId),
          throwsA(
            isA<ServerpodClientException>().having(
              (error) => error.statusCode,
              'statusCode',
              404,
            ),
          ),
        );
      });
    },
  );
}

Future<void> _preparePhase04Seed(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  TestSessionBuilder userA,
  TestSessionBuilder userB,
) async {
  await endpoints.studentProfile.updateMyProfile(
    userA,
    fullName: 'Nguyen Van A',
    className: 'CNTT-K1',
  );
  await endpoints.studentProfile.updateMyProfile(
    userB,
    fullName: 'Nguyen Van B',
    className: 'CNTT-K2',
  );

  final session = sessionBuilder.build();
  await seedAcademicDemoData(session);
  await seedDashboardNotificationDemoData(session);
  await seedDashboardNotificationDemoData(session);
}

Future<StudentProfile> _profileFor(Session session, String authUserId) async {
  final profile = await StudentProfile.db.findFirstRow(
    session,
    where: (t) => t.authUserId.equals(UuidValue.withValidation(authUserId)),
  );
  if (profile == null) {
    throw StateError('Missing test profile $authUserId');
  }
  return profile;
}
