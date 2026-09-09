class DocumentChunkDraft {
  const DocumentChunkDraft({
    required this.title,
    required this.content,
    this.chapter,
    this.page,
  });

  final String title;
  final String content;
  final String? chapter;
  final int? page;

  @override
  String toString() =>
      'DocumentChunkDraft(title: $title, chapter: $chapter, page: $page, length: ${content.length})';
}

/// Chunks document text with paragraph/sentence boundary awareness,
/// chapter/page metadata detection, and configurable size/overlap limits.
class DocumentChunker {
  const DocumentChunker({
    this.targetChunkSize = 600,
    this.maxChunkSize = 1000,
    this.chunkOverlap = 100,
    this.maxChunks = 500,
  });

  final int targetChunkSize;
  final int maxChunkSize;
  final int chunkOverlap;
  final int maxChunks;

  static final RegExp _chapterPattern = RegExp(
    r'^(?:Chương|Bài|Phần|Chapter|Section)\s+([0-9IVXLCDM]+)(?:\s*[:\.-]\s*(.+))?$',
    caseSensitive: false,
  );

  static final RegExp _pageMarkerPattern = RegExp(
    r'(?:\[(?:Trang|Page)\s*(\d+)\]|---\s*(?:Trang|Page)\s*(\d+)\s*---)',
    caseSensitive: false,
  );

  /// Splits [fullText] into a list of [DocumentChunkDraft] items.
  List<DocumentChunkDraft> chunk({
    required String fullText,
    required String defaultTitle,
    String? initialChapter,
    int? initialPage,
  }) {
    final trimmed = fullText.trim();
    if (trimmed.isEmpty) return const [];

    final rawLines = trimmed.split('\n');
    final chunks = <DocumentChunkDraft>[];

    String? currentChapter = initialChapter;
    int? currentPage = initialPage;
    final buffer = StringBuffer();
    String lastOverlap = '';

    void flushChunk() {
      final text = buffer.toString().trim();
      if (text.isEmpty) return;

      chunks.add(
        DocumentChunkDraft(
          title: defaultTitle,
          content: text,
          chapter: currentChapter,
          page: currentPage,
        ),
      );

      // Preserve trailing overlap for context continuity.
      if (chunkOverlap > 0 && text.length > chunkOverlap) {
        lastOverlap = text.substring(text.length - chunkOverlap).trim();
      } else {
        lastOverlap = '';
      }

      buffer.clear();
      if (lastOverlap.isNotEmpty) {
        buffer.write('$lastOverlap\n');
      }
    }

    for (final line in rawLines) {
      if (chunks.length >= maxChunks) break;

      final trimmedLine = line.trim();
      if (trimmedLine.isEmpty) {
        if (buffer.length >= targetChunkSize) {
          flushChunk();
        }
        continue;
      }

      // Check for page markers
      final pageMatch = _pageMarkerPattern.firstMatch(trimmedLine);
      if (pageMatch != null) {
        final pageNumStr = pageMatch.group(1) ?? pageMatch.group(2);
        if (pageNumStr != null) {
          currentPage = int.tryParse(pageNumStr) ?? currentPage;
        }
      }

      // Check for chapter headings
      final chapterMatch = _chapterPattern.firstMatch(trimmedLine);
      if (chapterMatch != null) {
        if (buffer.isNotEmpty) {
          flushChunk();
        }
        currentChapter = trimmedLine;
        continue;
      }

      if (buffer.length + trimmedLine.length + 1 > maxChunkSize) {
        flushChunk();
      }

      if (buffer.isNotEmpty && !buffer.toString().endsWith('\n')) {
        buffer.write(' ');
      }
      buffer.write(trimmedLine);
    }

    if (buffer.isNotEmpty && chunks.length < maxChunks) {
      final remaining = buffer.toString().trim();
      if (remaining.isNotEmpty && remaining != lastOverlap) {
        chunks.add(
          DocumentChunkDraft(
            title: defaultTitle,
            content: remaining,
            chapter: currentChapter,
            page: currentPage,
          ),
        );
      }
    }

    return chunks;
  }
}
