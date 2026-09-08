import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'library_catalog_service.dart';

class LibraryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  final _service = LibraryCatalogService();

  Future<LibraryExplore> explore(
    Session session, {
    int limitPerSection = 8,
  }) => _service.explore(session, limitPerSection: limitPerSection);

  Future<LibrarySearchPage> search(
    Session session, {
    String? query,
    String? cursor,
    int limit = 20,
    List<String>? formats,
    List<String>? languages,
    List<String>? categories,
    List<String>? authors,
    List<int>? years,
    List<BookAccessType>? accessTypes,
    bool relatedToMyCourses = false,
  }) => _service.search(
    session,
    query: query,
    cursor: cursor,
    limit: limit,
    formats: formats,
    languages: languages,
    categories: categories,
    authors: authors,
    years: years,
    accessTypes: accessTypes,
    relatedToMyCourses: relatedToMyCourses,
  );

  Future<BookDetail> getBookDetail(
    Session session, {
    required int bookId,
  }) => _service.getBookDetail(session, bookId: bookId);

  Future<BookFavoriteStatus> toggleFavorite(
    Session session, {
    required int bookId,
  }) => _service.toggleFavorite(session, bookId: bookId);
}
