import 'package:campusmate_client/campusmate_client.dart';

import '../domain/library_repository.dart';

class ServerpodLibraryRepository implements LibraryRepository {
  const ServerpodLibraryRepository(this._client);

  final Client _client;

  @override
  Future<LibraryExplore> explore({int limitPerSection = 8}) =>
      _client.library.explore(limitPerSection: limitPerSection);

  @override
  Future<LibrarySearchPage> search({
    String? query,
    String? cursor,
    int limit = 20,
    LibraryFilters filters = const LibraryFilters(),
  }) {
    return _client.library.search(
      query: query,
      cursor: cursor,
      limit: limit,
      formats: _sortedStrings(filters.formats),
      languages: _sortedStrings(filters.languages),
      categories: _sortedStrings(filters.categories),
      authors: _sortedStrings(filters.authors),
      years: _sortedInts(filters.years),
      accessTypes: _sortedAccessTypes(filters.accessTypes),
      relatedToMyCourses: filters.relatedToMyCourses,
    );
  }

  @override
  Future<BookDetail> getBookDetail({required int bookId}) =>
      _client.library.getBookDetail(bookId: bookId);

  @override
  Future<BookFavoriteStatus> toggleFavorite({required int bookId}) =>
      _client.library.toggleFavorite(bookId: bookId);
}

List<String>? _sortedStrings(Set<String> values) {
  if (values.isEmpty) return null;
  final sorted = values.toList()..sort();
  return sorted;
}

List<int>? _sortedInts(Set<int> values) {
  if (values.isEmpty) return null;
  final sorted = values.toList()..sort((a, b) => b.compareTo(a));
  return sorted;
}

List<BookAccessType>? _sortedAccessTypes(Set<BookAccessType> values) {
  if (values.isEmpty) return null;
  final sorted = values.toList()..sort((a, b) => a.name.compareTo(b.name));
  return sorted;
}
