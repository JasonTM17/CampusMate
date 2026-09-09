import 'dart:convert';

import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../audit/audit_service.dart';
import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import '../library/book_access_policy_service.dart';

class LendingService {
  LendingService({
    BookAccessPolicyService? policy,
    AuditService? audit,
  }) : _policy = policy ?? BookAccessPolicyService(),
       _audit = audit ?? AuditService();

  static const loanDays = 14;
  static const activeLoanStatuses = {
    BookLoanStatus.borrowed,
    BookLoanStatus.overdue,
  };

  final BookAccessPolicyService _policy;
  final AuditService _audit;

  Future<BookLoanSummary> borrowBook(
    Session session, {
    required int bookId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    try {
      final result = await session.db.transaction<_LoanWithBook>((
        transaction,
      ) async {
        final now = CampusClock.nowUtc();
        await refreshOverdue(
          session,
          userId: userId,
          bookIds: {bookId},
          transaction: transaction,
          now: now,
        );

        final book = await LibraryBook.db.findById(
          session,
          bookId,
          transaction: transaction,
        );
        if (book == null || !book.isActive) {
          throw ServerpodClientException('Book not found', 404);
        }

        final existingLoan = await _activeLoanForUserBook(
          session,
          userId: userId,
          bookId: bookId,
          transaction: transaction,
          lock: true,
        );
        if (existingLoan != null) {
          throw ServerpodClientException(
            'Bạn đang mượn tài liệu này.',
            409,
          );
        }

        final decision = _policy.evaluateForSession(session, book);
        if (!decision.canBorrow) {
          throw ServerpodClientException(
            decision.reason ?? 'Bạn không có quyền mượn tài liệu này.',
            403,
          );
        }

        final copy = await BookCopy.db.findFirstRow(
          session,
          where: (t) =>
              t.bookId.equals(bookId) &
              t.status.equals(BookCopyStatus.available),
          orderBy: (t) => t.id,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
          lockBehavior: LockBehavior.skipLocked,
        );
        if (copy == null) {
          throw ServerpodClientException(
            'Tất cả bản sao của tài liệu này đang được mượn.',
            409,
          );
        }

        await BookCopy.db.updateRow(
          session,
          copy.copyWith(status: BookCopyStatus.borrowed, updatedAt: now),
          transaction: transaction,
        );

        final loan = await BookLoan.db.insertRow(
          session,
          BookLoan(
            userId: userId,
            bookId: bookId,
            copyId: copy.id!,
            borrowedAt: now,
            dueAt: now.add(const Duration(days: loanDays)),
            status: BookLoanStatus.borrowed,
            createdAt: now,
            updatedAt: now,
          ),
          transaction: transaction,
        );

        return _LoanWithBook(loan: loan, book: book, serverNow: now);
      });

      return summaryForLoan(
        loan: result.loan,
        book: result.book,
        serverNow: result.serverNow,
      );
    } on ServerpodClientException {
      rethrow;
    } catch (error) {
      if (_isActiveLoanConflict(error)) {
        throw ServerpodClientException(
          'Bản sao này vừa được người khác mượn. Vui lòng thử bản khác.',
          409,
        );
      }
      rethrow;
    }
  }

  Future<BookLoanSummary> returnLoan(
    Session session, {
    required int loanId,
  }) async {
    final actorUserId = CampusMateAuth.requireUserId(session);
    final role = CampusMateAuth.roleFor(session);
    final result = await session.db.transaction<_LoanWithBook>((
      transaction,
    ) async {
      final now = CampusClock.nowUtc();
      final loan = await BookLoan.db.findById(
        session,
        loanId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (loan == null) {
        throw ServerpodClientException('Loan not found', 404);
      }
      final isOwner = loan.userId.toString() == actorUserId.toString();
      final isPrivileged = _isPrivilegedRole(role);
      if (!isOwner && !isPrivileged) {
        throw ServerpodClientForbidden();
      }

      final book = await LibraryBook.db.findById(
        session,
        loan.bookId,
        transaction: transaction,
      );
      if (book == null) {
        throw ServerpodClientException('Book not found', 404);
      }

      if (loan.status == BookLoanStatus.returned) {
        return _LoanWithBook(loan: loan, book: book, serverNow: now);
      }

      final copy = await BookCopy.db.findById(
        session,
        loan.copyId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      final returnedLoan = await BookLoan.db.updateRow(
        session,
        loan.copyWith(
          status: BookLoanStatus.returned,
          returnedAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      if (copy != null) {
        await BookCopy.db.updateRow(
          session,
          copy.copyWith(status: BookCopyStatus.available, updatedAt: now),
          transaction: transaction,
        );
      }
      if (isPrivileged && !isOwner) {
        await _audit.record(
          session,
          actorUserId: actorUserId,
          action: role == 'admin'
              ? 'ADMIN_RETURN_LOAN'
              : 'LIBRARIAN_RETURN_LOAN',
          resourceType: 'book_loan',
          resourceId: loanId.toString(),
          metadata: {
            'loanUserId': loan.userId.toString(),
            'bookId': loan.bookId,
            'copyId': loan.copyId,
          },
          transaction: transaction,
        );
      }

      return _LoanWithBook(loan: returnedLoan, book: book, serverNow: now);
    });

    return summaryForLoan(
      loan: result.loan,
      book: result.book,
      serverNow: result.serverNow,
    );
  }

  Future<BookLoanPage> myLoans(
    Session session, {
    String? cursor,
    int limit = 20,
    bool activeOnly = true,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final now = CampusClock.nowUtc();
    await refreshOverdue(session, userId: userId, now: now);
    final pageSize = limit.clamp(1, 50).toInt();
    final decoded = _decodeCursor(cursor, activeOnly: activeOnly);
    final rows = await BookLoan.db.find(
      session,
      where: (t) => _loanPageExpression(
        t,
        userId: userId,
        activeOnly: activeOnly,
        cursor: decoded,
      ),
      orderByList: (t) => [
        Order(column: t.dueAt),
        Order(column: t.id),
      ],
      limit: pageSize + 1,
    );
    final hasMore = rows.length > pageSize;
    final visibleRows = hasMore ? rows.take(pageSize).toList() : rows;
    return BookLoanPage(
      items: await summariesForLoans(session, visibleRows, serverNow: now),
      nextCursor: hasMore && visibleRows.isNotEmpty
          ? _encodeCursor(visibleRows.last, activeOnly: activeOnly)
          : null,
      serverNow: now,
    );
  }

  Future<List<BookLoanSummary>> activeLoansForBook(
    Session session, {
    required int bookId,
  }) async {
    final role = CampusMateAuth.roleFor(session);
    if (!_isPrivilegedRole(role)) {
      throw ServerpodClientForbidden();
    }
    final now = CampusClock.nowUtc();
    await refreshOverdue(session, bookIds: {bookId}, now: now);
    final rows = await BookLoan.db.find(
      session,
      where: (t) =>
          t.bookId.equals(bookId) & t.status.inSet(activeLoanStatuses),
      orderByList: (t) => [
        Order(column: t.dueAt),
        Order(column: t.id),
      ],
      limit: 50,
    );
    return summariesForLoans(session, rows, serverNow: now);
  }

  Future<void> refreshOverdue(
    Session session, {
    UuidValue? userId,
    Set<int>? bookIds,
    Transaction? transaction,
    DateTime? now,
  }) async {
    final timestamp = (now ?? CampusClock.nowUtc()).toUtc();
    await BookLoan.db.updateWhere(
      session,
      where: (t) {
        var expression =
            t.status.equals(BookLoanStatus.borrowed) & (t.dueAt <= timestamp);
        if (userId != null) {
          expression = expression & t.userId.equals(userId);
        }
        if (bookIds != null && bookIds.isNotEmpty) {
          expression = expression & t.bookId.inSet(bookIds);
        }
        return expression;
      },
      columnValues: (t) => [
        t.status(BookLoanStatus.overdue),
        t.updatedAt(timestamp),
      ],
      transaction: transaction,
    );
  }

  Future<BookLoan?> activeLoanForUserBook(
    Session session, {
    required UuidValue userId,
    required int bookId,
  }) {
    return _activeLoanForUserBook(session, userId: userId, bookId: bookId);
  }

  Future<List<BookLoanSummary>> summariesForLoans(
    Session session,
    List<BookLoan> loans, {
    required DateTime serverNow,
    Map<int, LibraryBook>? booksById,
  }) async {
    if (loans.isEmpty) return [];
    final bookIds = loans.map((loan) => loan.bookId).toSet();
    final books = {
      ...?booksById,
      for (final book in await LibraryBook.db.find(
        session,
        where: (t) => t.id.inSet(bookIds),
        limit: bookIds.length,
      ))
        book.id!: book,
    };
    return [
      for (final loan in loans)
        if (books[loan.bookId] != null)
          summaryForLoan(
            loan: loan,
            book: books[loan.bookId]!,
            serverNow: serverNow,
          ),
    ];
  }

  static BookLoanSummary summaryForLoan({
    required BookLoan loan,
    required LibraryBook book,
    required DateTime serverNow,
  }) {
    final normalizedNow = serverNow.toUtc();
    final dueAt = loan.dueAt.toUtc();
    final active = isActiveStatus(loan.status);
    final overdue =
        active && !dueAt.isAfter(normalizedNow) ||
        loan.status == BookLoanStatus.overdue;
    return BookLoanSummary(
      id: loan.id!,
      bookId: loan.bookId,
      copyId: loan.copyId,
      title: book.title,
      coverUrl: book.coverUrl,
      borrowedAt: loan.borrowedAt,
      dueAt: loan.dueAt,
      returnedAt: loan.returnedAt,
      status: overdue ? BookLoanStatus.overdue : loan.status,
      daysRemaining: overdue ? 0 : _ceilDays(dueAt.difference(normalizedNow)),
      isOverdue: overdue,
    );
  }

  static bool isActiveStatus(BookLoanStatus status) =>
      activeLoanStatuses.contains(status);

  Future<BookLoan?> _activeLoanForUserBook(
    Session session, {
    required UuidValue userId,
    required int bookId,
    Transaction? transaction,
    bool lock = false,
  }) {
    return BookLoan.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.bookId.equals(bookId) &
          t.status.inSet(activeLoanStatuses),
      orderBy: (t) => t.dueAt,
      transaction: transaction,
      lockMode: lock ? LockMode.forUpdate : null,
    );
  }

  Expression _loanPageExpression(
    BookLoanTable t, {
    required UuidValue userId,
    required bool activeOnly,
    required _LoanCursor? cursor,
  }) {
    var expression = t.userId.equals(userId);
    if (activeOnly) {
      expression = expression & t.status.inSet(activeLoanStatuses);
    }
    if (cursor != null) {
      expression =
          expression &
          ((t.dueAt > cursor.dueAt) |
              (t.dueAt.equals(cursor.dueAt) & (t.id > cursor.id)));
    }
    return expression;
  }

  String _encodeCursor(BookLoan row, {required bool activeOnly}) {
    return base64Url.encode(
      utf8.encode(
        jsonEncode({
          'v': 1,
          'dueAt': row.dueAt.toUtc().toIso8601String(),
          'id': row.id,
          'activeOnly': activeOnly,
        }),
      ),
    );
  }

  _LoanCursor? _decodeCursor(String? cursor, {required bool activeOnly}) {
    if (cursor == null || cursor.trim().isEmpty) return null;
    try {
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(cursor))),
      );
      if (payload is! Map<String, dynamic> ||
          payload['v'] != 1 ||
          payload['id'] is! int ||
          payload['dueAt'] is! String ||
          payload['activeOnly'] != activeOnly) {
        throw const FormatException('Invalid loan cursor.');
      }
      return _LoanCursor(
        id: payload['id'] as int,
        dueAt: DateTime.parse(payload['dueAt'] as String).toUtc(),
      );
    } on FormatException {
      throw ServerpodClientException('Invalid loan cursor', 400);
    } on ArgumentError {
      throw ServerpodClientException('Invalid loan cursor', 400);
    }
  }

  bool _isPrivilegedRole(String role) => role == 'librarian' || role == 'admin';

  bool _isActiveLoanConflict(Object error) {
    final text = error.toString();
    return text.contains('book_loans_active_copy_idx') ||
        text.contains('duplicate key value violates unique constraint');
  }

  static int _ceilDays(Duration duration) {
    if (duration <= Duration.zero) return 0;
    return (duration.inSeconds + Duration.secondsPerDay - 1) ~/
        Duration.secondsPerDay;
  }
}

class _LoanCursor {
  const _LoanCursor({required this.id, required this.dueAt});

  final int id;
  final DateTime dueAt;
}

class _LoanWithBook {
  const _LoanWithBook({
    required this.loan,
    required this.book,
    required this.serverNow,
  });

  final BookLoan loan;
  final LibraryBook book;
  final DateTime serverNow;
}
