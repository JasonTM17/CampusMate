import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

Future<void> seedLibraryDemoData(Session session) async {
  final now = CampusClock.nowUtc();
  final courseByCode = {
    for (final course in await Course.db.find(session, limit: 500))
      course.code: course,
  };

  for (var index = 0; index < _bookSeeds.length; index++) {
    final seed = _bookSeeds[index];
    final authors = <LibraryAuthor>[];
    for (final authorName in seed.authors) {
      authors.add(await _ensureAuthor(session, authorName, now));
    }
    final categories = <LibraryCategory>[];
    for (final categoryName in seed.categories) {
      categories.add(await _ensureCategory(session, categoryName, now));
    }
    final linkedCourses = [
      for (final code in seed.courseCodes)
        if (courseByCode[code] != null) courseByCode[code]!,
    ];
    final book = await _ensureBook(
      session,
      seed,
      now,
      searchText: _searchText(seed, authors, categories, linkedCourses),
      rank: index + 1,
    );
    await _ensureAuthorLinks(session, book, authors);
    await _ensureCategoryLinks(session, book, categories);
    await _ensureCourseLinks(session, book, linkedCourses);
    await _ensureFiles(session, book, seed, now);
    await _ensureCopies(session, book, seed, now);
  }
}

Future<LibraryAuthor> _ensureAuthor(
  Session session,
  String displayName,
  DateTime now,
) async {
  final normalizedName = _slug(displayName);
  final existing = await LibraryAuthor.db.findFirstRow(
    session,
    where: (t) => t.normalizedName.equals(normalizedName),
  );
  if (existing != null) {
    return LibraryAuthor.db.updateRow(
      session,
      existing.copyWith(displayName: displayName, updatedAt: now),
    );
  }
  return LibraryAuthor.db.insertRow(
    session,
    LibraryAuthor(
      displayName: displayName,
      normalizedName: normalizedName,
      biography: null,
      createdAt: now,
      updatedAt: now,
    ),
  );
}

Future<LibraryCategory> _ensureCategory(
  Session session,
  String name,
  DateTime now,
) async {
  final slug = _slug(name);
  final existing = await LibraryCategory.db.findFirstRow(
    session,
    where: (t) => t.slug.equals(slug),
  );
  if (existing != null) {
    return LibraryCategory.db.updateRow(
      session,
      existing.copyWith(name: name, updatedAt: now),
    );
  }
  return LibraryCategory.db.insertRow(
    session,
    LibraryCategory(
      name: name,
      slug: slug,
      description: null,
      createdAt: now,
      updatedAt: now,
    ),
  );
}

Future<LibraryBook> _ensureBook(
  Session session,
  _BookSeed seed,
  DateTime now, {
  required String searchText,
  required int rank,
}) async {
  final existing = await LibraryBook.db.findFirstRow(
    session,
    where: (t) => t.isbn.equals(seed.isbn),
  );
  final featuredRank = rank <= 12 ? rank : null;
  final popularityScore = 200 - rank * 3;
  if (existing != null) {
    return LibraryBook.db.updateRow(
      session,
      existing.copyWith(
        title: seed.title,
        subtitle: seed.subtitle,
        description: seed.description,
        publisher: seed.publisher,
        publishedYear: seed.year,
        language: seed.language,
        coverUrl: seed.coverUrl,
        accessType: seed.accessType,
        license: seed.license,
        licenseExpiresAt: null,
        keywords: seed.keywords.join(', '),
        searchText: searchText,
        popularityScore: popularityScore,
        featuredRank: featuredRank,
        isActive: true,
        updatedAt: now,
      ),
    );
  }
  return LibraryBook.db.insertRow(
    session,
    LibraryBook(
      title: seed.title,
      subtitle: seed.subtitle,
      description: seed.description,
      isbn: seed.isbn,
      publisher: seed.publisher,
      publishedYear: seed.year,
      language: seed.language,
      coverUrl: seed.coverUrl,
      accessType: seed.accessType,
      license: seed.license,
      licenseExpiresAt: null,
      keywords: seed.keywords.join(', '),
      searchText: searchText,
      popularityScore: popularityScore,
      featuredRank: featuredRank,
      isActive: true,
      createdAt: now.subtract(Duration(days: rank)),
      updatedAt: now,
    ),
  );
}

Future<void> _ensureAuthorLinks(
  Session session,
  LibraryBook book,
  List<LibraryAuthor> authors,
) async {
  for (final author in authors) {
    final existing = await LibraryBookAuthor.db.findFirstRow(
      session,
      where: (t) => t.bookId.equals(book.id!) & t.authorId.equals(author.id!),
    );
    if (existing != null) continue;
    await LibraryBookAuthor.db.insertRow(
      session,
      LibraryBookAuthor(bookId: book.id!, authorId: author.id!),
    );
  }
}

Future<void> _ensureCategoryLinks(
  Session session,
  LibraryBook book,
  List<LibraryCategory> categories,
) async {
  for (final category in categories) {
    final existing = await LibraryBookCategory.db.findFirstRow(
      session,
      where: (t) =>
          t.bookId.equals(book.id!) & t.categoryId.equals(category.id!),
    );
    if (existing != null) continue;
    await LibraryBookCategory.db.insertRow(
      session,
      LibraryBookCategory(bookId: book.id!, categoryId: category.id!),
    );
  }
}

Future<void> _ensureCourseLinks(
  Session session,
  LibraryBook book,
  List<Course> courses,
) async {
  for (final course in courses) {
    final existing = await LibraryBookCourse.db.findFirstRow(
      session,
      where: (t) => t.bookId.equals(book.id!) & t.courseId.equals(course.id!),
    );
    if (existing != null) continue;
    await LibraryBookCourse.db.insertRow(
      session,
      LibraryBookCourse(bookId: book.id!, courseId: course.id!),
    );
  }
}

Future<void> _ensureFiles(
  Session session,
  LibraryBook book,
  _BookSeed seed,
  DateTime now,
) async {
  for (final format in seed.formats) {
    final existing = await LibraryBookFile.db.findFirstRow(
      session,
      where: (t) => t.bookId.equals(book.id!) & t.format.equals(format),
    );
    final file = LibraryBookFile(
      id: existing?.id,
      bookId: book.id!,
      format: format,
      storageKey: 'demo/library/${book.id}/primary.$format',
      byteSize: format == 'pdf' ? 740000 : 420000,
      checksum: 'demo-${seed.isbn}-$format',
      isPrimary: format == seed.formats.first,
      createdAt: existing?.createdAt ?? now,
    );
    if (existing == null) {
      await LibraryBookFile.db.insertRow(session, file);
    } else {
      await LibraryBookFile.db.updateRow(session, file);
    }
  }
}

Future<void> _ensureCopies(
  Session session,
  LibraryBook book,
  _BookSeed seed,
  DateTime now,
) async {
  if (seed.accessType != BookAccessType.borrowRequired) return;
  for (var index = 1; index <= 2; index++) {
    final barcode = 'CM-${seed.isbn}-C${index.toString().padLeft(2, '0')}';
    final existing = await BookCopy.db.findFirstRow(
      session,
      where: (t) => t.barcode.equals(barcode),
    );
    if (existing == null) {
      await BookCopy.db.insertRow(
        session,
        BookCopy(
          bookId: book.id!,
          barcode: barcode,
          status: BookCopyStatus.available,
          createdAt: now,
          updatedAt: now,
        ),
      );
      continue;
    }
    if (existing.bookId != book.id!) {
      await BookCopy.db.updateRow(
        session,
        existing.copyWith(bookId: book.id!, updatedAt: now),
      );
    }
  }
}

String _searchText(
  _BookSeed seed,
  List<LibraryAuthor> authors,
  List<LibraryCategory> categories,
  List<Course> courses,
) {
  return [
    seed.title,
    seed.subtitle,
    seed.description,
    seed.isbn,
    seed.publisher,
    seed.language,
    ...seed.keywords,
    ...authors.map((row) => row.displayName),
    ...categories.map((row) => row.name),
    ...courses.expand((course) => [course.code, course.title]),
  ].whereType<String>().join(' ').toLowerCase();
}

String _slug(String value) {
  return value
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
}

const _campusLicense = 'CampusMate self-created demo notes';
const _publicDomainLicense = 'Public domain metadata demo';

final _bookSeeds = <_BookSeed>[
  _BookSeed(
    title: 'CampusMate Notes: Mobile App Architecture',
    subtitle: 'Client-server patterns for student projects',
    description:
        'Self-created demo notes about Flutter, API boundaries, and offline cache decisions.',
    isbn: 'CM-SE214-001',
    publisher: 'CampusMate Lab',
    year: 2026,
    language: 'en',
    accessType: BookAccessType.publicFullText,
    license: _campusLicense,
    authors: ['CampusMate Lab'],
    categories: ['Mobile Development', 'Software Engineering'],
    courseCodes: ['SE214', 'SE101'],
    keywords: ['flutter', 'mobile', 'offline', 'architecture'],
    formats: ['pdf', 'epub'],
  ),
  _BookSeed(
    title: 'CampusMate Notes: Dart Testing Playbook',
    description:
        'Self-created guide for unit, widget, and integration testing in Dart projects.',
    isbn: 'CM-QA260-002',
    publisher: 'CampusMate Lab',
    year: 2026,
    language: 'en',
    accessType: BookAccessType.authenticatedFullText,
    license: _campusLicense,
    authors: ['CampusMate QA Guild'],
    categories: ['Testing', 'Software Engineering'],
    courseCodes: ['QA260', 'SE101'],
    keywords: ['testing', 'dart', 'widget', 'regression'],
    formats: ['pdf'],
  ),
  _BookSeed(
    title: 'CampusMate Notes: Database Transactions',
    description:
        'Self-created notes on schema design, indexes, and transaction safety.',
    isbn: 'CM-DB202-003',
    publisher: 'CampusMate Lab',
    year: 2025,
    language: 'en',
    accessType: BookAccessType.borrowRequired,
    license: _campusLicense,
    authors: ['CampusMate Data Group'],
    categories: ['Database', 'Backend'],
    courseCodes: ['DB202'],
    keywords: ['database', 'sql', 'transactions', 'indexes'],
    formats: ['pdf', 'epub'],
  ),
  _BookSeed(
    title: 'CampusMate Notes: AI Study Assistant Safety',
    description:
        'Self-created overview of prompt boundaries, citations, and quota checks.',
    isbn: 'CM-AI301-004',
    publisher: 'CampusMate Lab',
    year: 2026,
    language: 'en',
    accessType: BookAccessType.metadataOnly,
    license: _campusLicense,
    authors: ['CampusMate AI Group'],
    categories: ['Artificial Intelligence', 'Security'],
    courseCodes: ['AI301', 'SEC310'],
    keywords: ['ai', 'prompt', 'safety', 'rag'],
    formats: [],
  ),
  _BookSeed(
    title: 'CampusMate Notes: Library Operations Restricted Dossier',
    description:
        'Self-created restricted metadata used to test librarian and admin policy boundaries.',
    isbn: 'CM-LIB-005',
    publisher: 'CampusMate Library',
    year: 2026,
    language: 'en',
    accessType: BookAccessType.restricted,
    license: _campusLicense,
    authors: ['CampusMate Library'],
    categories: ['Library Operations', 'Security'],
    courseCodes: ['SEC310'],
    keywords: ['restricted', 'policy', 'audit'],
    formats: ['pdf'],
  ),
  _BookSeed(
    title: 'Pride and Prejudice',
    description: 'Public-domain metadata entry for classic English reading.',
    isbn: 'PD-AUSTEN-1813',
    publisher: 'Public Domain Collection',
    year: 1813,
    language: 'en',
    accessType: BookAccessType.publicFullText,
    license: _publicDomainLicense,
    authors: ['Jane Austen'],
    categories: ['Literature', 'English'],
    courseCodes: ['ENG102'],
    keywords: ['classic', 'english', 'reading'],
    formats: ['epub'],
  ),
  _BookSeed(
    title: 'Frankenstein',
    description: 'Public-domain metadata entry for literature discussion.',
    isbn: 'PD-SHELLEY-1818',
    publisher: 'Public Domain Collection',
    year: 1818,
    language: 'en',
    accessType: BookAccessType.publicFullText,
    license: _publicDomainLicense,
    authors: ['Mary Shelley'],
    categories: ['Literature', 'English'],
    courseCodes: ['ENG102'],
    keywords: ['classic', 'ethics', 'reading'],
    formats: ['pdf', 'epub'],
  ),
  _BookSeed(
    title: 'The Art of War',
    description: 'Public-domain metadata entry for strategy and planning.',
    isbn: 'PD-SUN-TZU',
    publisher: 'Public Domain Collection',
    year: 1910,
    language: 'en',
    accessType: BookAccessType.publicFullText,
    license: _publicDomainLicense,
    authors: ['Sun Tzu'],
    categories: ['Project Management', 'Strategy'],
    courseCodes: ['PM250'],
    keywords: ['strategy', 'planning', 'risk'],
    formats: ['pdf'],
  ),
  ..._courseNoteSeeds,
];

final _courseNoteSeeds = [
  for (var i = 0; i < _courseBookTemplates.length; i++)
    _BookSeed(
      title: 'CampusMate Notes: ${_courseBookTemplates[i].title}',
      description: _courseBookTemplates[i].description,
      isbn:
          'CM-${_courseBookTemplates[i].courseCode}-${(i + 6).toString().padLeft(3, '0')}',
      publisher: 'CampusMate Lab',
      year: 2024 + (i % 3),
      language: i.isEven ? 'vi' : 'en',
      accessType: _courseBookTemplates[i].accessType,
      license: _campusLicense,
      authors: [_courseBookTemplates[i].author],
      categories: _courseBookTemplates[i].categories,
      courseCodes: [_courseBookTemplates[i].courseCode],
      keywords: _courseBookTemplates[i].keywords,
      formats: _courseBookTemplates[i].formats,
      coverUrl: i % 7 == 0
          ? null
          : 'https://picsum.photos/seed/campusmate-${i + 1}/240/320',
    ),
];

const _courseBookTemplates = [
  _CourseBookTemplate(
    'SE101',
    'Software Requirements Workbook',
    'Self-created workbook for scope, acceptance criteria, and release risk.',
    'CampusMate Software Guild',
    ['Software Engineering'],
    ['requirements', 'scope', 'acceptance'],
    ['pdf'],
    BookAccessType.authenticatedFullText,
  ),
  _CourseBookTemplate(
    'SE214',
    'Flutter Layout Field Guide',
    'Self-created examples for responsive Material 3 mobile layouts.',
    'CampusMate Mobile Guild',
    ['Mobile Development', 'UI UX'],
    ['flutter', 'layout', 'material'],
    ['pdf', 'epub'],
    BookAccessType.publicFullText,
  ),
  _CourseBookTemplate(
    'DB202',
    'Index Design Lab Notes',
    'Self-created notes for query planning, composite indexes, and cursors.',
    'CampusMate Data Group',
    ['Database', 'Backend'],
    ['index', 'cursor', 'pagination'],
    ['pdf'],
    BookAccessType.borrowRequired,
  ),
  _CourseBookTemplate(
    'AI301',
    'RAG Evaluation Notebook',
    'Self-created metadata for retrieval evaluation and citation review.',
    'CampusMate AI Group',
    ['Artificial Intelligence'],
    ['rag', 'retrieval', 'citation'],
    [],
    BookAccessType.metadataOnly,
  ),
  _CourseBookTemplate(
    'MATH101',
    'Discrete Math Practice Set',
    'Self-created exercise set for logic, relations, and graph thinking.',
    'CampusMate Math Desk',
    ['Mathematics'],
    ['logic', 'sets', 'graphs'],
    ['pdf'],
    BookAccessType.authenticatedFullText,
  ),
  _CourseBookTemplate(
    'NET204',
    'Networking Troubleshooting Primer',
    'Self-created notes for protocol layers and operational debugging.',
    'CampusMate Network Desk',
    ['Networking'],
    ['tcp', 'routing', 'debugging'],
    ['pdf'],
    BookAccessType.publicFullText,
  ),
  _CourseBookTemplate(
    'UX220',
    'Usability Interview Kit',
    'Self-created field kit for interviews, tasks, and observation notes.',
    'CampusMate UX Studio',
    ['UI UX', 'Research'],
    ['ux', 'interview', 'usability'],
    ['pdf', 'epub'],
    BookAccessType.authenticatedFullText,
  ),
  _CourseBookTemplate(
    'SEC310',
    'Secure Coding Boundary Notes',
    'Self-created notes on STRIDE, data exposure, and negative tests.',
    'CampusMate Security Desk',
    ['Security', 'Software Engineering'],
    ['stride', 'security', 'negative tests'],
    ['pdf'],
    BookAccessType.borrowRequired,
  ),
  _CourseBookTemplate(
    'DS240',
    'Algorithm Patterns Cheat Sheet',
    'Self-created quick reference for common algorithmic patterns.',
    'CampusMate Algorithms Desk',
    ['Algorithms'],
    ['algorithm', 'complexity', 'patterns'],
    ['pdf'],
    BookAccessType.publicFullText,
  ),
  _CourseBookTemplate(
    'ENG102',
    'Technical Reading Companion',
    'Self-created guide for reading technical articles in English.',
    'CampusMate English Desk',
    ['English', 'Research'],
    ['english', 'technical reading', 'presentation'],
    ['epub'],
    BookAccessType.authenticatedFullText,
  ),
  _CourseBookTemplate(
    'OS230',
    'Process and Memory Lab Notes',
    'Self-created operating systems notes for process scheduling and memory.',
    'CampusMate Systems Desk',
    ['Operating Systems'],
    ['process', 'memory', 'synchronization'],
    ['pdf'],
    BookAccessType.borrowRequired,
  ),
  _CourseBookTemplate(
    'QA260',
    'Regression Testing Checklist',
    'Self-created checklist for deterministic release validation.',
    'CampusMate QA Guild',
    ['Testing'],
    ['regression', 'checklist', 'quality'],
    ['pdf', 'epub'],
    BookAccessType.publicFullText,
  ),
  _CourseBookTemplate(
    'CLOUD330',
    'Cloud Deployment Runbook',
    'Self-created metadata for cloud rollout and rollback discussions.',
    'CampusMate Cloud Desk',
    ['Cloud', 'DevOps'],
    ['cloud', 'deployment', 'rollback'],
    [],
    BookAccessType.metadataOnly,
  ),
  _CourseBookTemplate(
    'PM250',
    'Sprint Planning Workbook',
    'Self-created workbook for project planning and risk tracking.',
    'CampusMate PM Desk',
    ['Project Management'],
    ['planning', 'risk', 'sprint'],
    ['pdf'],
    BookAccessType.authenticatedFullText,
  ),
  _CourseBookTemplate(
    'STAT210',
    'Statistics Refresher',
    'Self-created refresher on probability and descriptive statistics.',
    'CampusMate Math Desk',
    ['Mathematics', 'Data Science'],
    ['statistics', 'probability', 'data'],
    ['pdf'],
    BookAccessType.publicFullText,
  ),
  _CourseBookTemplate(
    'SE101',
    'Code Review Tactics',
    'Self-created tactics for reviewing correctness and maintainability.',
    'CampusMate Software Guild',
    ['Software Engineering', 'Testing'],
    ['review', 'maintainability', 'quality'],
    ['pdf'],
    BookAccessType.authenticatedFullText,
  ),
  _CourseBookTemplate(
    'SE214',
    'Mobile Offline Cache Patterns',
    'Self-created patterns for pull caches, stale reads, and retry UX.',
    'CampusMate Mobile Guild',
    ['Mobile Development', 'Database'],
    ['offline', 'cache', 'retry'],
    ['pdf', 'epub'],
    BookAccessType.publicFullText,
  ),
  _CourseBookTemplate(
    'DB202',
    'SQL Query Exercises',
    'Self-created exercises for joins, aggregation, and explain plans.',
    'CampusMate Data Group',
    ['Database'],
    ['sql', 'joins', 'explain'],
    ['pdf'],
    BookAccessType.publicFullText,
  ),
  _CourseBookTemplate(
    'AI301',
    'AI Prompt Testing Fixtures',
    'Self-created restricted fixture metadata for AI safety review.',
    'CampusMate AI Group',
    ['Artificial Intelligence', 'Security'],
    ['prompt', 'fixtures', 'safety'],
    ['pdf'],
    BookAccessType.restricted,
  ),
  _CourseBookTemplate(
    'UX220',
    'Design Critique Cards',
    'Self-created cards for reviewing hierarchy, spacing, and states.',
    'CampusMate UX Studio',
    ['UI UX'],
    ['design', 'critique', 'states'],
    ['pdf'],
    BookAccessType.publicFullText,
  ),
  _CourseBookTemplate(
    'SEC310',
    'Access Control Abuse Cases',
    'Self-created restricted notes for role and data isolation tests.',
    'CampusMate Security Desk',
    ['Security'],
    ['access control', 'abuse case', 'isolation'],
    ['pdf'],
    BookAccessType.restricted,
  ),
  _CourseBookTemplate(
    'CLOUD330',
    'Observability Quickstart',
    'Self-created quickstart for logs, metrics, and incident notes.',
    'CampusMate Cloud Desk',
    ['Cloud', 'DevOps'],
    ['observability', 'logs', 'metrics'],
    ['pdf'],
    BookAccessType.borrowRequired,
  ),
];

class _BookSeed {
  const _BookSeed({
    required this.title,
    this.subtitle,
    required this.description,
    required this.isbn,
    required this.publisher,
    required this.year,
    required this.language,
    required this.accessType,
    required this.license,
    required this.authors,
    required this.categories,
    required this.courseCodes,
    required this.keywords,
    required this.formats,
    this.coverUrl,
  });

  final String title;
  final String? subtitle;
  final String description;
  final String isbn;
  final String publisher;
  final int year;
  final String language;
  final BookAccessType accessType;
  final String license;
  final List<String> authors;
  final List<String> categories;
  final List<String> courseCodes;
  final List<String> keywords;
  final List<String> formats;
  final String? coverUrl;
}

class _CourseBookTemplate {
  const _CourseBookTemplate(
    this.courseCode,
    this.title,
    this.description,
    this.author,
    this.categories,
    this.keywords,
    this.formats,
    this.accessType,
  );

  final String courseCode;
  final String title;
  final String description;
  final String author;
  final List<String> categories;
  final List<String> keywords;
  final List<String> formats;
  final BookAccessType accessType;
}
