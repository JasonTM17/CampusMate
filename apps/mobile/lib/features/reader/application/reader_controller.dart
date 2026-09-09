import 'dart:async';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/reader_repository.dart';

enum ReaderThemeMode { light, dark, sepia }

class ReaderState {
  const ReaderState({
    this.bookId = 0,
    this.format = 'pdf',
    this.isLoading = true,
    this.errorMessage,
    this.asset,
    this.progressPercent = 0.0,
    this.currentLocation = '1',
    this.lastSyncedAt,
    this.showResumePrompt = false,
    this.savedProgressPercent = 0.0,
    this.savedLocation = '1',
    this.bookmarks = const [],
    this.notes = const [],
    this.highlights = const [],
    this.themeMode = ReaderThemeMode.light,
    this.fontSize = 16.0,
  });

  final int bookId;
  final String format;
  final bool isLoading;
  final String? errorMessage;
  final ReaderAsset? asset;
  final double progressPercent;
  final String currentLocation;
  final DateTime? lastSyncedAt;
  final bool showResumePrompt;
  final double savedProgressPercent;
  final String savedLocation;
  final List<ReaderBookmark> bookmarks;
  final List<ReaderNote> notes;
  final List<ReaderHighlight> highlights;
  final ReaderThemeMode themeMode;
  final double fontSize;

  ReaderState copyWith({
    int? bookId,
    String? format,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
    ReaderAsset? asset,
    double? progressPercent,
    String? currentLocation,
    DateTime? lastSyncedAt,
    bool? showResumePrompt,
    double? savedProgressPercent,
    String? savedLocation,
    List<ReaderBookmark>? bookmarks,
    List<ReaderNote>? notes,
    List<ReaderHighlight>? highlights,
    ReaderThemeMode? themeMode,
    double? fontSize,
  }) {
    return ReaderState(
      bookId: bookId ?? this.bookId,
      format: format ?? this.format,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      asset: asset ?? this.asset,
      progressPercent: progressPercent ?? this.progressPercent,
      currentLocation: currentLocation ?? this.currentLocation,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      showResumePrompt: showResumePrompt ?? this.showResumePrompt,
      savedProgressPercent: savedProgressPercent ?? this.savedProgressPercent,
      savedLocation: savedLocation ?? this.savedLocation,
      bookmarks: bookmarks ?? this.bookmarks,
      notes: notes ?? this.notes,
      highlights: highlights ?? this.highlights,
      themeMode: themeMode ?? this.themeMode,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}

final readerControllerProvider =
    NotifierProvider<ReaderController, ReaderState>(
      ReaderController.new,
    );

class ReaderController extends Notifier<ReaderState> {
  ReaderRepository get _repository => ref.read(readerRepositoryProvider);

  @override
  ReaderState build() => const ReaderState();

  Future<void> openBook({required int bookId, required String format}) async {
    state = state.copyWith(
      bookId: bookId,
      format: format,
      isLoading: true,
      clearErrorMessage: true,
    );
    await initialize();
  }

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final assetFuture = _repository.getReaderAsset(
        bookId: state.bookId,
        format: state.format,
      );
      final progressFuture = _repository.getProgress(bookId: state.bookId);
      final bookmarksFuture = _repository.getBookmarks(bookId: state.bookId);
      final notesFuture = _repository.getNotes(bookId: state.bookId);
      final highlightsFuture = _repository.getHighlights(bookId: state.bookId);

      final results = await Future.wait<dynamic>([
        assetFuture,
        progressFuture,
        bookmarksFuture,
        notesFuture,
        highlightsFuture,
      ]);

      final asset = results[0] as ReaderAsset;
      final savedProgress = results[1] as ReadingProgress?;
      final bookmarks = results[2] as List<ReaderBookmark>;
      final notes = results[3] as List<ReaderNote>;
      final highlights = results[4] as List<ReaderHighlight>;

      final hasProgressToResume =
          savedProgress != null &&
          savedProgress.progressPercent > 5.0 &&
          savedProgress.currentLocation.isNotEmpty;

      state = state.copyWith(
        isLoading: false,
        asset: asset,
        bookmarks: bookmarks,
        notes: notes,
        highlights: highlights,
        showResumePrompt: hasProgressToResume,
        savedProgressPercent: savedProgress?.progressPercent ?? 0.0,
        savedLocation: savedProgress?.currentLocation ?? '1',
        progressPercent: hasProgressToResume ? 0.0 : (savedProgress?.progressPercent ?? 0.0),
        currentLocation: hasProgressToResume ? '1' : (savedProgress?.currentLocation ?? '1'),
        lastSyncedAt: savedProgress?.updatedAt,
      );
    } on ServerpodClientException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } on Object {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Không thể mở tài liệu. Vui lòng kiểm tra lại.',
      );
    }
  }

  void dismissResumePrompt() {
    state = state.copyWith(showResumePrompt: false);
  }

  void resumeFromSavedProgress() {
    state = state.copyWith(
      showResumePrompt: false,
      currentLocation: state.savedLocation,
      progressPercent: state.savedProgressPercent,
    );
    unawaited(syncProgressNow());
  }

  void updateLocation({
    required String location,
    required double progressPercent,
  }) {
    state = state.copyWith(
      currentLocation: location,
      progressPercent: progressPercent.clamp(0.0, 100.0),
    );
  }

  Future<void> syncProgressNow() async {
    final clientTime = DateTime.now().toUtc();
    try {
      final syncResult = await _repository.syncProgress(
        bookId: state.bookId,
        progressPercent: state.progressPercent,
        currentLocation: state.currentLocation,
        clientUpdatedAt: clientTime,
      );

      if (!syncResult.appliedClientUpdate) {
        state = state.copyWith(
          progressPercent: syncResult.progressPercent,
          currentLocation: syncResult.currentLocation,
          lastSyncedAt: syncResult.updatedAt,
        );
      } else {
        state = state.copyWith(lastSyncedAt: syncResult.updatedAt);
      }
    } on Object {
      // Keep local progress on network failure
    }
  }

  void setThemeMode(ReaderThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void setFontSize(double size) {
    state = state.copyWith(fontSize: size.clamp(12.0, 28.0));
  }

  Future<void> addBookmark({required String title}) async {
    try {
      final bookmark = await _repository.addBookmark(
        bookId: state.bookId,
        location: state.currentLocation,
        title: title,
      );
      state = state.copyWith(bookmarks: [...state.bookmarks, bookmark]);
    } on Object {
      // Handle error
    }
  }

  Future<void> removeBookmark(int bookmarkId) async {
    try {
      await _repository.removeBookmark(bookmarkId: bookmarkId);
      state = state.copyWith(
        bookmarks: state.bookmarks.where((b) => b.id != bookmarkId).toList(),
      );
    } on Object {
      // Handle error
    }
  }

  Future<void> saveNote({required String content, int? noteId}) async {
    try {
      final note = await _repository.saveNote(
        bookId: state.bookId,
        location: state.currentLocation,
        content: content,
        noteId: noteId,
      );
      if (noteId != null) {
        state = state.copyWith(
          notes: state.notes.map((n) => n.id == noteId ? note : n).toList(),
        );
      } else {
        state = state.copyWith(notes: [...state.notes, note]);
      }
    } on Object {
      // Handle error
    }
  }

  Future<void> deleteNote(int noteId) async {
    try {
      await _repository.deleteNote(noteId: noteId);
      state = state.copyWith(
        notes: state.notes.where((n) => n.id != noteId).toList(),
      );
    } on Object {
      // Handle error
    }
  }

  Future<void> addHighlight({
    required String text,
    required String colorToken,
  }) async {
    try {
      final highlight = await _repository.addHighlight(
        bookId: state.bookId,
        location: state.currentLocation,
        text: text,
        colorToken: colorToken,
      );
      state = state.copyWith(highlights: [...state.highlights, highlight]);
    } on Object {
      // Handle error
    }
  }

  Future<void> removeHighlight(int highlightId) async {
    try {
      await _repository.removeHighlight(highlightId: highlightId);
      state = state.copyWith(
        highlights: state.highlights.where((h) => h.id != highlightId).toList(),
      );
    } on Object {
      // Handle error
    }
  }
}
