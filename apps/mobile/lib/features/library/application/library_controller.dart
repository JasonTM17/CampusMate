import 'dart:async';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../data/serverpod_library_repository.dart';
import '../domain/library_repository.dart';

final libraryRepositoryProvider = Provider<LibraryRepository>(
  (ref) => ServerpodLibraryRepository(ref.watch(serverpodClientProvider)),
);

final librarySearchDebounceProvider = Provider<Duration>(
  (ref) => const Duration(milliseconds: 350),
);

final bookDetailProvider = FutureProvider.autoDispose.family<BookDetail, int>((
  ref,
  bookId,
) {
  return ref.watch(libraryRepositoryProvider).getBookDetail(bookId: bookId);
});

final libraryControllerProvider =
    AsyncNotifierProvider<LibraryController, LibraryState>(
      LibraryController.new,
    );

class LibraryController extends AsyncNotifier<LibraryState> {
  LibraryRepository get _repository => ref.read(libraryRepositoryProvider);

  Timer? _debounce;
  int _searchGeneration = 0;

  @override
  Future<LibraryState> build() async {
    ref.onDispose(() => _debounce?.cancel());
    final explore = await _repository.explore();
    final page = await _repository.search();
    return LibraryState(
      explore: explore,
      items: page.items,
      totalCount: page.totalCount,
      nextCursor: page.nextCursor,
    );
  }

  Future<void> refresh() async {
    _debounce?.cancel();
    final current = state.value;
    final nextGeneration = ++_searchGeneration;
    state = const AsyncLoading<LibraryState>();
    state = await AsyncValue.guard(() async {
      final explore = await _repository.explore();
      final page = await _repository.search(
        query: current?.query,
        filters: current?.filters ?? const LibraryFilters(),
      );
      if (nextGeneration != _searchGeneration) {
        return state.value ?? current ?? _emptyState(explore);
      }
      return LibraryState(
        explore: explore,
        items: page.items,
        totalCount: page.totalCount,
        nextCursor: page.nextCursor,
        query: current?.query ?? '',
        filters: current?.filters ?? const LibraryFilters(),
      );
    });
  }

  void setQuery(String query) {
    final current = state.value;
    if (current == null) return;
    final next = current.copyWith(
      query: query,
      isSearching: true,
      isLoadingMore: false,
    );
    state = AsyncData(next);
    _debounce?.cancel();
    final generation = ++_searchGeneration;
    final delay = ref.read(librarySearchDebounceProvider);
    if (delay == Duration.zero) {
      unawaited(_runSearch(generation));
    } else {
      _debounce = Timer(delay, () => unawaited(_runSearch(generation)));
    }
  }

  Future<void> applyFilters(LibraryFilters filters) async {
    final current = state.value;
    if (current == null) return;
    _debounce?.cancel();
    final generation = ++_searchGeneration;
    state = AsyncData(
      current.copyWith(
        filters: filters,
        isSearching: true,
        isLoadingMore: false,
      ),
    );
    await _runSearch(generation);
  }

  Future<void> clearFilters() => applyFilters(const LibraryFilters());

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;
    final generation = _searchGeneration;
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final page = await _repository.search(
        query: current.query,
        cursor: current.nextCursor,
        filters: current.filters,
      );
      if (generation != _searchGeneration) return;
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(
          items: [...latest.items, ...page.items],
          totalCount: page.totalCount,
          nextCursor: page.nextCursor,
          clearNextCursor: page.nextCursor == null,
          isLoadingMore: false,
        ),
      );
    } on Object catch (error, stackTrace) {
      if (generation != _searchGeneration) return;
      state = AsyncError(error, stackTrace);
    }
  }

  void updateFavoriteStatus(BookFavoriteStatus status) {
    final current = state.value;
    if (current == null) return;
    BookSummary update(BookSummary item) => item.id == status.bookId
        ? item.copyWith(isFavorite: status.isFavorite)
        : item;
    final explore = current.explore.copyWith(
      sections: [
        for (final section in current.explore.sections)
          section.copyWith(
            items: [for (final item in section.items) update(item)],
          ),
      ],
    );
    state = AsyncData(
      current.copyWith(
        explore: explore,
        items: [for (final item in current.items) update(item)],
      ),
    );
  }

  Future<void> _runSearch(int generation) async {
    final current = state.value;
    if (current == null) return;
    try {
      final page = await _repository.search(
        query: current.query,
        filters: current.filters,
      );
      if (generation != _searchGeneration) return;
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(
          items: page.items,
          totalCount: page.totalCount,
          nextCursor: page.nextCursor,
          clearNextCursor: page.nextCursor == null,
          isSearching: false,
          isLoadingMore: false,
        ),
      );
    } on Object catch (error, stackTrace) {
      if (generation != _searchGeneration) return;
      state = AsyncError(error, stackTrace);
    }
  }

  LibraryState _emptyState(LibraryExplore explore) =>
      LibraryState(explore: explore, items: const [], totalCount: 0);
}
