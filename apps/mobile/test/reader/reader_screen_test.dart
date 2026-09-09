import 'package:campusmate/features/reader/domain/reader_repository.dart';
import 'package:campusmate/features/reader/presentation/reader_screen.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeReaderRepository implements ReaderRepository {
  _FakeReaderRepository({
    this.initialProgress,
    this.shouldThrow = false,
  });

  ReaderAsset? asset;
  ReadingProgress? initialProgress;
  bool shouldThrow;

  int syncProgressCalls = 0;
  int addBookmarkCalls = 0;
  int saveNoteCalls = 0;

  @override
  Future<ReaderAsset> getReaderAsset({
    required int bookId,
    required String format,
  }) async {
    if (shouldThrow) {
      throw ServerpodClientException('Bạn không có quyền đọc tài liệu này.', 403);
    }
    return asset ??
        ReaderAsset(
          bookId: bookId,
          format: format,
          assetUrl: 'https://example.test/reader/asset.pdf',
          expiresAt: DateTime.utc(2026, 9, 9, 12, 15),
        );
  }

  @override
  Future<ReadingProgress?> getProgress({required int bookId}) async {
    return initialProgress;
  }

  @override
  Future<ReadingProgressSyncResult> syncProgress({
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime clientUpdatedAt,
  }) async {
    syncProgressCalls++;
    return ReadingProgressSyncResult(
      bookId: bookId,
      progressPercent: progressPercent,
      currentLocation: currentLocation,
      updatedAt: clientUpdatedAt,
      appliedClientUpdate: true,
    );
  }

  @override
  Future<List<ReaderBookmark>> getBookmarks({required int bookId}) async => const [];

  @override
  Future<ReaderBookmark> addBookmark({
    required int bookId,
    required String location,
    required String title,
  }) async {
    addBookmarkCalls++;
    return ReaderBookmark(
      id: 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      bookId: bookId,
      location: location,
      title: title,
      createdAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<void> removeBookmark({required int bookmarkId}) async {}

  @override
  Future<List<ReaderNote>> getNotes({required int bookId}) async => const [];

  @override
  Future<ReaderNote> saveNote({
    required int bookId,
    required String location,
    required String content,
    int? noteId,
  }) async {
    saveNoteCalls++;
    return ReaderNote(
      id: 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      bookId: bookId,
      location: location,
      content: content,
      createdAt: DateTime.utc(2026, 9, 9),
      updatedAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<void> deleteNote({required int noteId}) async {}

  @override
  Future<List<ReaderHighlight>> getHighlights({required int bookId}) async => const [];

  @override
  Future<ReaderHighlight> addHighlight({
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
  }) async {
    return ReaderHighlight(
      id: 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      bookId: bookId,
      location: location,
      text: text,
      colorToken: colorToken,
      createdAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<void> removeHighlight({required int highlightId}) async {}
}

void main() {
  testWidgets('renders reader view and advances location', (tester) async {
    final repo = _FakeReaderRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          readerRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(
          home: ReaderScreen(bookId: 10, format: 'pdf', title: 'Giáo trình CSDL'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Giáo trình CSDL (PDF)'), findsOneWidget);
    expect(find.text('Đang đọc tại vị trí: 1'), findsOneWidget);

    // Tap next location button
    await tester.tap(find.byTooltip('Vị trí kế tiếp'));
    await tester.pumpAndSettle();

    expect(find.text('Đang đọc tại vị trí: 2'), findsOneWidget);
    expect(repo.syncProgressCalls, greaterThanOrEqualTo(1));
  });

  testWidgets('shows resume banner when saved progress exists', (tester) async {
    final repo = _FakeReaderRepository(
      initialProgress: ReadingProgress(
        id: 1,
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        bookId: 10,
        progressPercent: 65.0,
        currentLocation: '25',
        updatedAt: DateTime.utc(2026, 9, 8),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          readerRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(
          home: ReaderScreen(bookId: 10, format: 'epub', title: 'Cơ sở dữ liệu'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Tiếp tục từ 65% (Vị trí 25)?'), findsOneWidget);

    // Tap "Tiếp tục"
    await tester.tap(find.widgetWithText(FilledButton, 'Tiếp tục'));
    await tester.pumpAndSettle();

    expect(find.text('Đang đọc tại vị trí: 25'), findsOneWidget);
    expect(find.textContaining('Tiếp tục từ 65%'), findsNothing);
  });

  testWidgets('shows error state when reader asset fails to load', (tester) async {
    final repo = _FakeReaderRepository(shouldThrow: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          readerRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(
          home: ReaderScreen(bookId: 10, format: 'pdf'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Không thể mở tài liệu'), findsOneWidget);
    expect(find.text('Bạn không có quyền đọc tài liệu này.'), findsOneWidget);
  });

  testWidgets('adds bookmark when bookmark action chip is tapped', (tester) async {
    final repo = _FakeReaderRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          readerRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(
          home: ReaderScreen(bookId: 10, format: 'pdf'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Đánh dấu vị trí này'));
    await tester.pumpAndSettle();

    expect(repo.addBookmarkCalls, 1);
  });
}
