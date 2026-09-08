import 'package:campusmate/features/library/application/library_controller.dart';
import 'package:campusmate/features/library/domain/library_repository.dart';
import 'package:campusmate/features/library/presentation/book_cover.dart';
import 'package:campusmate/features/library/presentation/book_detail_screen.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _LibraryRepository implements LibraryRepository {
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
    );
  }

  @override
  Future<BookFavoriteStatus> toggleFavorite({required int bookId}) async =>
      BookFavoriteStatus(bookId: bookId, isFavorite: true);
}

void main() {
  testWidgets('book detail keeps metadata-only records read-only', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryRepositoryProvider.overrideWithValue(_LibraryRepository()),
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
