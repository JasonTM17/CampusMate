class ReadingProgressState {
  const ReadingProgressState({
    required this.bookId,
    required this.progressPercent,
    required this.currentLocation,
    required this.updatedAt,
  });

  final int bookId;
  final double progressPercent;
  final String currentLocation;
  final DateTime updatedAt;

  ReadingProgressState copyWith({
    int? bookId,
    double? progressPercent,
    String? currentLocation,
    DateTime? updatedAt,
  }) {
    return ReadingProgressState(
      bookId: bookId ?? this.bookId,
      progressPercent: progressPercent ?? this.progressPercent,
      currentLocation: currentLocation ?? this.currentLocation,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ReadingProgressSync {
  const ReadingProgressSync._();

  /// Determines whether a client update should overwrite the server record
  /// based on Last-Write-Wins (LWW) conflict resolution.
  static bool shouldClientWin({
    required DateTime clientUpdatedAt,
    required DateTime serverUpdatedAt,
  }) {
    return clientUpdatedAt.toUtc().isAfter(serverUpdatedAt.toUtc());
  }

  /// Resolves conflict between local and remote reading progress using LWW.
  static ReadingProgressState resolveLww({
    required ReadingProgressState local,
    required ReadingProgressState remote,
  }) {
    if (local.updatedAt.toUtc().isAfter(remote.updatedAt.toUtc())) {
      return local;
    }
    return remote;
  }
}
