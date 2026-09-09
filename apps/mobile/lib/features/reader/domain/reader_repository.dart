import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../data/serverpod_reader_repository.dart';

abstract class ReaderRepository {
  Future<ReaderAsset> getReaderAsset({
    required int bookId,
    required String format,
  });

  Future<ReadingProgressSyncResult> syncProgress({
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime clientUpdatedAt,
  });

  Future<ReadingProgress?> getProgress({required int bookId});

  Future<List<ReaderBookmark>> getBookmarks({required int bookId});

  Future<ReaderBookmark> addBookmark({
    required int bookId,
    required String location,
    required String title,
  });

  Future<void> removeBookmark({required int bookmarkId});

  Future<List<ReaderNote>> getNotes({required int bookId});

  Future<ReaderNote> saveNote({
    required int bookId,
    required String location,
    required String content,
    int? noteId,
  });

  Future<void> deleteNote({required int noteId});

  Future<List<ReaderHighlight>> getHighlights({required int bookId});

  Future<ReaderHighlight> addHighlight({
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
  });

  Future<void> removeHighlight({required int highlightId});
}

final readerRepositoryProvider = Provider<ReaderRepository>((ref) {
  return ServerpodReaderRepository(ref.watch(serverpodClientProvider));
});
