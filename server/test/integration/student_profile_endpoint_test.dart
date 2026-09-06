import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _userAId = '00000000-0000-4000-8000-000000000001';
const _userBId = '00000000-0000-4000-8000-000000000002';
const _adminId = '00000000-0000-4000-8000-000000000003';

void main() {
  withServerpod(
    'Given StudentProfileEndpoint',
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
      final admin = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _adminId,
          {campusMateAdminScope},
        ),
      );
      final authenticatedWithoutStudentScope = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _userAId,
          const {},
        ),
      );

      // In-process calls bypass the HTTP layer, so requireLogin surfaces as
      // ServerpodUnauthenticatedException here; over HTTP the client maps it
      // to ServerpodClientUnauthorized (401). Same idea for scope checks.
      test('rejects an unauthenticated profile read', () async {
        await expectLater(
          endpoints.studentProfile.getMyProfile(sessionBuilder),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      });

      test('requires the student scope for profile access', () async {
        await expectLater(
          endpoints.studentProfile.getMyProfile(
            authenticatedWithoutStudentScope,
          ),
          throwsA(isA<ServerpodInsufficientAccessException>()),
        );
      });

      test(
        'creates a profile from the authenticated session identity',
        () async {
          final profile = await endpoints.studentProfile.getMyProfile(userA);

          expect(profile.authUserId, UuidValue.withValidation(_userAId));
          expect(profile.role, 'student');
          expect(profile.fullName, isNull);
          expect(profile.className, isNull);
        },
      );

      test(
        'updates only the caller profile and isolates another student',
        () async {
          final updatedA = await endpoints.studentProfile.updateMyProfile(
            userA,
            fullName: 'Nguyen Van A',
            className: 'CNTT-K1',
          );
          final profileB = await endpoints.studentProfile.getMyProfile(userB);

          expect(updatedA.authUserId, UuidValue.withValidation(_userAId));
          expect(updatedA.fullName, 'Nguyen Van A');
          expect(updatedA.className, 'CNTT-K1');
          expect(profileB.authUserId, UuidValue.withValidation(_userBId));
          expect(profileB.fullName, isNull);
          expect(profileB.className, isNull);

          final rows = await StudentProfile.db.find(sessionBuilder.build());
          expect(rows, hasLength(2));
          expect(
            rows.map((row) => row.authUserId),
            containsAll([
              UuidValue.withValidation(_userAId),
              UuidValue.withValidation(_userBId),
            ]),
          );
        },
      );

      test('rejects invalid editable fields before persistence', () async {
        await expectLater(
          endpoints.studentProfile.updateMyProfile(
            userA,
            fullName: '   ',
            className: 'CNTT-K1',
          ),
          throwsA(
            isA<ServerpodClientException>()
                .having((error) => error.statusCode, 'statusCode', 400)
                .having(
                  (error) => error.message,
                  'message',
                  contains('fullName'),
                ),
          ),
        );
      });

      test('blocks students from the protected admin surface', () async {
        await expectLater(
          endpoints.admin.getAccessSummary(userA),
          throwsA(isA<ServerpodInsufficientAccessException>()),
        );
        expect(
          await endpoints.admin.getAccessSummary(admin),
          'admin-access-granted',
        );
      });
    },
  );
}
