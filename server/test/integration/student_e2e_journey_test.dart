@Timeout(Duration(minutes: 3))
library;

import 'package:campusmate_server/src/academic/academic_demo_seed.dart';
import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _adminUuid = '00000000-0000-4000-8000-000000000e01';
const _studentUuid = '00000000-0000-4000-8000-000000000e02';

void main() {
  withServerpod(
    'Given Server-Side Student End-to-End Lifecycle Journey',
    (sessionBuilder, endpoints) {
      final adminSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _adminUuid,
          {campusMateAdminScope},
        ),
      );

      final studentSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _studentUuid,
          {campusMateStudentScope},
        ),
      );

      setUp(() async {
        final session = sessionBuilder.build();
        await _cleanupJourneyData(session);
      });

      tearDown(() async {
        final session = sessionBuilder.build();
        await _cleanupJourneyData(session);
      });

      test(
        'executes cohesive journey: Admin Provisioning -> Profile -> Academic -> Borrow -> Reader LWW -> AI Assistant -> Admin Audit',
        () async {
          final session = sessionBuilder.build();

          // -------------------------------------------------------------------
          // Step 1: Admin Provisions Student Profile
          // -------------------------------------------------------------------
          final createdProfile = await endpoints.admin.createStudent(
            adminSession,
            email: 'e2e_student@campusmate.local',
            password: 'Password123!',
            studentCode: 'SV260001',
            fullName: 'Nguyen Van E2E',
            className: 'K68-CNTT',
            faculty: 'Khoa Cong nghe Thong tin',
            major: 'Ky thuat Phan mem',
          );

          expect(createdProfile.studentCode, 'SV260001');
          expect(createdProfile.fullName, 'Nguyen Van E2E');
          expect(createdProfile.authUserId, isNotNull);

          // Link the created profile to _studentUuid for studentSession
          await StudentProfile.db.updateRow(
            session,
            createdProfile.copyWith(
              authUserId: UuidValue.fromString(_studentUuid),
            ),
          );

          // -------------------------------------------------------------------
          // Step 2: Student Reads Profile
          // -------------------------------------------------------------------
          final studentProfile = await endpoints.studentProfile.getMyProfile(
            studentSession,
          );
          expect(studentProfile.studentCode, 'SV260001');
          expect(studentProfile.fullName, 'Nguyen Van E2E');
          expect(studentProfile.faculty, 'Khoa Cong nghe Thong tin');

          // -------------------------------------------------------------------
          // Step 3: Student Checks Academic Overview & Timetable
          // -------------------------------------------------------------------
          await seedAcademicDemoData(session);

          // Enroll student in CS301 offering
          final offering = await CourseOffering.db.findFirstRow(
            session,
            where: (t) => t.section.equals('N1'),
          );
          expect(offering, isNotNull);

          var enrollment = await Enrollment.db.findFirstRow(
            session,
            where: (t) =>
                t.studentProfileId.equals(createdProfile.id!) &
                t.offeringId.equals(offering!.id!),
          );
          enrollment ??= await Enrollment.db.insertRow(
            session,
            Enrollment(
              studentProfileId: createdProfile.id!,
              offeringId: offering!.id!,
              status: 'active',
              progressPercent: 70,
              attendancePercent: 100,
            ),
          );

          final academicOverview = await endpoints.academic.getOverview(
            studentSession,
          );
          expect(academicOverview.currentSemester.code, '2026-HK1');
          expect(academicOverview.courses.isNotEmpty, isTrue);

          // -------------------------------------------------------------------
          // Step 4: Student Explores Library & Borrows a Book
          // -------------------------------------------------------------------
          final testBook = await _insertBook(
            session,
            isbn: 'CM-E2E-JOURNEY-001',
            title: 'CampusMate Architecture Guide',
          );
          await _insertCopies(session, testBook, count: 2);
          await _insertBookFile(session, testBook, format: 'pdf');

          final explore = await endpoints.library.explore(
            studentSession,
            limitPerSection: 8,
          );
          expect(explore.sections.isNotEmpty, isTrue);

          final loan = await endpoints.lending.borrowBook(
            studentSession,
            bookId: testBook.id!,
          );
          expect(loan.bookId, testBook.id);
          expect(loan.status, BookLoanStatus.borrowed);
          expect(loan.daysRemaining, 14);

          final myLoans = await endpoints.lending.myLoans(
            studentSession,
            limit: 20,
            activeOnly: true,
          );
          expect(myLoans.items.any((l) => l.id == loan.id), isTrue);

          // -------------------------------------------------------------------
          // Step 5: Reader Asset, Bookmarking, and LWW Progress Sync
          // -------------------------------------------------------------------
          final asset = await endpoints.reader.getReaderAsset(
            studentSession,
            bookId: testBook.id!,
            format: 'pdf',
          );
          expect(asset.bookId, testBook.id);
          expect(asset.assetUrl, isNotEmpty);

          final bookmark = await endpoints.reader.addBookmark(
            studentSession,
            bookId: testBook.id!,
            location: 'page:15',
            title: 'Chapter 2 Microservices',
          );
          expect(bookmark.bookId, testBook.id);
          expect(bookmark.location, 'page:15');

          // Progress Sync with LWW: client timestamp T1
          final t1 = DateTime.utc(2026, 9, 9, 10, 0);
          final syncT1 = await endpoints.reader.syncProgress(
            studentSession,
            bookId: testBook.id!,
            progressPercent: 25.0,
            currentLocation: 'page:15',
            clientUpdatedAt: t1,
          );
          expect(syncT1.appliedClientUpdate, isTrue);
          expect(syncT1.progressPercent, 25.0);

          // Stale client timestamp T0 (earlier than T1) should NOT overwrite (LWW)
          final t0 = DateTime.utc(2026, 9, 9, 9, 0);
          final syncT0 = await endpoints.reader.syncProgress(
            studentSession,
            bookId: testBook.id!,
            progressPercent: 10.0,
            currentLocation: 'page:5',
            clientUpdatedAt: t0,
          );
          expect(syncT0.appliedClientUpdate, isFalse);
          expect(syncT0.progressPercent, 25.0); // Retains T1 value

          // Newer client timestamp T2 overwrites
          final t2 = DateTime.utc(2026, 9, 9, 11, 0);
          final syncT2 = await endpoints.reader.syncProgress(
            studentSession,
            bookId: testBook.id!,
            progressPercent: 50.0,
            currentLocation: 'page:30',
            clientUpdatedAt: t2,
          );
          expect(syncT2.appliedClientUpdate, isTrue);
          expect(syncT2.progressPercent, 50.0);

          final currentProgress = await endpoints.reader.getProgress(
            studentSession,
            bookId: testBook.id!,
          );
          expect(currentProgress?.progressPercent, 50.0);

          // -------------------------------------------------------------------
          // Step 6: AI Preferences, Study Suggestions & Conversation
          // -------------------------------------------------------------------
          final updatedPrefs = await endpoints.ai.updatePreferences(
            studentSession,
            explanationStyle: 'socratic',
            personalizationEnabled: true,
            memoryEnabled: true,
          );
          expect(updatedPrefs.explanationStyle, 'socratic');
          expect(updatedPrefs.personalizationEnabled, isTrue);

          final suggestion = await endpoints.ai.getStudySuggestion(
            studentSession,
          );
          expect(suggestion, isNotNull);
          expect(suggestion?.title, isNotEmpty);

          final conv = await endpoints.ai.createConversation(
            studentSession,
            title: 'Hỏi về môn kiến trúc phần mềm',
          );
          expect(conv.id, isNotNull);

          final stream = endpoints.ai.sendMessage(
            studentSession,
            conversationId: conv.id!,
            userMessage: 'Giải thích nguyên lý Clean Architecture',
          );
          final replyBuffer = StringBuffer();
          await for (final chunk in stream) {
            replyBuffer.write(chunk);
          }
          expect(replyBuffer.toString(), isNotEmpty);

          // -------------------------------------------------------------------
          // Step 7: Admin Audits Privileged Operations
          // -------------------------------------------------------------------
          final auditLogs = await endpoints.admin.listAuditLogs(
            adminSession,
            action: 'ADMIN_CREATE_STUDENT',
          );
          expect(
            auditLogs.logs.any((l) => l.actorUserId.toString() == _adminUuid),
            isTrue,
          );
        },
      );
    },
  );
}

Future<void> _cleanupJourneyData(Session session) async {
  final studentUuid = UuidValue.fromString(_studentUuid);

  await AuditLog.db.deleteWhere(
    session,
    where: (t) =>
        t.actorUserId.equals(UuidValue.fromString(_adminUuid)) |
        t.action.inSet({
          'ADMIN_CREATE_STUDENT',
          'ADMIN_UPDATE_STUDENT',
        }),
  );

  await ReaderBookmark.db.deleteWhere(
    session,
    where: (t) => t.userId.equals(studentUuid),
  );
  await ReadingProgress.db.deleteWhere(
    session,
    where: (t) => t.userId.equals(studentUuid),
  );
  await BookLoan.db.deleteWhere(
    session,
    where: (t) => t.userId.equals(studentUuid),
  );

  final books = await LibraryBook.db.find(
    session,
    where: (t) => t.isbn.ilike('CM-E2E-%'),
    limit: 100,
  );
  final bookIds = books.where((b) => b.id != null).map((b) => b.id!).toSet();
  if (bookIds.isNotEmpty) {
    await ReaderBookmark.db.deleteWhere(
      session,
      where: (t) => t.bookId.inSet(bookIds),
    );
    await ReadingProgress.db.deleteWhere(
      session,
      where: (t) => t.bookId.inSet(bookIds),
    );
    await BookLoan.db.deleteWhere(
      session,
      where: (t) => t.bookId.inSet(bookIds),
    );
    await BookCopy.db.deleteWhere(
      session,
      where: (t) => t.bookId.inSet(bookIds),
    );
    await LibraryBookFile.db.deleteWhere(
      session,
      where: (t) => t.bookId.inSet(bookIds),
    );
    await LibraryBook.db.deleteWhere(
      session,
      where: (t) => t.id.inSet(bookIds),
    );
  }

  await StudentProfile.db.deleteWhere(
    session,
    where: (t) =>
        t.authUserId.equals(studentUuid) | t.studentCode.equals('SV260001'),
  );
}

Future<LibraryBook> _insertBook(
  Session session, {
  required String isbn,
  required String title,
}) {
  final now = DateTime.now().toUtc();
  return LibraryBook.db.insertRow(
    session,
    LibraryBook(
      title: title,
      description: 'End-to-end journey test book.',
      isbn: isbn,
      publisher: 'CampusMate E2E',
      publishedYear: 2026,
      language: 'vi',
      accessType: BookAccessType.borrowRequired,
      license: 'Internal Educational',
      keywords: 'e2e test journey',
      searchText: '$title $isbn',
      popularityScore: 10,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    ),
  );
}

Future<List<BookCopy>> _insertCopies(
  Session session,
  LibraryBook book, {
  required int count,
}) {
  final now = DateTime.now().toUtc();
  return BookCopy.db.insert(
    session,
    [
      for (var index = 1; index <= count; index++)
        BookCopy(
          bookId: book.id!,
          barcode: '${book.isbn}-COPY-${index.toString().padLeft(2, '0')}',
          status: BookCopyStatus.available,
          createdAt: now,
          updatedAt: now,
        ),
    ],
  );
}

Future<LibraryBookFile> _insertBookFile(
  Session session,
  LibraryBook book, {
  String format = 'pdf',
}) {
  final now = DateTime.now().toUtc();
  return LibraryBookFile.db.insertRow(
    session,
    LibraryBookFile(
      bookId: book.id!,
      format: format,
      storageKey: 'books/${book.id}/content.$format',
      byteSize: 1048576,
      checksum: 'sha256:dummy',
      isPrimary: true,
      createdAt: now,
    ),
  );
}
