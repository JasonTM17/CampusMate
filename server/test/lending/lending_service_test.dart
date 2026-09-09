import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:campusmate_server/src/lending/lending_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  group('LendingService.isActiveStatus', () {
    test('marks borrowed and overdue as active, and returned as inactive', () {
      expect(LendingService.isActiveStatus(BookLoanStatus.borrowed), isTrue);
      expect(LendingService.isActiveStatus(BookLoanStatus.overdue), isTrue);
      expect(LendingService.isActiveStatus(BookLoanStatus.returned), isFalse);
    });
  });

  group('LendingService.summaryForLoan', () {
    final book = LibraryBook(
      id: 10,
      title: 'Thiết kế cơ sở dữ liệu',
      description: 'Giáo trình CSDL',
      publisher: 'CampusMate Press',
      publishedYear: 2026,
      language: 'vi',
      accessType: BookAccessType.borrowRequired,
      license: 'Demo License',
      keywords: 'database, sql',
      searchText: 'thiết kế cơ sở dữ liệu csdl database sql',
      popularityScore: 100,
      isActive: true,
      createdAt: DateTime.utc(2026, 1, 1),
      updatedAt: DateTime.utc(2026, 1, 1),
    );

    final serverNow = DateTime.utc(2026, 9, 9, 12, 0, 0);

    test('calculates correct days remaining for an active loan', () {
      final loan = BookLoan(
        id: 1,
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        bookId: 10,
        copyId: 101,
        borrowedAt: serverNow,
        dueAt: serverNow.add(const Duration(days: 14)),
        status: BookLoanStatus.borrowed,
        createdAt: serverNow,
        updatedAt: serverNow,
      );

      final summary = LendingService.summaryForLoan(
        loan: loan,
        book: book,
        serverNow: serverNow,
      );

      expect(summary.id, 1);
      expect(summary.bookId, 10);
      expect(summary.copyId, 101);
      expect(summary.title, 'Thiết kế cơ sở dữ liệu');
      expect(summary.status, BookLoanStatus.borrowed);
      expect(summary.isOverdue, isFalse);
      expect(summary.daysRemaining, 14);
    });

    test('rounds up partial days using ceilDays', () {
      final loan = BookLoan(
        id: 2,
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        bookId: 10,
        copyId: 102,
        borrowedAt: serverNow.subtract(const Duration(days: 13, hours: 18)),
        dueAt: serverNow.add(const Duration(hours: 6)),
        status: BookLoanStatus.borrowed,
        createdAt: serverNow,
        updatedAt: serverNow,
      );

      final summary = LendingService.summaryForLoan(
        loan: loan,
        book: book,
        serverNow: serverNow,
      );

      expect(summary.status, BookLoanStatus.borrowed);
      expect(summary.isOverdue, isFalse);
      expect(summary.daysRemaining, 1);
    });

    test('marks as overdue when dueAt equals serverNow', () {
      final loan = BookLoan(
        id: 3,
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        bookId: 10,
        copyId: 103,
        borrowedAt: serverNow.subtract(const Duration(days: 14)),
        dueAt: serverNow,
        status: BookLoanStatus.borrowed,
        createdAt: serverNow,
        updatedAt: serverNow,
      );

      final summary = LendingService.summaryForLoan(
        loan: loan,
        book: book,
        serverNow: serverNow,
      );

      expect(summary.status, BookLoanStatus.overdue);
      expect(summary.isOverdue, isTrue);
      expect(summary.daysRemaining, 0);
    });

    test('marks as overdue when dueAt is before serverNow', () {
      final loan = BookLoan(
        id: 4,
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        bookId: 10,
        copyId: 104,
        borrowedAt: serverNow.subtract(const Duration(days: 16)),
        dueAt: serverNow.subtract(const Duration(days: 2)),
        status: BookLoanStatus.borrowed,
        createdAt: serverNow,
        updatedAt: serverNow,
      );

      final summary = LendingService.summaryForLoan(
        loan: loan,
        book: book,
        serverNow: serverNow,
      );

      expect(summary.status, BookLoanStatus.overdue);
      expect(summary.isOverdue, isTrue);
      expect(summary.daysRemaining, 0);
    });

    test('preserves returned status and returnedAt timestamp', () {
      final returnedTime = serverNow.subtract(const Duration(days: 3));
      final loan = BookLoan(
        id: 5,
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        bookId: 10,
        copyId: 105,
        borrowedAt: serverNow.subtract(const Duration(days: 10)),
        dueAt: serverNow.add(const Duration(days: 4)),
        returnedAt: returnedTime,
        status: BookLoanStatus.returned,
        createdAt: serverNow,
        updatedAt: serverNow,
      );

      final summary = LendingService.summaryForLoan(
        loan: loan,
        book: book,
        serverNow: serverNow,
      );

      expect(summary.status, BookLoanStatus.returned);
      expect(summary.isOverdue, isFalse);
      expect(summary.returnedAt, returnedTime);
      expect(summary.daysRemaining, 4);
    });
  });
}
