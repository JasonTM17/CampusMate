import 'package:campusmate/features/library/application/library_controller.dart';
import 'package:campusmate/features/library/domain/library_repository.dart';
import 'package:campusmate/features/library/presentation/book_cover.dart';
import 'package:campusmate/features/library/presentation/book_detail_screen.dart';
import 'package:campusmate/features/library/presentation/my_loans_screen.dart';
import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _LibraryRepository implements LibraryRepository {
  int borrowCalls = 0;
  int returnCalls = 0;

  @override
  Future<LibraryExplore> explore({int limitPerSection = 8}) async =>
      _emptyExplore();

  @override
  Future<LibrarySearchPage> search({
    String? query,
    String? cursor,
    int limit = 20,
    LibraryFilters filters = const LibraryFilters(),
  }) async => LibrarySearchPage(items: const [], totalCount: 0);

  @override
  Future<BookDetail> getBookDetail({required int bookId}) async {
    expect(bookId, 7);
    return BookDetail(
      id: 7,
      title: 'Tài liệu tra cứu học vụ',
      description: 'Chỉ dùng để tra cứu metadata.',
      publisher: 'CampusMate Press',
      publishedYear: 2026,
      language: 'vi',
      accessType: BookAccessType.metadataOnly,
      license: 'Metadata only',
      keywords: 'library, reference',
      authors: const ['CampusMate Library'],
      categories: const ['Học vụ'],
      courseCodes: const ['SE214'],
      availableFormats: const [],
      isFavorite: false,
      access: BookAccessDecision(
        role: 'student',
        canRead: false,
        canDownload: false,
        canBorrow: false,
        reason: 'Tài liệu này hiện chỉ có thông tin tham khảo.',
      ),
      activeLoan: null,
      activeLoanCount: 0,
      availableCopies: 0,
    );
  }

  @override
  Future<BookFavoriteStatus> toggleFavorite({required int bookId}) async =>
      BookFavoriteStatus(bookId: bookId, isFavorite: true);

  @override
  Future<BookLoanSummary> borrowBook({required int bookId}) async {
    borrowCalls++;
    return _loan(bookId: bookId, daysRemaining: 14);
  }

  @override
  Future<BookLoanSummary> returnLoan({required int loanId}) async {
    returnCalls++;
    return _loan(
      status: BookLoanStatus.returned,
      returnedAt: DateTime.utc(2026, 9, 8),
    );
  }

  @override
  Future<BookLoanPage> myLoans({
    String? cursor,
    int limit = 20,
    bool activeOnly = true,
  }) async => BookLoanPage(
    items: [_loan(bookId: 11, title: 'Server-time Lending', daysRemaining: 5)],
    serverNow: DateTime.utc(2026, 9, 8),
  );

  @override
  Future<List<BookLoanSummary>> activeLoansForBook({
    required int bookId,
  }) async => const [];

  @override
  Future<BookAccessPolicyUpdate> updateAccessPolicy({
    required int bookId,
    required BookAccessType accessType,
  }) async => BookAccessPolicyUpdate(
    bookId: bookId,
    accessType: accessType,
    updatedAt: DateTime.utc(2026, 9, 8),
  );
}

class _StudentAuthController extends AuthController {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.authenticated,
    user: AuthUser(
      authUserId: '00000000-0000-4000-8000-000000000501',
      email: 'student@example.test',
      role: 'student',
    ),
  );
}

void main() {
  testWidgets('book detail keeps metadata-only records read-only', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryRepositoryProvider.overrideWithValue(_LibraryRepository()),
          authControllerProvider.overrideWith(_StudentAuthController.new),
        ],
        child: const MaterialApp(home: BookDetailScreen(bookId: 7)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tài liệu tra cứu học vụ'), findsOneWidget);
    expect(
      find.text('Tài liệu này hiện chỉ có thông tin tham khảo.'),
      findsOneWidget,
    );
    expect(find.widgetWithText(FilledButton, 'Đọc'), findsNothing);
    expect(find.widgetWithText(OutlinedButton, 'Tải xuống'), findsNothing);
    expect(find.widgetWithText(OutlinedButton, 'Mượn sách'), findsNothing);
  });

  testWidgets('book detail calls borrow endpoint for borrowable records', (
    tester,
  ) async {
    final repository = _BorrowableLibraryRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryRepositoryProvider.overrideWithValue(repository),
          authControllerProvider.overrideWith(_StudentAuthController.new),
        ],
        child: const MaterialApp(home: BookDetailScreen(bookId: 8)),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(OutlinedButton, 'Mượn sách'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(repository.borrowCalls, 1);
    expect(find.textContaining('Đã mượn đến'), findsOneWidget);
  });

  testWidgets('my loans uses server-computed days remaining', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryRepositoryProvider.overrideWithValue(_LibraryRepository()),
        ],
        child: const MaterialApp(home: MyLoansScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Server-time Lending'), findsOneWidget);
    expect(find.textContaining('Còn 5 ngày'), findsOneWidget);
  });

  testWidgets('book cover falls back to a placeholder without a cover url', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: BookCover(coverUrl: null))),
    );

    expect(find.byKey(const Key('library-cover-placeholder')), findsOneWidget);
    expect(find.byIcon(Icons.menu_book_outlined), findsOneWidget);
  });

  testWidgets(
    'book cover falls back to an error placeholder on image failure',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BookCover(coverUrl: 'https://example.invalid/cover.png'),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(
        find.byKey(const Key('library-cover-error-placeholder')),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.menu_book_outlined), findsOneWidget);
    },
  );
}

class _BorrowableLibraryRepository extends _LibraryRepository {
  @override
  Future<BookDetail> getBookDetail({required int bookId}) async {
    expect(bookId, 8);
    return BookDetail(
      id: 8,
      title: 'Tài liệu cần mượn',
      description: 'Có một bản còn sẵn.',
      publisher: 'CampusMate Press',
      publishedYear: 2026,
      language: 'vi',
      accessType: BookAccessType.borrowRequired,
      license: 'CampusMate demo',
      keywords: 'borrow',
      authors: const ['CampusMate Library'],
      categories: const ['Database'],
      courseCodes: const ['DB202'],
      availableFormats: const ['pdf'],
      isFavorite: false,
      access: BookAccessDecision(
        role: 'student',
        canRead: false,
        canDownload: false,
        canBorrow: true,
        reason: 'Bạn cần mượn tài liệu trước khi đọc.',
      ),
      activeLoan: null,
      activeLoanCount: 0,
      availableCopies: 1,
    );
  }
}

LibraryExplore _emptyExplore() {
  return LibraryExplore(
    sections: const [],
    filterOptions: LibraryFilterOptions(
      languages: const [],
      categories: const [],
      authors: const [],
      years: const [],
      accessTypes: const [],
      formats: const [],
    ),
  );
}

BookLoanSummary _loan({
  int id = 99,
  int bookId = 7,
  String title = 'Tài liệu tra cứu học vụ',
  int daysRemaining = 14,
  BookLoanStatus status = BookLoanStatus.borrowed,
  DateTime? returnedAt,
}) {
  return BookLoanSummary(
    id: id,
    bookId: bookId,
    copyId: 3,
    title: title,
    borrowedAt: DateTime.utc(2026, 9, 8),
    dueAt: DateTime.utc(2026, 9, 8).add(Duration(days: daysRemaining)),
    returnedAt: returnedAt,
    status: status,
    daysRemaining: daysRemaining,
    isOverdue: false,
  );
}
