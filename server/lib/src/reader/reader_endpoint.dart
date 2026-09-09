import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'reader_service.dart';

class ReaderEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  final _service = ReaderService();

  Future<ReaderAsset> getReaderAsset(
    Session session, {
    required int bookId,
    required String format,
  }) => _service.getReaderAsset(session, bookId: bookId, format: format);

  Future<ReadingProgressSyncResult> syncProgress(
    Session session, {
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime clientUpdatedAt,
  }) => _service.syncProgress(
    session,
    bookId: bookId,
    progressPercent: progressPercent,
    currentLocation: currentLocation,
    clientUpdatedAt: clientUpdatedAt,
  );

  Future<ReadingProgress?> getProgress(
    Session session, {
    required int bookId,
  }) => _service.getProgress(session, bookId: bookId);

  Future<List<ReaderBookmark>> getBookmarks(
    Session session, {
    required int bookId,
  }) => _service.getBookmarks(session, bookId: bookId);

  Future<ReaderBookmark> addBookmark(
    Session session, {
    required int bookId,
    required String location,
    required String title,
  }) => _service.addBookmark(
    session,
    bookId: bookId,
    location: location,
    title: title,
  );

  Future<void> removeBookmark(
    Session session, {
    required int bookmarkId,
  }) => _service.removeBookmark(session, bookmarkId: bookmarkId);

  Future<List<ReaderNote>> getNotes(
    Session session, {
    required int bookId,
  }) => _service.getNotes(session, bookId: bookId);

  Future<ReaderNote> saveNote(
    Session session, {
    required int bookId,
    required String location,
    required String content,
    int? noteId,
  }) => _service.saveNote(
    session,
    bookId: bookId,
    location: location,
    content: content,
    noteId: noteId,
  );

  Future<void> deleteNote(
    Session session, {
    required int noteId,
  }) => _service.deleteNote(session, noteId: noteId);

  Future<List<ReaderHighlight>> getHighlights(
    Session session, {
    required int bookId,
  }) => _service.getHighlights(session, bookId: bookId);

  Future<ReaderHighlight> addHighlight(
    Session session, {
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
  }) => _service.addHighlight(
    session,
    bookId: bookId,
    location: location,
    text: text,
    colorToken: colorToken,
  );

  Future<void> removeHighlight(
    Session session, {
    required int highlightId,
  }) => _service.removeHighlight(session, highlightId: highlightId);
}
