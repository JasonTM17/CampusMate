import 'package:campusmate/features/library/application/library_controller.dart';
import 'package:campusmate/features/library/domain/library_repository.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _LibraryRepository implements LibraryRepository {
  _LibraryRepository({this.nextCursor});

  final String? nextCursor;
  final searchCalls = <({String? query, String? cursor})>[];
  final delays = <String, Duration>{};
  final cursorDelays = <String, Duration>{};

  @override
  Future<LibraryExplore> explore({int limitPerSection = 8}) async => _explore();

  @override
  Future<LibrarySearchPage> search({
    String? query,
    String? cursor,
    int limit = 20,
    LibraryFilters filters = const LibraryFilters(),
  }) async {
    searchCalls.add((query: query, cursor: cursor));
    final normalized = query?.trim();
    final delay = delays[normalized];
    if (delay != null) await Future<void>.delayed(delay);
    final cursorDelay = cursor == null ? null : cursorDelays[cursor];
    if (cursorDelay != null) await Future<void>.delayed(cursorDelay);
    return LibrarySearchPage(
      items: [_book(id: cursor == null ? 1 : 2, title: normalized ?? 'all')],
      nextCursor: cursor == null ? nextCursor : null,
      totalCount: cursor == null && nextCursor != null ? 2 : 1,
    );
  }

  @override
  Future<BookDetail> getBookDetail({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookFavoriteStatus> toggleFavorite({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookLoanSummary> borrowBook({required int bookId}) =>
      throw UnimplementedError();

  @override
  Future<BookLoanSummary> returnLoan({required int loanId}) =>
      throw UnimplementedError();

  @override
  Future<BookLoanPage> myLoans({
    String? cursor,
    int limit = 20,
    bool activeOnly = true,
  }) => throw UnimplementedError();

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
  test('debounces rapid query changes into one server search', () async {
    final repository = _LibraryRepository();
    final container = ProviderContainer(
      overrides: [
        libraryRepositoryProvider.overrideWithValue(repository),
        librarySearchDebounceProvider.overrideWithValue(
          const Duration(milliseconds: 40),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(libraryControllerProvider.future);
    expect(repository.searchCalls, [(query: null, cursor: null)]);

    for (var index = 0; index < 10; index++) {
      container
          .read(libraryControllerProvider.notifier)
          .setQuery('mobile-$index');
    }

    await _until(
      () =>
          repository.searchCalls.length == 2 &&
          !container.read(libraryControllerProvider).requireValue.isSearching,
    );

    expect(repository.searchCalls, [
      (query: null, cursor: null),
      (query: 'mobile-9', cursor: null),
    ]);
  });

  test(
    'ignores stale search results that return after a newer query',
    () async {
      final repository = _LibraryRepository()
        ..delays['old'] = const Duration(milliseconds: 80);
      final container = ProviderContainer(
        overrides: [
          libraryRepositoryProvider.overrideWithValue(repository),
          librarySearchDebounceProvider.overrideWithValue(Duration.zero),
        ],
      );
      addTearDown(container.dispose);

      await container.read(libraryControllerProvider.future);
      container.read(libraryControllerProvider.notifier).setQuery('old');
      await Future<void>.delayed(const Duration(milliseconds: 1));
      container.read(libraryControllerProvider.notifier).setQuery('new');

      await Future<void>.delayed(const Duration(milliseconds: 120));

      final state = container.read(libraryControllerProvider).requireValue;
      expect(repository.searchCalls.map((call) => call.query), [
        null,
        'old',
        'new',
      ]);
      expect(state.query, 'new');
      expect(state.items.single.title, 'new');
    },
  );

  test(
    'loads additional cursor pages without dropping existing items',
    () async {
      final repository = _LibraryRepository(nextCursor: 'page-2');
      final container = ProviderContainer(
        overrides: [libraryRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      var state = await container.read(libraryControllerProvider.future);
      expect(state.hasMore, isTrue);
      expect(state.items.map((item) => item.id), [1]);

      await container.read(libraryControllerProvider.notifier).loadMore();
      state = container.read(libraryControllerProvider).requireValue;

      expect(repository.searchCalls.last.cursor, 'page-2');
      expect(state.items.map((item) => item.id), [1, 2]);
      expect(state.hasMore, isFalse);
    },
  );

  test('ignores stale cursor pages that return after a newer query', () async {
    final repository = _LibraryRepository(nextCursor: 'page-2')
      ..cursorDelays['page-2'] = const Duration(milliseconds: 80);
    final container = ProviderContainer(
      overrides: [
        libraryRepositoryProvider.overrideWithValue(repository),
        librarySearchDebounceProvider.overrideWithValue(Duration.zero),
      ],
    );
    addTearDown(container.dispose);

    await container.read(libraryControllerProvider.future);
    final loadMoreFuture = container
        .read(libraryControllerProvider.notifier)
        .loadMore();
    await Future<void>.delayed(const Duration(milliseconds: 1));
    container.read(libraryControllerProvider.notifier).setQuery('new');
    await loadMoreFuture;
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final state = container.read(libraryControllerProvider).requireValue;
    expect(repository.searchCalls, [
      (query: null, cursor: null),
      (query: '', cursor: 'page-2'),
      (query: 'new', cursor: null),
    ]);
    expect(state.query, 'new');
    expect(state.items.map((item) => item.title), ['new']);
    expect(state.isLoadingMore, isFalse);
  });
}

Future<void> _until(bool Function() done) async {
  for (var i = 0; i < 20; i++) {
    if (done()) return;
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('Condition did not become true in time.');
}

LibraryExplore _explore() {
  return LibraryExplore(
    sections: [
      LibraryExploreSection(
        key: 'featured',
        title: 'Nổi bật',
        items: [_book(id: 10, title: 'featured')],
      ),
    ],
    filterOptions: LibraryFilterOptions(
      languages: const ['vi', 'en'],
      categories: const ['Kỹ thuật phần mềm'],
      authors: const ['CampusMate Library'],
      years: const [2026],
      accessTypes: const [BookAccessType.metadataOnly],
      formats: const ['PDF', 'EPUB'],
    ),
  );
}

BookSummary _book({required int id, required String title}) {
  return BookSummary(
    id: id,
    title: title,
    description: 'Mô tả $title',
    publisher: 'CampusMate Press',
    publishedYear: 2026,
    language: 'vi',
    accessType: BookAccessType.metadataOnly,
    license: 'CampusMate Demo',
    authors: const ['CampusMate Library'],
    categories: const ['Kỹ thuật phần mềm'],
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
