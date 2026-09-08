import 'package:campusmate_client/campusmate_client.dart';

class LibraryFilters {
  const LibraryFilters({
    this.formats = const <String>{},
    this.languages = const <String>{},
    this.categories = const <String>{},
    this.authors = const <String>{},
    this.years = const <int>{},
    this.accessTypes = const <BookAccessType>{},
    this.relatedToMyCourses = false,
  });

  final Set<String> formats;
  final Set<String> languages;
  final Set<String> categories;
  final Set<String> authors;
  final Set<int> years;
  final Set<BookAccessType> accessTypes;
  final bool relatedToMyCourses;

  bool get isEmpty =>
      formats.isEmpty &&
      languages.isEmpty &&
      categories.isEmpty &&
      authors.isEmpty &&
      years.isEmpty &&
      accessTypes.isEmpty &&
      !relatedToMyCourses;

  int get activeCount =>
      formats.length +
      languages.length +
      categories.length +
      authors.length +
      years.length +
      accessTypes.length +
      (relatedToMyCourses ? 1 : 0);

  LibraryFilters copyWith({
    Set<String>? formats,
    Set<String>? languages,
    Set<String>? categories,
    Set<String>? authors,
    Set<int>? years,
    Set<BookAccessType>? accessTypes,
    bool? relatedToMyCourses,
  }) {
    return LibraryFilters(
      formats: formats ?? this.formats,
      languages: languages ?? this.languages,
      categories: categories ?? this.categories,
      authors: authors ?? this.authors,
      years: years ?? this.years,
      accessTypes: accessTypes ?? this.accessTypes,
      relatedToMyCourses: relatedToMyCourses ?? this.relatedToMyCourses,
    );
  }
}

class LibraryState {
  const LibraryState({
    required this.explore,
    required this.items,
    required this.totalCount,
    this.nextCursor,
    this.query = '',
    this.filters = const LibraryFilters(),
    this.isSearching = false,
    this.isLoadingMore = false,
  });

  final LibraryExplore explore;
  final List<BookSummary> items;
  final int totalCount;
  final String? nextCursor;
  final String query;
  final LibraryFilters filters;
  final bool isSearching;
  final bool isLoadingMore;

  bool get hasMore => nextCursor != null;
  bool get showingExplore => query.trim().isEmpty && filters.isEmpty;

  LibraryState copyWith({
    LibraryExplore? explore,
    List<BookSummary>? items,
    int? totalCount,
    String? nextCursor,
    bool clearNextCursor = false,
    String? query,
    LibraryFilters? filters,
    bool? isSearching,
    bool? isLoadingMore,
  }) {
    return LibraryState(
      explore: explore ?? this.explore,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      nextCursor: clearNextCursor ? null : nextCursor ?? this.nextCursor,
      query: query ?? this.query,
      filters: filters ?? this.filters,
      isSearching: isSearching ?? this.isSearching,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

abstract interface class LibraryRepository {
  Future<LibraryExplore> explore({int limitPerSection = 8});

  Future<LibrarySearchPage> search({
    String? query,
    String? cursor,
    int limit = 20,
    LibraryFilters filters = const LibraryFilters(),
  });

  Future<BookDetail> getBookDetail({required int bookId});

  Future<BookFavoriteStatus> toggleFavorite({required int bookId});
}
