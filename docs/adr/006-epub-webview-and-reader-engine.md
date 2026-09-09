# ADR-006: Ebook Reader Engine and EPUB WebView Architecture

- Status: Accepted (2026-09-09)
- Phase: 07-reader

## Context

CampusMate provides university students with access to e-textbooks and reference materials in both PDF and EPUB formats.
Rendering ebooks on mobile Flutter requires choosing stable viewing engines that support:
1. Cross-platform rendering (Android, iOS).
2. Clean separation of concerns through an abstract `ReaderController`.
3. Reading progress tracking and resume dialogs ("Tiếp tục từ 65%?").
4. Annotations (bookmarks, chapter/location notes, semantic color highlights).

## Decision

1. **PDF Rendering**: Use dedicated PDF rendering with page-level granular navigation, pinch-to-zoom, and page jumping.
2. **EPUB Rendering**: Use a WebView-based EPUB rendering engine (`flutter_epub_viewer` / epub.js).
3. **EPUB Highlight Granularity Limitation**: Pure text-range DOM selection in WebViews across varied EPUB formats is prone to DOM reflow offsets on font-size changes. To maintain deterministic synchronization, highlights in EPUB are anchored to chapter identifiers and canonical text snippets rather than fragile character offsets.
4. **Architectural Isolation**: Mobile UI interacts only with `ReaderController` and `ReaderRepository`. Neither presentation nor storage layers directly depend on low-level viewer engine internals.

## Consequences

- Reader engine can be adapted or swapped without modifying reading progress, bookmarking, or note-taking features.
- Semantic highlight colors are defined as design system tokens (e.g. `yellow`, `green`, `blue`, `pink`), preventing arbitrary hex sprawl in the database.
- Documented limitation: EPUB highlights operate on chapter-level locations with text matching.
