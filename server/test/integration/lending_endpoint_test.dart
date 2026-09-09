@Timeout(Duration(minutes: 3))
library;

import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _studentAId = '00000000-0000-4000-8000-000000000411';
const _studentBId = '00000000-0000-4000-8000-000000000412';
const _librarianId = '00000000-0000-4000-8000-000000000413';

void main() {
  withServerpod(
    'Given LendingEndpoint',
    (sessionBuilder, endpoints) {
      final studentA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _studentAId,
          {campusMateStudentScope},
        ),
      );
      final studentB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _studentBId,
          {campusMateStudentScope},
        ),
      );
      final librarian = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _librarianId,
          {campusMateLibrarianScope},
        ),
      );

      setUp(() async {
        await _cleanup(sessionBuilder.build());
      });

      tearDown(() async {
        await _cleanup(sessionBuilder.build());
      });

      test(
        'has a database partial unique index for active copy loans',
        () async {
          final indexes = await sessionBuilder.build().db.unsafeQuery(
            "SELECT indexdef FROM pg_indexes "
            "WHERE schemaname = 'public' "
            "AND tablename = 'book_loans' "
            "AND indexname = 'book_loans_active_copy_idx'",
          );

          expect(indexes, hasLength(1));
          final indexDef = indexes.single.toColumnMap()['indexdef'].toString();
          expect(indexDef, contains('UNIQUE INDEX'));
          expect(indexDef, contains('"copyId"'));
          expect(indexDef, contains('WHERE'));
          expect(indexDef, contains('borrowed'));
          expect(indexDef, contains('overdue'));
        },
      );

      test('borrows a borrow-required book with server-owned dueAt', () async {
        final session = sessionBuilder.build();
        final book = await _insertBook(session, isbn: 'CM-LEND-BORROW-001');
        await _insertCopies(session, book, count: 1);

        final loan = await endpoints.lending.borrowBook(
          studentA,
          bookId: book.id!,
        );
        final detail = await endpoints.library.getBookDetail(
          studentA,
          bookId: book.id!,
        );
        final myLoans = await endpoints.lending.myLoans(
          studentA,
          limit: 20,
          activeOnly: true,
        );

        expect(loan.bookId, book.id);
        expect(loan.status, BookLoanStatus.borrowed);
        expect(loan.dueAt.difference(loan.borrowedAt).inDays, loanDays);
        expect(loan.daysRemaining, loanDays);
        expect(detail.access.canRead, isTrue);
        expect(detail.access.canBorrow, isFalse);
        expect(detail.activeLoan?.id, loan.id);
        expect(detail.activeLoanCount, 1);
        expect(detail.availableCopies, 0);
        expect(myLoans.items.map((item) => item.id), contains(loan.id));
        expect(
          myLoans.items.singleWhere((item) => item.id == loan.id).daysRemaining,
          loanDays,
        );
      });

      test(
        'allows exactly one concurrent borrow for one available copy',
        () async {
          final session = sessionBuilder.build();
          final book = await _insertBook(session, isbn: 'CM-LEND-RACE-001');
          final copy = (await _insertCopies(session, book, count: 1)).single;

          final outcomes = await Future.wait<Object>([
            _capture(
              () => endpoints.lending.borrowBook(studentA, bookId: book.id!),
            ),
            _capture(
              () => endpoints.lending.borrowBook(studentB, bookId: book.id!),
            ),
          ]);

          final successes = outcomes.whereType<BookLoanSummary>().toList();
          final failures = outcomes
              .whereType<ServerpodClientException>()
              .toList();
          final activeCount = await BookLoan.db.count(
            session,
            where: (t) =>
                t.copyId.equals(copy.id!) &
                t.status.inSet({
                  BookLoanStatus.borrowed,
                  BookLoanStatus.overdue,
                }),
          );
          final persistedCopy = await BookCopy.db.findById(session, copy.id!);

          expect(successes, hasLength(1));
          expect(failures, hasLength(1));
          expect(failures.single.statusCode, 409);
          expect(activeCount, 1);
          expect(persistedCopy?.status, BookCopyStatus.borrowed);
        },
      );

      test('returns a loan and makes the copy borrowable again', () async {
        final session = sessionBuilder.build();
        final book = await _insertBook(session, isbn: 'CM-LEND-RETURN-001');
        final copy = (await _insertCopies(session, book, count: 1)).single;
        final firstLoan = await endpoints.lending.borrowBook(
          studentA,
          bookId: book.id!,
        );

        final returned = await endpoints.lending.returnLoan(
          studentA,
          loanId: firstLoan.id,
        );
        final availableCopy = await BookCopy.db.findById(session, copy.id!);
        final secondLoan = await endpoints.lending.borrowBook(
          studentB,
          bookId: book.id!,
        );

        expect(returned.status, BookLoanStatus.returned);
        expect(returned.returnedAt, isNotNull);
        expect(availableCopy?.status, BookCopyStatus.available);
        expect(secondLoan.copyId, copy.id);
        expect(secondLoan.status, BookLoanStatus.borrowed);
      });

      test('marks overdue loans lazily from server time when read', () async {
        final session = sessionBuilder.build();
        final book = await _insertBook(session, isbn: 'CM-LEND-OVERDUE-001');
        final copy = (await _insertCopies(session, book, count: 1)).single;
        final now = DateTime.now().toUtc();
        final loan = await BookLoan.db.insertRow(
          session,
          BookLoan(
            userId: UuidValue.withValidation(_studentAId),
            bookId: book.id!,
            copyId: copy.id!,
            borrowedAt: now.subtract(const Duration(days: 20)),
            dueAt: now.subtract(const Duration(days: 6)),
            status: BookLoanStatus.borrowed,
            createdAt: now.subtract(const Duration(days: 20)),
            updatedAt: now.subtract(const Duration(days: 20)),
          ),
        );
        await BookCopy.db.updateRow(
          session,
          copy.copyWith(status: BookCopyStatus.borrowed, updatedAt: now),
        );

        final page = await endpoints.lending.myLoans(
          studentA,
          limit: 20,
          activeOnly: true,
        );
        final persistedLoan = await BookLoan.db.findById(session, loan.id!);

        expect(page.serverNow.isUtc, isTrue);
        expect(page.items.single.id, loan.id);
        expect(page.items.single.status, BookLoanStatus.overdue);
        expect(page.items.single.isOverdue, isTrue);
        expect(page.items.single.daysRemaining, 0);
        expect(persistedLoan?.status, BookLoanStatus.overdue);
      });

      test('shows active book loans to librarians only', () async {
        final session = sessionBuilder.build();
        final book = await _insertBook(session, isbn: 'CM-LEND-LIB-001');
        await _insertCopies(session, book, count: 1);
        final loan = await endpoints.lending.borrowBook(
          studentA,
          bookId: book.id!,
        );

        final activeLoans = await endpoints.lending.activeLoansForBook(
          librarian,
          bookId: book.id!,
        );

        expect(activeLoans.map((item) => item.id), [loan.id]);
        await expectLater(
          endpoints.lending.activeLoansForBook(studentB, bookId: book.id!),
          throwsA(isA<ServerpodClientForbidden>()),
        );
      });

      test(
        'audits librarian access-policy changes with clean metadata',
        () async {
          final session = sessionBuilder.build();
          final book = await _insertBook(
            session,
            isbn: 'CM-LEND-AUDIT-001',
            accessType: BookAccessType.metadataOnly,
          );

          await expectLater(
            endpoints.library.updateAccessPolicy(
              studentA,
              bookId: book.id!,
              accessType: BookAccessType.borrowRequired,
            ),
            throwsA(isA<ServerpodClientForbidden>()),
          );
          final update = await endpoints.library.updateAccessPolicy(
            librarian,
            bookId: book.id!,
            accessType: BookAccessType.borrowRequired,
          );
          final audit = await AuditLog.db.findFirstRow(
            session,
            where: (t) =>
                t.action.equals('LIBRARIAN_CHANGE_ACCESS_POLICY') &
                t.resourceType.equals('book') &
                t.resourceId.equals(book.id!.toString()),
          );

          expect(update.accessType, BookAccessType.borrowRequired);
          expect(audit, isNotNull);
          expect(audit!.metadataJson, contains('"from":"metadataOnly"'));
          expect(audit.metadataJson, contains('"to":"borrowRequired"'));
          expect(
            audit.metadataJson,
            isNot(
              matches(
                RegExp(
                  'password|token|secret|credential',
                  caseSensitive: false,
                ),
              ),
            ),
          );
        },
      );

      test(
        'rejects borrow attempts for non-borrowable catalog records',
        () async {
          final session = sessionBuilder.build();
          final book = await _insertBook(
            session,
            isbn: 'CM-LEND-DENY-001',
            accessType: BookAccessType.metadataOnly,
          );
          await _insertCopies(session, book, count: 1);

          await expectLater(
            endpoints.lending.borrowBook(studentA, bookId: book.id!),
            throwsA(
              isA<ServerpodClientException>().having(
                (error) => error.statusCode,
                'statusCode',
                403,
              ),
            ),
          );
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}

const loanDays = 14;

Future<Object> _capture(Future<Object> Function() run) async {
  try {
    return await run();
  } on Object catch (error) {
    return error;
  }
}

Future<void> _cleanup(Session session) async {
  await AuditLog.db.deleteWhere(
    session,
    where: (t) => t.action.inSet({
      'LIBRARIAN_CHANGE_ACCESS_POLICY',
      'ADMIN_CHANGE_ACCESS_POLICY',
      'LIBRARIAN_RETURN_LOAN',
      'ADMIN_RETURN_LOAN',
    }),
  );
  final books = await LibraryBook.db.find(
    session,
    where: (t) => t.isbn.ilike('CM-LEND-%'),
    limit: 500,
  );
  final bookIds = books
      .where((book) => book.id != null)
      .map((book) => book.id!)
      .toSet();
  if (bookIds.isEmpty) return;
  await BookLoan.db.deleteWhere(session, where: (t) => t.bookId.inSet(bookIds));
  await BookCopy.db.deleteWhere(session, where: (t) => t.bookId.inSet(bookIds));
  await LibraryBook.db.deleteWhere(session, where: (t) => t.id.inSet(bookIds));
}

Future<LibraryBook> _insertBook(
  Session session, {
  required String isbn,
  BookAccessType accessType = BookAccessType.borrowRequired,
}) {
  final now = DateTime.now().toUtc();
  return LibraryBook.db.insertRow(
    session,
    LibraryBook(
      title: 'Lending Fixture $isbn',
      description: 'Synthetic lending integration fixture.',
      isbn: isbn,
      publisher: 'CampusMate Test',
      publishedYear: 2026,
      language: 'vi',
      accessType: accessType,
      license: 'Test-only metadata',
      keywords: 'lending fixture',
      searchText: 'lending fixture $isbn',
      popularityScore: 1,
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
