import 'dart:convert';

import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _adminUuid = '00000000-0000-4000-8000-0000000000b1';
const _librarianUuid = '00000000-0000-4000-8000-0000000000b2';

void main() {
  withServerpod('Given Admin and Librarian Privileged Operations (Phase-11)', (
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

    group('Privileged Student Mutations Audit Trail', () {
      test('creating student logs ADMIN_CREATE_STUDENT audit entry', () async {
        final profile = await endpoints.admin.createStudent(
          adminSession,
          email: 'newstudent@campusmate.local',
          password: 'Password123!',
          studentCode: 'SV999901',
          fullName: 'Trần Văn Mới',
          className: 'K68PM99',
          faculty: 'Công nghệ Thông tin',
          major: 'Kỹ thuật Phần mềm',
        );

        expect(profile.studentCode, 'SV999901');

        final logs = await endpoints.admin.listAuditLogs(
          adminSession,
          action: 'ADMIN_CREATE_STUDENT',
          resourceType: 'student_profile',
        );

        expect(
          logs.logs.any((l) => l.resourceId == profile.id.toString()),
          isTrue,
        );
        final log = logs.logs.firstWhere(
          (l) => l.resourceId == profile.id.toString(),
        );
        expect(log.action, 'ADMIN_CREATE_STUDENT');
        expect(log.actorUserId.toString(), _adminUuid);
      });

      test('updating student logs ADMIN_UPDATE_STUDENT audit entry', () async {
        final profile = await endpoints.admin.createStudent(
          adminSession,
          email: 'updatestudent@campusmate.local',
          password: 'Password123!',
          studentCode: 'SV999902',
          fullName: 'Lê Cần Sửa',
          className: 'K68PM99',
        );

        await endpoints.admin.updateStudent(
          adminSession,
          profileId: profile.id!,
          fullName: 'Lê Đã Sửa',
          gpa: 3.85,
        );

        final logs = await endpoints.admin.listAuditLogs(
          adminSession,
          action: 'ADMIN_UPDATE_STUDENT',
          resourceType: 'student_profile',
        );

        expect(
          logs.logs.any((l) => l.resourceId == profile.id.toString()),
          isTrue,
        );
      });

      test(
        'deactivating and activating student logs ADMIN_DISABLE_USER and ADMIN_ACTIVATE_STUDENT',
        () async {
          final profile = await endpoints.admin.createStudent(
            adminSession,
            email: 'statustest@campusmate.local',
            password: 'Password123!',
            studentCode: 'SV999903',
            fullName: 'Nguyễn Trạng Thái',
            className: 'K68PM99',
          );

          // Deactivate
          await endpoints.admin.setStudentStatus(
            adminSession,
            profileId: profile.id!,
            isActive: false,
          );

          final disableLogs = await endpoints.admin.listAuditLogs(
            adminSession,
            action: 'ADMIN_DISABLE_USER',
          );
          expect(
            disableLogs.logs.any((l) => l.resourceId == profile.id.toString()),
            isTrue,
          );

          // Reactivate
          await endpoints.admin.setStudentStatus(
            adminSession,
            profileId: profile.id!,
            isActive: true,
          );

          final activateLogs = await endpoints.admin.listAuditLogs(
            adminSession,
            action: 'ADMIN_ACTIVATE_STUDENT',
          );
          expect(
            activateLogs.logs.any((l) => l.resourceId == profile.id.toString()),
            isTrue,
          );
        },
      );
    });

    group('Librarian Mutations Audit Trail', () {
      test('creating and updating book records audit rows', () async {
        final book = await endpoints.librarian.createBook(
          librarianSession,
          title: 'Audit Demo Book',
          authorNames: ['Giáo sư Nguyễn'],
          publishedYear: 2026,
          language: 'vi',
          categoryNames: ['Công nghệ'],
          totalCopies: 2,
        );

        final createLogs = await endpoints.admin.listAuditLogs(
          adminSession,
          action: 'LIBRARIAN_CREATE_BOOK',
          resourceType: 'book',
        );
        expect(
          createLogs.logs.any((l) => l.resourceId == book.id.toString()),
          isTrue,
        );
        final createLog = createLogs.logs.firstWhere(
          (l) => l.resourceId == book.id.toString(),
        );
        expect(createLog.actorUserId.toString(), _librarianUuid);

        // Update book
        await endpoints.librarian.updateBook(
          librarianSession,
          bookId: book.id!,
          title: 'Audit Demo Book Revised',
        );

        final updateLogs = await endpoints.admin.listAuditLogs(
          adminSession,
          action: 'LIBRARIAN_UPDATE_BOOK',
          resourceType: 'book',
        );
        expect(
          updateLogs.logs.any((l) => l.resourceId == book.id.toString()),
          isTrue,
        );

        // Archive book
        await endpoints.librarian.archiveBook(
          librarianSession,
          bookId: book.id!,
        );

        final archiveLogs = await endpoints.admin.listAuditLogs(
          adminSession,
          action: 'LIBRARIAN_ARCHIVE_BOOK',
          resourceType: 'book',
        );
        expect(
          archiveLogs.logs.any((l) => l.resourceId == book.id.toString()),
          isTrue,
        );
      });

      test(
        'uploading book file records LIBRARIAN_UPLOAD_BOOK with metadata',
        () async {
          final book = await endpoints.librarian.createBook(
            librarianSession,
            title: 'Uploadable Book',
            authorNames: ['Tác giả Upload'],
            publishedYear: 2026,
            language: 'vi',
          );

          final ticket = await endpoints.librarian.requestUploadTicket(
            librarianSession,
            bookId: book.id!,
            filename: 'content.pdf',
            format: 'pdf',
            byteSize: 1024,
          );

          final validPdfBytes = utf8.encode(
            '%PDF-1.7\nSample content for audit upload test.',
          );
          final bookFile = await endpoints.librarian.uploadBookFile(
            librarianSession,
            bookId: book.id!,
            uploadToken: ticket.uploadToken,
            fileBytes: validPdfBytes,
            format: 'pdf',
            clientFilename: 'content.pdf',
          );

          expect(bookFile, isA<LibraryBookFile>());
          expect(bookFile.format, 'pdf');

          final uploadLogs = await endpoints.admin.listAuditLogs(
            adminSession,
            action: 'LIBRARIAN_UPLOAD_BOOK',
            resourceType: 'book_file',
          );
          expect(
            uploadLogs.logs.any((l) => l.resourceId == bookFile.id.toString()),
            isTrue,
          );
        },
      );
    });

    group('Announcement Management & Dashboard Aggregates', () {
      test('announcements CRUD records corresponding audit entries', () async {
        final now = DateTime.now().toUtc();
        final item = await endpoints.admin.createAnnouncement(
          adminSession,
          title: 'Học kỳ mới 2026',
          body: 'Thông báo khai giảng học kỳ 1 năm học 2026-2027.',
          audience: 'student',
          publishAt: now,
        );

        final createLogs = await endpoints.admin.listAuditLogs(
          adminSession,
          action: 'ADMIN_CREATE_ANNOUNCEMENT',
        );
        expect(
          createLogs.logs.any((l) => l.resourceId == item.id.toString()),
          isTrue,
        );

        // Update
        await endpoints.admin.updateAnnouncement(
          adminSession,
          announcementId: item.id!,
          title: 'Học kỳ mới 2026 (Cập nhật)',
        );

        final updateLogs = await endpoints.admin.listAuditLogs(
          adminSession,
          action: 'ADMIN_UPDATE_ANNOUNCEMENT',
        );
        expect(
          updateLogs.logs.any((l) => l.resourceId == item.id.toString()),
          isTrue,
        );

        // Archive
        await endpoints.admin.archiveAnnouncement(
          adminSession,
          announcementId: item.id!,
        );

        final archiveLogs = await endpoints.admin.listAuditLogs(
          adminSession,
          action: 'ADMIN_ARCHIVE_ANNOUNCEMENT',
        );
        expect(
          archiveLogs.logs.any((l) => l.resourceId == item.id.toString()),
          isTrue,
        );
      });

      test('admin dashboard returns consistent aggregates', () async {
        await endpoints.admin.createStudent(
          adminSession,
          email: 'statsstudent@campusmate.local',
          password: 'Password123!',
          studentCode: 'SV999909',
          fullName: 'Nguyễn Thống Kê',
          className: 'K68PM99',
        );

        await endpoints.librarian.createBook(
          librarianSession,
          title: 'Stats Demo Book',
          authorNames: ['Tác giả Thống kê'],
          publishedYear: 2026,
          language: 'vi',
        );

        final stats = await endpoints.admin.getDashboardStats(adminSession);

        expect(stats.totalStudents, greaterThan(0));
        expect(stats.activeStudents, greaterThan(0));
        expect(stats.activeStudents, lessThanOrEqualTo(stats.totalStudents));
        expect(stats.totalBooks, greaterThan(0));
        expect(stats.activeLoans, greaterThanOrEqualTo(0));
        expect(stats.aiRequestsToday, greaterThanOrEqualTo(0));
      });
    });
  });
}
