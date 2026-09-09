import 'package:campusmate/features/library/application/library_controller.dart';
import 'package:campusmate/features/library/domain/library_repository.dart';
import 'package:campusmate/features/library/presentation/my_loans_screen.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLibraryRepository implements LibraryRepository {
  _FakeLibraryRepository({
    this.loansPage,
    this.shouldThrowOnMyLoans = false,
    this.returnException,
  });

  BookLoanPage? loansPage;
  bool shouldThrowOnMyLoans;
  Object? returnException;
  int returnLoanCalls = 0;
  int? lastReturnedLoanId;

  @override
  Future<BookLoanPage> myLoans({
    String? cursor,
    int limit = 20,
    bool activeOnly = true,
  }) async {
    if (shouldThrowOnMyLoans) {
      throw ServerpodClientException('Không thể tải danh sách', 500);
    }
    return loansPage ??
        BookLoanPage(
          items: const [],
          serverNow: DateTime.utc(2026, 9, 9, 12, 0, 0),
        );
  }

  @override
  Future<BookLoanSummary> returnLoan({required int loanId}) async {
    returnLoanCalls++;
    lastReturnedLoanId = loanId;
    if (returnException != null) {
      throw returnException!;
    }
    return BookLoanSummary(
      id: loanId,
      bookId: 10,
      copyId: 101,
      title: 'Đã trả',
      borrowedAt: DateTime.utc(2026, 9, 1),
      dueAt: DateTime.utc(2026, 9, 15),
      returnedAt: DateTime.utc(2026, 9, 9, 12),
      status: BookLoanStatus.returned,
      daysRemaining: 6,
      isOverdue: false,
    );
  }

  @override
  Future<BookLoanSummary> borrowBook({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookDetail> getBookDetail({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<LibraryExplore> explore({int limitPerSection = 8}) =>
      throw UnimplementedError();

  @override
  Future<LibrarySearchPage> search({
    String? query,
    String? cursor,
    int limit = 20,
    LibraryFilters filters = const LibraryFilters(),
  }) => throw UnimplementedError();

  @override
  Future<BookFavoriteStatus> toggleFavorite({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<List<BookLoanSummary>> activeLoansForBook({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookAccessPolicyUpdate> updateAccessPolicy({
    required int bookId,
    required BookAccessType accessType,
  }) => throw UnimplementedError();
}

void main() {
  final now = DateTime.utc(2026, 9, 9, 12, 0, 0);

  testWidgets('renders empty state when there are no loans', (tester) async {
    final repository = _FakeLibraryRepository(
      loansPage: BookLoanPage(items: const [], serverNow: now),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [libraryRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: MyLoansScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sách của tôi'), findsOneWidget);
    expect(find.text('Chưa mượn tài liệu'), findsOneWidget);
    expect(find.text('Các sách đang mượn sẽ xuất hiện ở đây.'), findsOneWidget);
  });

  testWidgets('renders error state and retries on action click', (
    tester,
  ) async {
    final repository = _FakeLibraryRepository(shouldThrowOnMyLoans: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [libraryRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: MyLoansScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Không tải được sách đang mượn'), findsOneWidget);
    expect(find.text('Thử lại'), findsOneWidget);

    repository.shouldThrowOnMyLoans = false;
    repository.loansPage = BookLoanPage(
      items: [
        BookLoanSummary(
          id: 1,
          bookId: 10,
          copyId: 101,
          title: 'Học máy nâng cao',
          borrowedAt: now.subtract(const Duration(days: 3)),
          dueAt: now.add(const Duration(days: 11)),
          status: BookLoanStatus.borrowed,
          daysRemaining: 11,
          isOverdue: false,
        ),
      ],
      serverNow: now,
    );

    await tester.tap(find.text('Thử lại'));
    await tester.pumpAndSettle();

    expect(find.text('Học máy nâng cao'), findsOneWidget);
    expect(find.textContaining('Còn 11 ngày'), findsOneWidget);
  });

  testWidgets('renders active, overdue and returned loans with correct badges', (
    tester,
  ) async {
    final repository = _FakeLibraryRepository(
      loansPage: BookLoanPage(
        items: [
          BookLoanSummary(
            id: 1,
            bookId: 10,
            copyId: 101,
            title: 'Sách đang mượn chuẩn',
            borrowedAt: now.subtract(const Duration(days: 4)),
            dueAt: now.add(const Duration(days: 10)),
            status: BookLoanStatus.borrowed,
            daysRemaining: 10,
            isOverdue: false,
          ),
          BookLoanSummary(
            id: 2,
            bookId: 20,
            copyId: 201,
            title: 'Sách đã quá hạn',
            borrowedAt: now.subtract(const Duration(days: 20)),
            dueAt: now.subtract(const Duration(days: 6)),
            status: BookLoanStatus.overdue,
            daysRemaining: 0,
            isOverdue: true,
          ),
          BookLoanSummary(
            id: 3,
            bookId: 30,
            copyId: 301,
            title: 'Sách đã hoàn trả',
            borrowedAt: now.subtract(const Duration(days: 15)),
            dueAt: now.subtract(const Duration(days: 1)),
            returnedAt: now.subtract(const Duration(days: 2)),
            status: BookLoanStatus.returned,
            daysRemaining: 0,
            isOverdue: false,
          ),
        ],
        serverNow: now,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [libraryRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: MyLoansScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sách đang mượn chuẩn'), findsOneWidget);
    expect(find.textContaining('Còn 10 ngày'), findsOneWidget);
    expect(find.text('Đang mượn'), findsOneWidget);

    expect(find.text('Sách đã quá hạn'), findsOneWidget);
    expect(find.textContaining('Đã quá hạn từ'), findsOneWidget);
    expect(find.text('Quá hạn'), findsOneWidget);

    expect(find.text('Sách đã hoàn trả'), findsOneWidget);
    expect(find.textContaining('Đã trả ngày'), findsOneWidget);
    expect(find.text('Đã trả'), findsOneWidget);

    // Two active/overdue loans have the return button; returned loan does not.
    expect(find.widgetWithText(OutlinedButton, 'Trả sách'), findsNWidgets(2));
  });

  testWidgets('returning a loan calls repository and shows success SnackBar', (
    tester,
  ) async {
    final repository = _FakeLibraryRepository(
      loansPage: BookLoanPage(
        items: [
          BookLoanSummary(
            id: 42,
            bookId: 10,
            copyId: 101,
            title: 'Sách cần trả',
            borrowedAt: now.subtract(const Duration(days: 2)),
            dueAt: now.add(const Duration(days: 12)),
            status: BookLoanStatus.borrowed,
            daysRemaining: 12,
            isOverdue: false,
          ),
        ],
        serverNow: now,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [libraryRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: MyLoansScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(OutlinedButton, 'Trả sách'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(repository.returnLoanCalls, 1);
    expect(repository.lastReturnedLoanId, 42);
    expect(find.text('Đã trả sách.'), findsOneWidget);
  });

  testWidgets(
    'returning a loan shows server error message when operation fails',
    (tester) async {
      final repository = _FakeLibraryRepository(
        loansPage: BookLoanPage(
          items: [
            BookLoanSummary(
              id: 99,
              bookId: 15,
              copyId: 151,
              title: 'Sách lỗi trả',
              borrowedAt: now.subtract(const Duration(days: 2)),
              dueAt: now.add(const Duration(days: 12)),
              status: BookLoanStatus.borrowed,
              daysRemaining: 12,
              isOverdue: false,
            ),
          ],
          serverNow: now,
        ),
        returnException: ServerpodClientException(
          'Bạn không có quyền trả',
          403,
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [libraryRepositoryProvider.overrideWithValue(repository)],
          child: const MaterialApp(home: MyLoansScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(OutlinedButton, 'Trả sách'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(repository.returnLoanCalls, 1);
      expect(find.text('Bạn không có quyền trả'), findsOneWidget);
    },
  );
}
