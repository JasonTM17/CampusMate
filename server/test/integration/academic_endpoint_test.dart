@Timeout(Duration(minutes: 2))
library;

import 'package:campusmate_server/src/academic/academic_demo_seed.dart';
import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _userAId = '00000000-0000-4000-8000-000000000101';
const _userBId = '00000000-0000-4000-8000-000000000102';

void main() {
  withServerpod(
    'Given academic endpoints',
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

      test('rejects unauthenticated and non-student access', () async {
        await expectLater(
          endpoints.academic.getOverview(sessionBuilder),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );

        await expectLater(
          endpoints.academic.getOverview(authenticatedWithoutStudentScope),
          throwsA(isA<ServerpodInsufficientAccessException>()),
        );
      });

      test('seeds the academic catalog idempotently', () async {
        await _prepareAcademicSeed(sessionBuilder, endpoints, userA, userB);

        final session = sessionBuilder.build();
        await seedAcademicDemoData(session);

        expect(await Course.db.count(session), 15);
        expect(await CourseOffering.db.count(session), 25);
        expect(await CourseSchedule.db.count(session), 25);
        expect(await GradeComponent.db.count(session), 75);
        expect(await ExamSchedule.db.count(session), 50);
        expect(await Enrollment.db.count(session), 10);
        expect(await StudentGrade.db.count(session), 30);
      });

      test('returns a complete caller-scoped overview', () async {
        await _prepareAcademicSeed(sessionBuilder, endpoints, userA, userB);

        final overview = await endpoints.academic.getOverview(userA);

        expect(overview.currentSemester.code, '2026-HK1');
        expect(
          overview.availableSemesters.map((row) => row.code),
          containsAllInOrder(['2026-HK1', '2025-HK2']),
        );
        expect(overview.courses, hasLength(5));
        expect(overview.today, isNotEmpty);
        expect(overview.upcomingExams, isNotEmpty);
        expect(overview.semesterGpa, greaterThan(0));
        expect(overview.cumulativeGpa, overview.semesterGpa);
        expect(overview.progress.creditsEarned, greaterThan(0));
      });

      test('does not allow opening another student only course', () async {
        await _prepareAcademicSeed(sessionBuilder, endpoints, userA, userB);

        final aCourses = await endpoints.courses.getMyCourses(userA);
        final bCourses = await endpoints.courses.getMyCourses(userB);
        final aOfferingIds = aCourses.map((row) => row.offeringId).toSet();
        final foreignOfferingId = bCourses
            .map((row) => row.offeringId)
            .firstWhere((id) => !aOfferingIds.contains(id));

        await expectLater(
          endpoints.courses.getCourseDetail(
            userA,
            offeringId: foreignOfferingId,
          ),
          throwsA(
            isA<ServerpodClientException>().having(
              (error) => error.statusCode,
              'statusCode',
              404,
            ),
          ),
        );
      });

      test(
        'marks overlapping live classes as current for the requested day',
        () async {
          await _prepareAcademicSeed(sessionBuilder, endpoints, userA, userB);

          final entries = await endpoints.timetable.getDaily(
            userA,
            day: DateTime.utc(2026, 9, 7),
            now: DateTime.utc(2026, 9, 7, 3),
          );

          final current = entries.where((row) => row.isCurrent).toList();
          expect(entries, hasLength(2));
          expect(current, hasLength(2));
          expect(current.map((row) => row.startMinute).toSet(), {570});
        },
      );

      test(
        'uses campus timezone when the UTC date is still the previous day',
        () async {
          await _prepareAcademicSeed(sessionBuilder, endpoints, userA, userB);

          final entries = await endpoints.timetable.getDaily(
            userA,
            day: DateTime.utc(2026, 9, 6, 18),
            now: DateTime.utc(2026, 9, 7, 3),
          );

          expect(entries, hasLength(2));
          expect(entries.map((row) => row.weekday).toSet(), {DateTime.monday});
          expect(entries.where((row) => row.isCurrent), hasLength(2));
        },
      );

      test('returns the requested non-Monday daily timetable', () async {
        await _prepareAcademicSeed(sessionBuilder, endpoints, userA, userB);

        final entries = await endpoints.timetable.getDaily(
          userA,
          day: DateTime.utc(2026, 9, 8),
          now: DateTime.utc(2026, 9, 8, 1),
        );

        expect(entries, hasLength(2));
        expect(entries.map((row) => row.weekday).toSet(), {2});
        expect(entries.where((row) => row.isCurrent), hasLength(1));
      });

      test(
        'does not project recurring classes outside the semester window',
        () async {
          await _prepareAcademicSeed(sessionBuilder, endpoints, userA, userB);
          final session = sessionBuilder.build();
          final courses = await endpoints.courses.getMyCourses(userA);
          final schedule = await CourseSchedule.db.findFirstRow(
            session,
            where: (t) => t.offeringId.equals(courses.first.offeringId),
          );
          await CourseSchedule.db.updateRow(
            session,
            schedule!.copyWith(endsAt: DateTime.utc(2027, 1, 31)),
          );

          final entries = await endpoints.timetable.getWeekly(
            userA,
            weekStart: DateTime.utc(2026, 12, 28),
            now: DateTime.utc(2026, 12, 28),
          );

          expect(entries, isEmpty);
        },
      );

      test('returns GPA, exams, and curriculum progress', () async {
        await _prepareAcademicSeed(sessionBuilder, endpoints, userA, userB);

        final grades = await endpoints.grades.getBySemester(userA);
        final exams = await endpoints.exams.getUpcoming(
          userA,
          now: DateTime.utc(2026, 9, 7),
        );
        final progress = await endpoints.progress.getCurriculumProgress(userA);

        expect(grades.courses, hasLength(5));
        expect(grades.semesterGpa, greaterThan(0));
        expect(grades.creditsAttempted, greaterThan(0));
        expect(exams, hasLength(10));
        expect(exams.first.daysUntil, greaterThanOrEqualTo(0));
        expect(progress.blocks, hasLength(3));
        expect(progress.percentComplete, greaterThan(0));
      });
    },
  );
}

Future<void> _prepareAcademicSeed(
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
  await seedAcademicDemoData(session);
}
