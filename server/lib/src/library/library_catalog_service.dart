import 'dart:convert';

import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../auth/campusmate_auth.dart';
import '../audit/audit_service.dart';
import '../generated/protocol.dart';
import '../lending/lending_service.dart';
import 'book_access_policy_service.dart';

class LibraryCatalogService {
  LibraryCatalogService({
    BookAccessPolicyService? policy,
    LendingService? lending,
    AuditService? audit,
  }) : _policy = policy ?? BookAccessPolicyService(),
       _lending = lending ?? LendingService(policy: policy),
       _audit = audit ?? AuditService();

  static const formats = {'pdf', 'epub'};
  static const languages = {'vi', 'en'};
  static const metadataOnlyMessage =
      'Tài liệu này hiện chỉ có thông tin tham khảo.';

  final BookAccessPolicyService _policy;
  final LendingService _lending;
  final AuditService _audit;

  Future<LibraryExplore> explore(
    Session session, {
    int limitPerSection = 8,
  }) async {
    CampusMateAuth.requireAuthentication(session);
    final pageSize = limitPerSection.clamp(1, 12).toInt();
    final sections = <LibraryExploreSection>[];

    sections.add(
      LibraryExploreSection(
        key: 'featured',
        title: 'Nổi bật',
        items: await _searchSummaries(
          session,
          _SearchRequest(pageSize: pageSize, sort: _LibrarySort.featured),
        ),
      ),
    );
    sections.add(
      LibraryExploreSection(
        key: 'recent',
        title: 'Mới cập nhật',
        items: await _searchSummaries(
          session,
          _SearchRequest(pageSize: pageSize, sort: _LibrarySort.recent),
        ),
      ),
    );
    sections.add(
      LibraryExploreSection(
        key: 'popular',
        title: 'Đọc nhiều',
        items: await _searchSummaries(
          session,
          _SearchRequest(pageSize: pageSize, sort: _LibrarySort.popular),
        ),
      ),
    );

    final courseBookIds = await _relatedCourseBookIds(session);
    if (courseBookIds.isNotEmpty) {
      sections.add(
        LibraryExploreSection(
          key: 'related-to-courses',
          title: 'Liên quan môn đang học',
          items: await _searchSummaries(
            session,
            _SearchRequest(
              pageSize: pageSize,
              bookIds: courseBookIds,
              sort: _LibrarySort.popular,
            ),
          ),
        ),
      );
    }

    sections.add(
      LibraryExploreSection(
        key: 'recommended',
        title: 'Gợi ý cho bạn',
        items: await _searchSummaries(
          session,
          _SearchRequest(
            pageSize: pageSize,
            bookIds: courseBookIds,
            fallbackToAllWhenBookIdsEmpty: true,
            sort: _LibrarySort.featured,
          ),
        ),
      ),
    );

    return LibraryExplore(
      sections: sections,
      filterOptions: await filterOptions(session),
    );
  }

  Future<LibraryFilterOptions> filterOptions(Session session) async {
    CampusMateAuth.requireAuthentication(session);
    final categories = await LibraryCategory.db.find(
      session,
      orderBy: (t) => t.name,
    );
    final authors = await LibraryAuthor.db.find(
      session,
      orderBy: (t) => t.displayName,
    );
    final books = await LibraryBook.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderByList: (t) => [
        Order(column: t.publishedYear, orderDescending: true),
        Order(column: t.id, orderDescending: true),
      ],
      limit: 500,
    );
    final files = await LibraryBookFile.db.find(
      session,
      orderBy: (t) => t.format,
      limit: 500,
    );

    return LibraryFilterOptions(
      languages: _sortedStrings(books.map((book) => book.language)),
      categories: categories.map((row) => row.name).toList(),
      authors: authors.map((row) => row.displayName).toList(),
      years: _sortedYears(books.map((book) => book.publishedYear)),
      accessTypes: BookAccessType.values,
      formats: _sortedStrings(files.map((file) => file.format)),
    );
  }

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
  }) async {
    CampusMateAuth.requireAuthentication(session);
    final filters = await _resolveFilters(
      session,
      query: query,
      formats: formats,
      languages: languages,
      categories: categories,
      authors: authors,
      years: years,
      accessTypes: accessTypes,
      relatedToMyCourses: relatedToMyCourses,
    );
    final pageSize = limit.clamp(1, 50).toInt();
    final decodedCursor = cursor == null || cursor.trim().isEmpty
        ? null
        : _decodeCursor(cursor, filters);
    final request = _SearchRequest(
      pageSize: pageSize,
      filters: filters,
      cursor: decodedCursor,
      sort: _LibrarySort.recent,
    );
    final rows = await _findBooks(
      session,
      request.copyWith(pageSize: pageSize + 1),
    );
    final hasMore = rows.length > pageSize;
    final visibleRows = hasMore ? rows.take(pageSize).toList() : rows;
    final items = await _summariesFor(session, visibleRows);
    final totalCount = await _countBooks(session, request);

    return LibrarySearchPage(
      items: items,
      nextCursor: hasMore && visibleRows.isNotEmpty
          ? _encodeCursor(visibleRows.last, filters)
          : null,
      totalCount: totalCount,
    );
  }

  Future<BookDetail> getBookDetail(
    Session session, {
    required int bookId,
  }) async {
    CampusMateAuth.requireAuthentication(session);
    final role = CampusMateAuth.roleFor(session);
    final book = await LibraryBook.db.findById(session, bookId);
    if (book == null || !_policy.mayViewDetail(role: role, book: book)) {
      throw ServerpodClientException('Book not found', 404);
    }
    final metadata = await _metadataFor(
      session,
      {bookId},
      booksById: {bookId: book},
    );
    return _detail(
      session,
      book,
      metadata[bookId] ?? _BookMetadata.empty(),
    );
  }

  Future<BookFavoriteStatus> toggleFavorite(
    Session session, {
    required int bookId,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final book = await LibraryBook.db.findById(session, bookId);
    if (book == null || !book.isActive) {
      throw ServerpodClientException('Book not found', 404);
    }
    final existing = await FavoriteBook.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.bookId.equals(bookId),
    );
    if (existing == null) {
      await FavoriteBook.db.insertRow(
        session,
        FavoriteBook(
          userId: userId,
          bookId: bookId,
          createdAt: CampusClock.nowUtc(),
        ),
      );
      return BookFavoriteStatus(bookId: bookId, isFavorite: true);
    }

    await FavoriteBook.db.deleteRow(session, existing);
    return BookFavoriteStatus(bookId: bookId, isFavorite: false);
  }

  Future<BookAccessPolicyUpdate> updateAccessPolicy(
    Session session, {
    required int bookId,
    required BookAccessType accessType,
  }) async {
    final actorUserId = CampusMateAuth.requireUserId(session);
    final role = CampusMateAuth.roleFor(session);
    if (role != 'librarian' && role != 'admin') {
      throw ServerpodClientForbidden();
    }
    final updated = await session.db.transaction<LibraryBook>((
      transaction,
    ) async {
      final now = CampusClock.nowUtc();
      final book = await LibraryBook.db.findById(
        session,
        bookId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (book == null) {
        throw ServerpodClientException('Book not found', 404);
      }
      if (book.accessType == accessType) {
        return book;
      }
      final updatedBook = await LibraryBook.db.updateRow(
        session,
        book.copyWith(accessType: accessType, updatedAt: now),
        transaction: transaction,
      );
      await _audit.record(
        session,
        actorUserId: actorUserId,
        action: role == 'admin'
            ? 'ADMIN_CHANGE_ACCESS_POLICY'
            : 'LIBRARIAN_CHANGE_ACCESS_POLICY',
        resourceType: 'book',
        resourceId: bookId.toString(),
        metadata: {
          'from': book.accessType.name,
          'to': accessType.name,
          'role': role,
        },
        transaction: transaction,
      );
      return updatedBook;
    });

    return BookAccessPolicyUpdate(
      bookId: bookId,
      accessType: updated.accessType,
      updatedAt: updated.updatedAt,
    );
  }

  Future<List<BookSummary>> _searchSummaries(
    Session session,
    _SearchRequest request,
  ) async {
    final rows = await _findBooks(session, request);
    return _summariesFor(session, rows);
  }

  Future<List<LibraryBook>> _findBooks(
    Session session,
    _SearchRequest request,
  ) {
    return LibraryBook.db.find(
      session,
      where: (t) => _bookExpression(t, request),
      orderByList: (t) => _orders(t, request.sort),
      limit: request.pageSize,
    );
  }

  Future<int> _countBooks(Session session, _SearchRequest request) {
    return LibraryBook.db.count(
      session,
      where: (t) => _bookExpression(t, request.copyWith(clearCursor: true)),
    );
  }

  Expression _bookExpression(LibraryBookTable t, _SearchRequest request) {
    final filters = request.filters;
    var expression = t.isActive.equals(true);
    if (filters != null) {
      if (filters.query != null) {
        expression = expression & t.searchText.ilike('%${filters.query}%');
      }
      if (filters.languages.isNotEmpty) {
        expression = expression & t.language.inSet(filters.languages);
      }
      if (filters.years.isNotEmpty) {
        expression = expression & t.publishedYear.inSet(filters.years);
      }
      if (filters.accessTypes.isNotEmpty) {
        expression = expression & t.accessType.inSet(filters.accessTypes);
      }
      if (filters.bookIds != null) {
        expression = expression & t.id.inSet(filters.bookIds!);
      }
    }
    if (request.bookIds != null &&
        (request.bookIds!.isNotEmpty ||
            !request.fallbackToAllWhenBookIdsEmpty)) {
      expression = expression & t.id.inSet(request.bookIds!);
    }
    if (request.cursor != null) {
      final cursor = request.cursor!;
      expression =
          expression &
          ((t.createdAt < cursor.createdAt) |
              (t.createdAt.equals(cursor.createdAt) & (t.id < cursor.id)));
    }
    return expression;
  }

  List<Order> _orders(LibraryBookTable t, _LibrarySort sort) {
    return switch (sort) {
      _LibrarySort.featured => [
        Order(column: t.featuredRank, orderDescending: false),
        Order(column: t.createdAt, orderDescending: true),
        Order(column: t.id, orderDescending: true),
      ],
      _LibrarySort.popular => [
        Order(column: t.popularityScore, orderDescending: true),
        Order(column: t.createdAt, orderDescending: true),
        Order(column: t.id, orderDescending: true),
      ],
      _LibrarySort.recent => [
        Order(column: t.createdAt, orderDescending: true),
        Order(column: t.id, orderDescending: true),
      ],
    };
  }

  Future<_LibraryFilters> _resolveFilters(
    Session session, {
    String? query,
    List<String>? formats,
    List<String>? languages,
    List<String>? categories,
    List<String>? authors,
    List<int>? years,
    List<BookAccessType>? accessTypes,
    required bool relatedToMyCourses,
  }) async {
    final normalizedFormats = _normalizeStringSet(formats);
    if (!LibraryCatalogService.formats.containsAll(normalizedFormats)) {
      throw ServerpodClientException('Invalid library format filter', 400);
    }
    final normalizedLanguages = _normalizeStringSet(languages);
    if (!LibraryCatalogService.languages.containsAll(normalizedLanguages)) {
      throw ServerpodClientException('Invalid language filter', 400);
    }
    final bookIdFilters = <Set<int>>[];
    if (normalizedFormats.isNotEmpty) {
      bookIdFilters.add(await _bookIdsForFormats(session, normalizedFormats));
    }
    final normalizedCategories = _normalizeStringSet(categories);
    if (normalizedCategories.isNotEmpty) {
      bookIdFilters.add(
        await _bookIdsForCategories(session, normalizedCategories),
      );
    }
    final normalizedAuthors = _normalizeStringSet(authors);
    if (normalizedAuthors.isNotEmpty) {
      bookIdFilters.add(await _bookIdsForAuthors(session, normalizedAuthors));
    }
    if (relatedToMyCourses) {
      bookIdFilters.add(await _relatedCourseBookIds(session));
    }

    return _LibraryFilters(
      query: _normalizeQuery(query),
      formats: normalizedFormats,
      languages: normalizedLanguages,
      categories: normalizedCategories,
      authors: normalizedAuthors,
      years: (years ?? const <int>[]).where((year) => year > 0).toSet(),
      accessTypes: (accessTypes ?? const <BookAccessType>[]).toSet(),
      relatedToMyCourses: relatedToMyCourses,
      bookIds: _intersect(bookIdFilters),
    );
  }

  Future<Set<int>> _bookIdsForFormats(
    Session session,
    Set<String> values,
  ) async {
    final rows = await LibraryBookFile.db.find(
      session,
      where: (t) => t.format.inSet(values),
      limit: 1000,
    );
    return rows.map((row) => row.bookId).toSet();
  }

  Future<Set<int>> _bookIdsForCategories(
    Session session,
    Set<String> values,
  ) async {
    final categories = await LibraryCategory.db.find(
      session,
      orderBy: (t) => t.name,
      limit: 500,
    );
    final categoryIds = categories
        .where(
          (row) =>
              row.id != null &&
              _matchesFacet(values, [
                row.slug,
                row.name,
              ]),
        )
        .map((row) => row.id!)
        .toSet();
    if (categoryIds.isEmpty) return {};
    final rows = await LibraryBookCategory.db.find(
      session,
      where: (t) => t.categoryId.inSet(categoryIds),
      limit: 1000,
    );
    return rows.map((row) => row.bookId).toSet();
  }

  Future<Set<int>> _bookIdsForAuthors(
    Session session,
    Set<String> values,
  ) async {
    final authors = await LibraryAuthor.db.find(
      session,
      orderBy: (t) => t.displayName,
      limit: 500,
    );
    final authorIds = authors
        .where(
          (row) =>
              row.id != null &&
              _matchesFacet(values, [
                row.normalizedName,
                row.displayName,
              ]),
        )
        .map((row) => row.id!)
        .toSet();
    if (authorIds.isEmpty) return {};
    final rows = await LibraryBookAuthor.db.find(
      session,
      where: (t) => t.authorId.inSet(authorIds),
      limit: 1000,
    );
    return rows.map((row) => row.bookId).toSet();
  }

  Future<Set<int>> _relatedCourseBookIds(Session session) async {
    if (CampusMateAuth.roleFor(session) != 'student') return {};
    final userId = CampusMateAuth.requireUserId(session);
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    if (profile?.id == null) return {};
    final enrollments = await Enrollment.db.find(
      session,
      where: (t) => t.studentProfileId.equals(profile!.id!),
      limit: 200,
    );
    final offeringIds = enrollments.map((row) => row.offeringId).toSet();
    if (offeringIds.isEmpty) return {};
    final offerings = await CourseOffering.db.find(
      session,
      where: (t) => t.id.inSet(offeringIds),
      limit: 200,
    );
    final courseIds = offerings.map((row) => row.courseId).toSet();
    if (courseIds.isEmpty) return {};
    final rows = await LibraryBookCourse.db.find(
      session,
      where: (t) => t.courseId.inSet(courseIds),
      limit: 1000,
    );
    return rows.map((row) => row.bookId).toSet();
  }

  Set<int>? _intersect(List<Set<int>> sets) {
    if (sets.isEmpty) return null;
    var result = Set<int>.from(sets.first);
    for (final set in sets.skip(1)) {
      result = result.intersection(set);
    }
    return result;
  }

  Future<List<BookSummary>> _summariesFor(
    Session session,
    List<LibraryBook> books,
  ) async {
    if (books.isEmpty) return [];
    final ids = books.map((book) => book.id!).toSet();
    final metadata = await _metadataFor(
      session,
      ids,
      booksById: {for (final book in books) book.id!: book},
    );
    return [
      for (final book in books)
        _summary(session, book, metadata[book.id!] ?? _BookMetadata.empty()),
    ];
  }

  Future<Map<int, _BookMetadata>> _metadataFor(
    Session session,
    Set<int> bookIds, {
    Map<int, LibraryBook>? booksById,
  }) async {
    if (bookIds.isEmpty) return {};
    final userId = CampusMateAuth.requireUserId(session);
    final now = CampusClock.nowUtc();
    await _lending.refreshOverdue(
      session,
      userId: userId,
      bookIds: bookIds,
      now: now,
    );
    final authorLinks = await LibraryBookAuthor.db.find(
      session,
      where: (t) => t.bookId.inSet(bookIds),
      limit: 2000,
    );
    final categoryLinks = await LibraryBookCategory.db.find(
      session,
      where: (t) => t.bookId.inSet(bookIds),
      limit: 2000,
    );
    final courseLinks = await LibraryBookCourse.db.find(
      session,
      where: (t) => t.bookId.inSet(bookIds),
      limit: 2000,
    );
    final files = await LibraryBookFile.db.find(
      session,
      where: (t) => t.bookId.inSet(bookIds),
      limit: 2000,
    );
    final favorites = await FavoriteBook.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.bookId.inSet(bookIds),
      limit: 1000,
    );
    final activeLoans = await BookLoan.db.find(
      session,
      where: (t) =>
          t.bookId.inSet(bookIds) &
          t.status.inSet(LendingService.activeLoanStatuses),
      orderByList: (t) => [
        Order(column: t.dueAt),
        Order(column: t.id),
      ],
      limit: 2000,
    );
    final availableCopies = await BookCopy.db.find(
      session,
      where: (t) =>
          t.bookId.inSet(bookIds) & t.status.equals(BookCopyStatus.available),
      limit: 2000,
    );
    final authorsById = await _authorsById(
      session,
      authorLinks.map((row) => row.authorId).toSet(),
    );
    final categoriesById = await _categoriesById(
      session,
      categoryLinks.map((row) => row.categoryId).toSet(),
    );
    final coursesById = await _coursesById(
      session,
      courseLinks.map((row) => row.courseId).toSet(),
    );
    final favoriteIds = favorites.map((row) => row.bookId).toSet();
    final availableCopiesByBookId = <int, int>{};
    for (final copy in availableCopies) {
      availableCopiesByBookId[copy.bookId] =
          (availableCopiesByBookId[copy.bookId] ?? 0) + 1;
    }
    final activeLoanCountByBookId = <int, int>{};
    final userActiveLoans = <BookLoan>[];
    for (final loan in activeLoans) {
      activeLoanCountByBookId[loan.bookId] =
          (activeLoanCountByBookId[loan.bookId] ?? 0) + 1;
      if (loan.userId.toString() == userId.toString()) {
        userActiveLoans.add(loan);
      }
    }
    final activeLoanSummaries = await _lending.summariesForLoans(
      session,
      userActiveLoans,
      serverNow: now,
      booksById: booksById,
    );
    final activeLoanByBookId = {
      for (final loan in activeLoanSummaries) loan.bookId: loan,
    };
    final output = {
      for (final id in bookIds)
        id: _BookMetadata(
          isFavorite: favoriteIds.contains(id),
          activeLoan: activeLoanByBookId[id],
          activeLoanCount: activeLoanCountByBookId[id] ?? 0,
          availableCopies: availableCopiesByBookId[id] ?? 0,
        ),
    };

    for (final link in authorLinks) {
      output[link.bookId]!.authors.add(authorsById[link.authorId] ?? '');
    }
    for (final link in categoryLinks) {
      output[link.bookId]!.categories.add(
        categoriesById[link.categoryId] ?? '',
      );
    }
    for (final link in courseLinks) {
      output[link.bookId]!.courseCodes.add(coursesById[link.courseId] ?? '');
    }
    for (final file in files) {
      output[file.bookId]!.formats.add(file.format);
    }
    for (final row in output.values) {
      row.sort();
    }
    return output;
  }

  Future<Map<int, String>> _authorsById(Session session, Set<int> ids) async {
    if (ids.isEmpty) return {};
    final rows = await LibraryAuthor.db.find(
      session,
      where: (t) => t.id.inSet(ids),
      limit: ids.length,
    );
    return {for (final row in rows) row.id!: row.displayName};
  }

  Future<Map<int, String>> _categoriesById(
    Session session,
    Set<int> ids,
  ) async {
    if (ids.isEmpty) return {};
    final rows = await LibraryCategory.db.find(
      session,
      where: (t) => t.id.inSet(ids),
      limit: ids.length,
    );
    return {for (final row in rows) row.id!: row.name};
  }

  Future<Map<int, String>> _coursesById(Session session, Set<int> ids) async {
    if (ids.isEmpty) return {};
    final rows = await Course.db.find(
      session,
      where: (t) => t.id.inSet(ids),
      limit: ids.length,
    );
    return {for (final row in rows) row.id!: row.code};
  }

  BookSummary _summary(
    Session session,
    LibraryBook book,
    _BookMetadata metadata,
  ) {
    return BookSummary(
      id: book.id!,
      title: book.title,
      subtitle: book.subtitle,
      description: book.description,
      isbn: book.isbn,
      publisher: book.publisher,
      publishedYear: book.publishedYear,
      language: book.language,
      coverUrl: book.coverUrl,
      accessType: book.accessType,
      license: book.license,
      authors: metadata.authors,
      categories: metadata.categories,
      courseCodes: metadata.courseCodes,
      availableFormats: metadata.formats,
      isFavorite: metadata.isFavorite,
      access: _policy.evaluateForSession(
        session,
        book,
        hasActiveLoan: metadata.activeLoan != null,
      ),
    );
  }

  BookDetail _detail(
    Session session,
    LibraryBook book,
    _BookMetadata metadata,
  ) {
    return BookDetail(
      id: book.id!,
      title: book.title,
      subtitle: book.subtitle,
      description: book.description,
      isbn: book.isbn,
      publisher: book.publisher,
      publishedYear: book.publishedYear,
      language: book.language,
      coverUrl: book.coverUrl,
      accessType: book.accessType,
      license: book.license,
      licenseExpiresAt: book.licenseExpiresAt,
      keywords: book.keywords,
      authors: metadata.authors,
      categories: metadata.categories,
      courseCodes: metadata.courseCodes,
      availableFormats: metadata.formats,
      isFavorite: metadata.isFavorite,
      access: _policy.evaluateForSession(
        session,
        book,
        hasActiveLoan: metadata.activeLoan != null,
      ),
      activeLoan: metadata.activeLoan,
      activeLoanCount: metadata.activeLoanCount,
      availableCopies: metadata.availableCopies,
    );
  }

  String _encodeCursor(LibraryBook row, _LibraryFilters filters) {
    return base64Url.encode(
      utf8.encode(
        jsonEncode({
          'v': 1,
          'createdAt': row.createdAt.toIso8601String(),
          'id': row.id,
          'filters': filters.toJson(),
        }),
      ),
    );
  }

  _LibraryCursor _decodeCursor(String cursor, _LibraryFilters filters) {
    try {
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(cursor))),
      );
      if (payload is! Map<String, dynamic> ||
          payload['v'] != 1 ||
          payload['id'] is! int ||
          payload['createdAt'] is! String ||
          jsonEncode(payload['filters']) != jsonEncode(filters.toJson())) {
        throw const FormatException('Invalid library cursor.');
      }
      return _LibraryCursor(
        id: payload['id'] as int,
        createdAt: DateTime.parse(payload['createdAt'] as String).toUtc(),
      );
    } on FormatException {
      throw ServerpodClientException('Invalid library cursor', 400);
    } on ArgumentError {
      throw ServerpodClientException('Invalid library cursor', 400);
    }
  }

  String? _normalizeQuery(String? query) {
    final value = query?.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    return value == null || value.isEmpty ? null : value;
  }

  Set<String> _normalizeStringSet(List<String>? values) {
    return (values ?? const <String>[])
        .map((value) => value.trim().toLowerCase())
        .where((value) => value.isNotEmpty)
        .toSet();
  }

  bool _matchesFacet(Set<String> filters, Iterable<String?> terms) {
    final normalizedTerms = <String>{};
    for (final term in terms) {
      if (term == null) continue;
      final trimmed = term.trim().toLowerCase();
      if (trimmed.isEmpty) continue;
      normalizedTerms
        ..add(trimmed)
        ..add(_normalizeFacetTerm(trimmed));
    }
    return filters.any(
      (filter) =>
          normalizedTerms.contains(filter) ||
          normalizedTerms.contains(_normalizeFacetTerm(filter)),
    );
  }

  String _normalizeFacetTerm(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[-_]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  List<String> _sortedStrings(Iterable<String> values) {
    return values.where((value) => value.trim().isNotEmpty).toSet().toList()
      ..sort();
  }

  List<int> _sortedYears(Iterable<int> values) {
    return values.toSet().toList()..sort((a, b) => b.compareTo(a));
  }
}

class _BookMetadata {
  _BookMetadata({
    this.isFavorite = false,
    this.activeLoan,
    this.activeLoanCount = 0,
    this.availableCopies = 0,
  });

  factory _BookMetadata.empty() => _BookMetadata();

  final authors = <String>[];
  final categories = <String>[];
  final courseCodes = <String>[];
  final formats = <String>[];
  final bool isFavorite;
  final BookLoanSummary? activeLoan;
  final int activeLoanCount;
  final int availableCopies;

  void sort() {
    authors.removeWhere((value) => value.isEmpty);
    categories.removeWhere((value) => value.isEmpty);
    courseCodes.removeWhere((value) => value.isEmpty);
    formats.removeWhere((value) => value.isEmpty);
    authors.sort();
    categories.sort();
    courseCodes.sort();
    formats.sort();
  }
}

class _LibraryFilters {
  const _LibraryFilters({
    required this.query,
    required this.formats,
    required this.languages,
    required this.categories,
    required this.authors,
    required this.years,
    required this.accessTypes,
    required this.relatedToMyCourses,
    required this.bookIds,
  });

  final String? query;
  final Set<String> formats;
  final Set<String> languages;
  final Set<String> categories;
  final Set<String> authors;
  final Set<int> years;
  final Set<BookAccessType> accessTypes;
  final bool relatedToMyCourses;
  final Set<int>? bookIds;

  Map<String, Object?> toJson() => {
    'query': query,
    'formats': formats.toList()..sort(),
    'languages': languages.toList()..sort(),
    'categories': categories.toList()..sort(),
    'authors': authors.toList()..sort(),
    'years': years.toList()..sort(),
    'accessTypes': accessTypes.map((type) => type.name).toList()..sort(),
    'relatedToMyCourses': relatedToMyCourses,
  };
}

class _SearchRequest {
  const _SearchRequest({
    required this.pageSize,
    this.filters,
    this.cursor,
    this.bookIds,
    this.fallbackToAllWhenBookIdsEmpty = false,
    this.sort = _LibrarySort.recent,
  });

  final int pageSize;
  final _LibraryFilters? filters;
  final _LibraryCursor? cursor;
  final Set<int>? bookIds;
  final bool fallbackToAllWhenBookIdsEmpty;
  final _LibrarySort sort;

  _SearchRequest copyWith({
    int? pageSize,
    _LibraryFilters? filters,
    _LibraryCursor? cursor,
    bool clearCursor = false,
  }) {
    return _SearchRequest(
      pageSize: pageSize ?? this.pageSize,
      filters: filters ?? this.filters,
      cursor: clearCursor ? null : cursor ?? this.cursor,
      bookIds: bookIds,
      fallbackToAllWhenBookIdsEmpty: fallbackToAllWhenBookIdsEmpty,
      sort: sort,
    );
  }
}

class _LibraryCursor {
  const _LibraryCursor({required this.id, required this.createdAt});

  final int id;
  final DateTime createdAt;
}

enum _LibrarySort { featured, popular, recent }
