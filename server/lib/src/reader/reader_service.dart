import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import '../lending/lending_service.dart';
import '../library/book_access_policy_service.dart';

class ReaderService {
  ReaderService({
    BookAccessPolicyService? policy,
    LendingService? lending,
  }) : _policy = policy ?? BookAccessPolicyService(),
       _lending = lending ?? LendingService(policy: policy);

  final BookAccessPolicyService _policy;
  final LendingService _lending;

  Future<ReaderAsset> getReaderAsset(
    Session session, {
    required int bookId,
    required String format,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final book = await LibraryBook.db.findById(session, bookId);
    if (book == null || !book.isActive) {
      throw ServerpodClientException('Book not found', 404);
    }

    final activeLoan = await _lending.activeLoanForUserBook(
      session,
      userId: userId,
      bookId: bookId,
    );

    final decision = _policy.evaluateForSession(
      session,
      book,
      hasActiveLoan: activeLoan != null,
    );

    if (!decision.canRead) {
      throw ServerpodClientException(
        decision.reason ?? 'Bạn không có quyền đọc tài liệu này.',
        403,
      );
    }

    final normalizedFormat = format.trim().toLowerCase();
    final file = await LibraryBookFile.db.findFirstRow(
      session,
      where: (t) =>
          t.bookId.equals(bookId) & t.format.equals(normalizedFormat),
    );

    if (file == null) {
      throw ServerpodClientException(
        'Tài liệu chưa hỗ trợ định dạng $format.',
        404,
      );
    }

    final now = CampusClock.nowUtc();
    final expiresAt = now.add(const Duration(minutes: 15));
    // Mint short-lived asset URL without exposing internal storage keys directly
    final assetUrl = '/api/assets/$bookId/$normalizedFormat?expires=${expiresAt.millisecondsSinceEpoch}';

    return ReaderAsset(
      bookId: bookId,
      format: normalizedFormat,
      assetUrl: assetUrl,
      expiresAt: expiresAt,
    );
  }

  Future<ReadingProgressSyncResult> syncProgress(
    Session session, {
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime clientUpdatedAt,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final book = await LibraryBook.db.findById(session, bookId);
    if (book == null || !book.isActive) {
      throw ServerpodClientException('Book not found', 404);
    }

    final activeLoan = await _lending.activeLoanForUserBook(
      session,
      userId: userId,
      bookId: bookId,
    );

    final decision = _policy.evaluateForSession(
      session,
      book,
      hasActiveLoan: activeLoan != null,
    );

    if (!decision.canRead) {
      throw ServerpodClientException(
        decision.reason ?? 'Bạn không có quyền đọc tài liệu này.',
        403,
      );
    }

    final existing = await ReadingProgress.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.bookId.equals(bookId),
    );

    if (existing != null) {
      if (!ReadingProgressSync.shouldClientWin(
        clientUpdatedAt: clientUpdatedAt,
        serverUpdatedAt: existing.updatedAt,
      )) {
        return ReadingProgressSyncResult(
          bookId: bookId,
          progressPercent: existing.progressPercent,
          currentLocation: existing.currentLocation,
          updatedAt: existing.updatedAt,
          appliedClientUpdate: false,
        );
      }

      final updated = await ReadingProgress.db.updateRow(
        session,
        existing.copyWith(
          progressPercent: progressPercent.clamp(0.0, 100.0),
          currentLocation: currentLocation,
          updatedAt: clientUpdatedAt.toUtc(),
        ),
      );

      return ReadingProgressSyncResult(
        bookId: bookId,
        progressPercent: updated.progressPercent,
        currentLocation: updated.currentLocation,
        updatedAt: updated.updatedAt,
        appliedClientUpdate: true,
      );
    }

    final inserted = await ReadingProgress.db.insertRow(
      session,
      ReadingProgress(
        userId: userId,
        bookId: bookId,
        progressPercent: progressPercent.clamp(0.0, 100.0),
        currentLocation: currentLocation,
        updatedAt: clientUpdatedAt.toUtc(),
      ),
    );

    return ReadingProgressSyncResult(
      bookId: bookId,
      progressPercent: inserted.progressPercent,
      currentLocation: inserted.currentLocation,
      updatedAt: inserted.updatedAt,
      appliedClientUpdate: true,
    );
  }

  Future<ReadingProgress?> getProgress(
    Session session, {
    required int bookId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    return ReadingProgress.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.bookId.equals(bookId),
    );
  }

  Future<List<ReaderBookmark>> getBookmarks(
    Session session, {
    required int bookId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    return ReaderBookmark.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.bookId.equals(bookId),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<ReaderBookmark> addBookmark(
    Session session, {
    required int bookId,
    required String location,
    required String title,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final now = CampusClock.nowUtc();
    return ReaderBookmark.db.insertRow(
      session,
      ReaderBookmark(
        userId: userId,
        bookId: bookId,
        location: location,
        title: title.trim().isEmpty ? 'Trang đánh dấu' : title.trim(),
        createdAt: now,
      ),
    );
  }

  Future<void> removeBookmark(
    Session session, {
    required int bookmarkId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final bookmark = await ReaderBookmark.db.findById(session, bookmarkId);
    if (bookmark != null && bookmark.userId.toString() == userId.toString()) {
      await ReaderBookmark.db.deleteRow(session, bookmark);
    }
  }

  Future<List<ReaderNote>> getNotes(
    Session session, {
    required int bookId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    return ReaderNote.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.bookId.equals(bookId),
      orderBy: (t) => t.updatedAt,
    );
  }

  Future<ReaderNote> saveNote(
    Session session, {
    required int bookId,
    required String location,
    required String content,
    int? noteId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final now = CampusClock.nowUtc();
    if (noteId != null) {
      final existing = await ReaderNote.db.findById(session, noteId);
      if (existing == null || existing.userId.toString() != userId.toString()) {
        throw ServerpodClientException('Không tìm thấy ghi chú hoặc không có quyền sửa.', 403);
      }
      return ReaderNote.db.updateRow(
        session,
        existing.copyWith(
          location: location,
          content: content,
          updatedAt: now,
        ),
      );
    }

    return ReaderNote.db.insertRow(
      session,
      ReaderNote(
        userId: userId,
        bookId: bookId,
        location: location,
        content: content,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> deleteNote(
    Session session, {
    required int noteId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final note = await ReaderNote.db.findById(session, noteId);
    if (note != null && note.userId.toString() == userId.toString()) {
      await ReaderNote.db.deleteRow(session, note);
    }
  }

  Future<List<ReaderHighlight>> getHighlights(
    Session session, {
    required int bookId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    return ReaderHighlight.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.bookId.equals(bookId),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<ReaderHighlight> addHighlight(
    Session session, {
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final now = CampusClock.nowUtc();
    return ReaderHighlight.db.insertRow(
      session,
      ReaderHighlight(
        userId: userId,
        bookId: bookId,
        location: location,
        text: text,
        colorToken: colorToken,
        createdAt: now,
      ),
    );
  }

  Future<void> removeHighlight(
    Session session, {
    required int highlightId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final highlight = await ReaderHighlight.db.findById(session, highlightId);
    if (highlight != null && highlight.userId.toString() == userId.toString()) {
      await ReaderHighlight.db.deleteRow(session, highlight);
    }
  }
}
