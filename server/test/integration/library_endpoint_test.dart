@Timeout(Duration(minutes: 2))
library;

import 'package:campusmate_server/src/academic/academic_demo_seed.dart';
import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:campusmate_server/src/library/library_demo_seed.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _studentAId = '00000000-0000-4000-8000-000000000301';
const _studentBId = '00000000-0000-4000-8000-000000000302';
const _librarianId = '00000000-0000-4000-8000-000000000303';

void main() {
  withServerpod('Given LibraryEndpoint', (sessionBuilder, endpoints) {
    final studentA = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _studentAId,
        {campusMateStudentScope},
      ),
    );
    final studentB = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _studentBId,
        {campusMateStudentScope},
      ),
    );
    final librarian = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        _librarianId,
        {campusMateLibrarianScope},
      ),
    );

    test('rejects unauthenticated catalog access', () async {
      await expectLater(
        endpoints.library.explore(sessionBuilder, limitPerSection: 4),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });

    test(
      'returns explore sections and filter facets from seeded catalog',
      () async {
        await _prepareLibrarySeed(sessionBuilder, endpoints, studentA);

        final explore = await endpoints.library.explore(
          studentA,
          limitPerSection: 4,
        );

        expect(
          explore.sections.map((section) => section.key),
          containsAll(['featured', 'recent', 'popular', 'recommended']),
        );
        expect(
          explore.sections.every((section) => section.items.length <= 4),
          isTrue,
        );
        expect(explore.filterOptions.formats, containsAll(['pdf', 'epub']));
        expect(
          explore.filterOptions.accessTypes,
          contains(BookAccessType.metadataOnly),
        );
        expect(explore.filterOptions.categories, contains('Database'));
        expect(
          explore.sections
              .expand((section) => section.items)
              .any(
                (book) => book.courseCodes.isNotEmpty,
              ),
          isTrue,
        );
      },
    );

    test('search uses cursor pagination and binds cursor to filters', () async {
      await _prepareLibrarySeed(sessionBuilder, endpoints, studentA);

      final firstPage = await endpoints.library.search(
        studentA,
        query: 'campusmate',
        limit: 10,
        relatedToMyCourses: false,
      );
      final secondPage = await endpoints.library.search(
        studentA,
        query: 'campusmate',
        cursor: firstPage.nextCursor,
        limit: 10,
        relatedToMyCourses: false,
      );

      expect(firstPage.items, hasLength(10));
      expect(firstPage.nextCursor, isNotNull);
      expect(secondPage.items, isNotEmpty);
      expect(
        firstPage.items
            .map((book) => book.id)
            .toSet()
            .intersection(secondPage.items.map((book) => book.id).toSet()),
        isEmpty,
      );

      await expectLater(
        endpoints.library.search(
          studentA,
          query: 'database',
          cursor: firstPage.nextCursor,
          limit: 5,
          relatedToMyCourses: false,
        ),
        throwsA(
          isA<ServerpodClientException>().having(
            (error) => error.statusCode,
            'statusCode',
            400,
          ),
        ),
      );
    });

    test(
      'paginates more than 100 matching books without overlap',
      () async {
        await _prepareLibrarySeed(sessionBuilder, endpoints, studentA);
        await _insertBulkCursorBooks(sessionBuilder);

        final firstPage = await endpoints.library.search(
          studentA,
          query: 'bulk cursor campusmate',
          limit: 50,
          relatedToMyCourses: false,
        );
        final secondPage = await endpoints.library.search(
          studentA,
          query: 'bulk cursor campusmate',
          cursor: firstPage.nextCursor,
          limit: 50,
          relatedToMyCourses: false,
        );
        final thirdPage = await endpoints.library.search(
          studentA,
          query: 'bulk cursor campusmate',
          cursor: secondPage.nextCursor,
          limit: 50,
          relatedToMyCourses: false,
        );

        expect(firstPage.totalCount, 105);
        expect(firstPage.items, hasLength(50));
        expect(secondPage.items, hasLength(50));
        expect(thirdPage.items, hasLength(5));
        expect(firstPage.nextCursor, isNotNull);
        expect(secondPage.nextCursor, isNotNull);
        expect(thirdPage.nextCursor, isNull);

        final allIds = {
          ...firstPage.items.map((book) => book.id),
          ...secondPage.items.map((book) => book.id),
          ...thirdPage.items.map((book) => book.id),
        };
        expect(allIds, hasLength(105));
      },
    );

    test(
      'filters format, category, year, access type, and related courses',
      () async {
        await _prepareLibrarySeed(sessionBuilder, endpoints, studentA);

        final epub = await endpoints.library.search(
          studentA,
          formats: ['epub'],
          limit: 20,
          relatedToMyCourses: false,
        );
        expect(epub.items, isNotEmpty);
        expect(
          epub.items.every((book) => book.availableFormats.contains('epub')),
          isTrue,
        );

        final database = await endpoints.library.search(
          studentA,
          query: 'database',
          categories: ['Database'],
          years: [2025, 2026],
          accessTypes: [
            BookAccessType.borrowRequired,
            BookAccessType.publicFullText,
          ],
          limit: 20,
          relatedToMyCourses: false,
        );
        expect(database.items, isNotEmpty);
        expect(
          database.items.every(
            (book) =>
                book.categories.contains('Database') &&
                book.publishedYear >= 2025,
          ),
          isTrue,
        );

        final authored = await endpoints.library.search(
          studentA,
          authors: ['CampusMate Lab'],
          limit: 20,
          relatedToMyCourses: false,
        );
        expect(authored.items, isNotEmpty);
        expect(
          authored.items.every(
            (book) => book.authors.contains('CampusMate Lab'),
          ),
          isTrue,
        );

        final related = await endpoints.library.search(
          studentA,
          relatedToMyCourses: true,
          limit: 20,
        );
        expect(related.items, isNotEmpty);
        expect(
          related.items.every((book) => book.courseCodes.isNotEmpty),
          isTrue,
        );
      },
    );

    test(
      'detail and favorite remain scoped and never expose file keys',
      () async {
        await _prepareLibrarySeed(sessionBuilder, endpoints, studentA);

        final metadataOnly = (await endpoints.library.search(
          studentA,
          accessTypes: [BookAccessType.metadataOnly],
          limit: 1,
          relatedToMyCourses: false,
        )).items.single;
        final metadataDetail = await endpoints.library.getBookDetail(
          studentA,
          bookId: metadataOnly.id,
        );
        expect(metadataDetail.access.canRead, isFalse);
        expect(metadataDetail.access.canDownload, isFalse);
        expect(metadataDetail.access.canBorrow, isFalse);
        expect(
          metadataDetail.access.reason,
          'Tài liệu này hiện chỉ có thông tin tham khảo.',
        );
        expect(
          metadataDetail.toJson().toString(),
          isNot(contains('storageKey')),
        );
        expect(
          metadataDetail.toJson().toString(),
          isNot(contains('demo/library')),
        );

        final status = await endpoints.library.toggleFavorite(
          studentA,
          bookId: metadataOnly.id,
        );
        expect(status.isFavorite, isTrue);
        expect(
          (await endpoints.library.getBookDetail(
            studentA,
            bookId: metadataOnly.id,
          )).isFavorite,
          isTrue,
        );
        expect(
          (await endpoints.library.getBookDetail(
            studentB,
            bookId: metadataOnly.id,
          )).isFavorite,
          isFalse,
        );
      },
    );

    test(
      'restricted books expose no file URL and actions differ by role',
      () async {
        await _prepareLibrarySeed(sessionBuilder, endpoints, studentA);

        final restricted = (await endpoints.library.search(
          studentA,
          accessTypes: [BookAccessType.restricted],
          limit: 1,
          relatedToMyCourses: false,
        )).items.single;
        final studentDetail = await endpoints.library.getBookDetail(
          studentA,
          bookId: restricted.id,
        );
        final librarianDetail = await endpoints.library.getBookDetail(
          librarian,
          bookId: restricted.id,
        );

        expect(studentDetail.access.canRead, isFalse);
        expect(studentDetail.access.canDownload, isFalse);
        expect(librarianDetail.access.canRead, isTrue);
        expect(librarianDetail.access.canDownload, isFalse);
        expect(
          studentDetail.toJson().toString(),
          isNot(contains('storageKey')),
        );
        expect(
          librarianDetail.toJson().toString(),
          isNot(contains('storageKey')),
        );
      },
    );
  });
}

Future<void> _prepareLibrarySeed(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  TestSessionBuilder student,
) async {
  await endpoints.studentProfile.updateMyProfile(
    student,
    fullName: 'Nguyen Van Library',
    className: 'CNTT-LIB',
  );
  final session = sessionBuilder.build();
  await seedAcademicDemoData(session);
  await seedLibraryDemoData(session);
  await seedLibraryDemoData(session);

  expect(await LibraryBook.db.count(session), 30);
  expect(await LibraryBookFile.db.count(session), greaterThan(20));
}

Future<void> _insertBulkCursorBooks(TestSessionBuilder sessionBuilder) async {
  final session = sessionBuilder.build();
  final baseTime = DateTime.utc(2026, 9, 8, 8);
  await LibraryBook.db.insert(
    session,
    [
      for (var index = 0; index < 105; index++)
        LibraryBook(
          title: 'Bulk Cursor CampusMate ${index.toString().padLeft(3, '0')}',
          description:
              'Synthetic library row used only for cursor pagination proof.',
          publisher: 'CampusMate Test',
          publishedYear: 2026,
          language: 'vi',
          accessType: BookAccessType.publicFullText,
          license: 'Test-only metadata',
          keywords: 'bulk cursor campusmate pagination',
          searchText:
              'bulk cursor campusmate pagination ${index.toString().padLeft(3, '0')}',
          popularityScore: index,
          isActive: true,
          createdAt: baseTime.add(Duration(seconds: index)),
          updatedAt: baseTime.add(Duration(seconds: index)),
        ),
    ],
  );
}
