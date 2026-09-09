import 'package:campusmate_client/campusmate_client.dart';

import '../domain/reader_repository.dart';

class ServerpodReaderRepository implements ReaderRepository {
  const ServerpodReaderRepository(this._client);

  final Client _client;

  @override
  Future<ReaderAsset> getReaderAsset({
    required int bookId,
    required String format,
  }) => _client.reader.getReaderAsset(bookId: bookId, format: format);

  @override
  Future<ReadingProgressSyncResult> syncProgress({
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime clientUpdatedAt,
  }) => _client.reader.syncProgress(
    bookId: bookId,
    progressPercent: progressPercent,
    currentLocation: currentLocation,
    clientUpdatedAt: clientUpdatedAt,
  );

  @override
  Future<ReadingProgress?> getProgress({required int bookId}) =>
      _client.reader.getProgress(bookId: bookId);

  @override
  Future<List<ReaderBookmark>> getBookmarks({required int bookId}) =>
      _client.reader.getBookmarks(bookId: bookId);

  @override
  Future<ReaderBookmark> addBookmark({
    required int bookId,
    required String location,
    required String title,
  }) => _client.reader.addBookmark(
    bookId: bookId,
    location: location,
    title: title,
  );

  @override
  Future<void> removeBookmark({required int bookmarkId}) =>
      _client.reader.removeBookmark(bookmarkId: bookmarkId);

  @override
  Future<List<ReaderNote>> getNotes({required int bookId}) =>
      _client.reader.getNotes(bookId: bookId);

  @override
  Future<ReaderNote> saveNote({
    required int bookId,
    required String location,
    required String content,
    int? noteId,
  }) => _client.reader.saveNote(
    bookId: bookId,
    location: location,
    content: content,
    noteId: noteId,
  );

  @override
  Future<void> deleteNote({required int noteId}) =>
      _client.reader.deleteNote(noteId: noteId);

  @override
  Future<List<ReaderHighlight>> getHighlights({required int bookId}) =>
      _client.reader.getHighlights(bookId: bookId);

  @override
  Future<ReaderHighlight> addHighlight({
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
  }) => _client.reader.addHighlight(
    bookId: bookId,
    location: location,
    text: text,
    colorToken: colorToken,
  );

  @override
  Future<void> removeHighlight({required int highlightId}) =>
      _client.reader.removeHighlight(highlightId: highlightId);
}
