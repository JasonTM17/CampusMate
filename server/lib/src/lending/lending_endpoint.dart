import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'lending_service.dart';

class LendingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  final _service = LendingService();

  Future<BookLoanSummary> borrowBook(
    Session session, {
    required int bookId,
  }) => _service.borrowBook(session, bookId: bookId);

  Future<BookLoanSummary> returnLoan(
    Session session, {
    required int loanId,
  }) => _service.returnLoan(session, loanId: loanId);

  Future<BookLoanPage> myLoans(
    Session session, {
    String? cursor,
    int limit = 20,
    bool activeOnly = true,
  }) => _service.myLoans(
    session,
    cursor: cursor,
    limit: limit,
    activeOnly: activeOnly,
  );

  Future<List<BookLoanSummary>> activeLoansForBook(
    Session session, {
    required int bookId,
  }) => _service.activeLoansForBook(session, bookId: bookId);
}
