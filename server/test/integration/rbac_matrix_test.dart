import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _adminUuid = '00000000-0000-4000-8000-0000000000a1';
const _librarianUuid = '00000000-0000-4000-8000-0000000000a2';
const _lecturerUuid = '00000000-0000-4000-8000-0000000000a3';
const _studentUuid = '00000000-0000-4000-8000-0000000000a4';

void main() {
  withServerpod('Given CampusMate RBAC Matrix (Phase-11)', (
    sessionBuilder,
    endpoints,
  ) {
    final adminSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _adminUuid,
        {campusMateAdminScope},
      ),
    );

    final librarianSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _librarianUuid,
        {campusMateLibrarianScope},
      ),
    );

    final lecturerSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _lecturerUuid,
        {campusMateLecturerScope},
      ),
    );

    final studentSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _studentUuid,
        {campusMateStudentScope},
      ),
    );

    group('Admin Surface RBAC Isolation', () {
      test('admin can access dashboard stats', () async {
        final stats = await endpoints.admin.getDashboardStats(adminSession);
        expect(stats, isA<AdminDashboardStats>());
        expect(stats.totalStudents, greaterThanOrEqualTo(0));
      });

      test('admin can list students', () async {
        final page = await endpoints.admin.listStudents(
          adminSession,
          limit: 20,
        );
        expect(page, isA<AdminStudentPage>());
      });

      test('admin can list audit logs', () async {
        final logsPage = await endpoints.admin.listAuditLogs(
          adminSession,
          limit: 20,
        );
        expect(logsPage, isA<AdminAuditLogPage>());
      });

      test(
        'KONGMING C1: librarian is strictly rejected from admin dashboard (403)',
        () async {
          await expectLater(
            endpoints.admin.getDashboardStats(librarianSession),
            throwsA(isA<ServerpodInsufficientAccessException>()),
          );
        },
      );

      test(
        'KONGMING C1: lecturer is strictly rejected from admin dashboard (403)',
        () async {
          await expectLater(
            endpoints.admin.getDashboardStats(lecturerSession),
            throwsA(isA<ServerpodInsufficientAccessException>()),
          );
        },
      );

      test(
        'KONGMING C1: student is strictly rejected from admin dashboard (403)',
        () async {
          await expectLater(
            endpoints.admin.getDashboardStats(studentSession),
            throwsA(isA<ServerpodInsufficientAccessException>()),
          );
        },
      );

      test(
        'unauthenticated caller is rejected with 401 unauthenticated',
        () async {
          await expectLater(
            endpoints.admin.getDashboardStats(sessionBuilder),
            throwsA(isA<ServerpodUnauthenticatedException>()),
          );
        },
      );

      test('KONGMING C1: librarian cannot list student records', () async {
        await expectLater(
          endpoints.admin.listStudents(librarianSession, limit: 20),
          throwsA(isA<ServerpodInsufficientAccessException>()),
        );
      });

      test('KONGMING C1: student cannot list student records', () async {
        await expectLater(
          endpoints.admin.listStudents(studentSession, limit: 20),
          throwsA(isA<ServerpodInsufficientAccessException>()),
        );
      });

      test('KONGMING C1: librarian cannot inspect audit logs', () async {
        await expectLater(
          endpoints.admin.listAuditLogs(librarianSession, limit: 20),
          throwsA(isA<ServerpodInsufficientAccessException>()),
        );
      });

      test('KONGMING C1: student cannot inspect audit logs', () async {
        await expectLater(
          endpoints.admin.listAuditLogs(studentSession, limit: 20),
          throwsA(isA<ServerpodInsufficientAccessException>()),
        );
      });
    });

    group('Librarian Surface RBAC Isolation', () {
      test('librarian can create book record', () async {
        final book = await endpoints.librarian.createBook(
          librarianSession,
          title: 'RBAC Test Book',
          authorNames: ['Librarian Author'],
          publishedYear: 2026,
          language: 'vi',
          accessType: BookAccessType.authenticatedFullText,
        );

        expect(book, isA<LibraryBook>());
        expect(book.title, 'RBAC Test Book');
      });

      test('librarian can request upload ticket', () async {
        final ticket = await endpoints.librarian.requestUploadTicket(
          librarianSession,
          bookId: 1,
          filename: 'test.pdf',
          format: 'pdf',
          byteSize: 1024,
        );

        expect(ticket, isA<BookUploadTicket>());
      });

      test(
        'KONGMING C1: student cannot call librarian endpoint (403)',
        () async {
          await expectLater(
            endpoints.librarian.createBook(
              studentSession,
              title: 'Unauthorized Student Book',
              authorNames: ['Student Hacker'],
              publishedYear: 2026,
              language: 'vi',
              accessType: BookAccessType.authenticatedFullText,
            ),
            throwsA(isA<ServerpodInsufficientAccessException>()),
          );
        },
      );

      test('unauthenticated caller to librarian is rejected (401)', () async {
        await expectLater(
          endpoints.librarian.createBook(
            sessionBuilder,
            title: 'Anonymous Book',
            authorNames: ['Anon'],
            publishedYear: 2026,
            language: 'vi',
            accessType: BookAccessType.authenticatedFullText,
          ),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      });
    });

    group('Student Deactivation Immediate Enforcement', () {
      test(
        'deactivating student blocks current and subsequent session calls immediately',
        () async {
          // 1. Student initially gets profile
          final initialProfile = await endpoints.studentProfile.getMyProfile(
            studentSession,
          );
          expect(initialProfile.status, isNot('inactive'));

          // 2. Admin deactivates student
          final updated = await endpoints.admin.setStudentStatus(
            adminSession,
            profileId: initialProfile.id!,
            isActive: false,
          );
          expect(updated.status, 'inactive');

          // 3. Student calls getMyProfile with their existing session -> immediately blocked!
          await expectLater(
            endpoints.studentProfile.getMyProfile(studentSession),
            throwsA(isA<ServerpodClientForbidden>()),
          );

          // 4. Student calls updateMyProfile -> also immediately blocked!
          await expectLater(
            endpoints.studentProfile.updateMyProfile(
              studentSession,
              fullName: 'Attempted Update',
              className: 'K68PM01',
            ),
            throwsA(isA<ServerpodClientForbidden>()),
          );

          // 5. Admin reactivates student
          await endpoints.admin.setStudentStatus(
            adminSession,
            profileId: initialProfile.id!,
            isActive: true,
          );

          // 6. Access is immediately restored
          final restoredProfile = await endpoints.studentProfile.getMyProfile(
            studentSession,
          );
          expect(restoredProfile.status, 'active');
        },
      );
    });
  });
}
