import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:campusmate_server/src/library/book_access_policy_service.dart';
import 'package:test/test.dart';

void main() {
  final policy = BookAccessPolicyService();

  group('BookAccessPolicyService', () {
    for (final role in ['student', 'lecturer', 'librarian', 'admin']) {
      test('metadataOnly never exposes read actions for $role', () {
        final decision = policy.evaluate(
          role: role,
          book: _book(BookAccessType.metadataOnly),
        );

        expect(decision.canRead, isFalse);
        expect(decision.canDownload, isFalse);
        expect(decision.canBorrow, isFalse);
        expect(
          decision.reason,
          'Tài liệu này hiện chỉ có thông tin tham khảo.',
        );
      });
    }

    test('inactive books block every role before access-type logic', () {
      for (final role in ['student', 'lecturer', 'librarian', 'admin']) {
        final decision = policy.evaluate(
          role: role,
          book: _book(BookAccessType.publicFullText, isActive: false),
        );

        expect(decision.canRead, isFalse);
        expect(decision.canDownload, isFalse);
        expect(decision.canBorrow, isFalse);
        expect(decision.reason, contains('chưa được phát hành'));
      }
    });

    test('restricted full text is limited to librarian and admin', () {
      for (final role in ['student', 'lecturer']) {
        final decision = policy.evaluate(
          role: role,
          book: _book(BookAccessType.restricted),
        );

        expect(decision.canRead, isFalse);
        expect(decision.canDownload, isFalse);
        expect(decision.canBorrow, isFalse);
        expect(decision.reason, contains('giới hạn'));
      }

      for (final role in ['librarian', 'admin']) {
        final decision = policy.evaluate(
          role: role,
          book: _book(BookAccessType.restricted),
        );

        expect(decision.canRead, isTrue);
        expect(decision.canDownload, isFalse);
        expect(decision.canBorrow, isFalse);
      }
    });

    test(
      'borrowRequired waits for loan except privileged management roles',
      () {
        final studentWithoutLoan = policy.evaluate(
          role: 'student',
          book: _book(BookAccessType.borrowRequired),
        );
        expect(studentWithoutLoan.canRead, isFalse);
        expect(studentWithoutLoan.canBorrow, isTrue);

        final studentWithLoan = policy.evaluate(
          role: 'student',
          book: _book(BookAccessType.borrowRequired),
          hasActiveLoan: true,
        );
        expect(studentWithLoan.canRead, isTrue);
        expect(studentWithLoan.canBorrow, isFalse);

        final admin = policy.evaluate(
          role: 'admin',
          book: _book(BookAccessType.borrowRequired),
        );
        expect(admin.canRead, isTrue);
        expect(admin.canBorrow, isFalse);
      },
    );

    test('expired license blocks otherwise readable content', () {
      final decision = policy.evaluate(
        role: 'student',
        book: _book(
          BookAccessType.publicFullText,
          licenseExpiresAt: DateTime.utc(2026, 9, 1),
        ),
        now: DateTime.utc(2026, 9, 8),
      );

      expect(decision.canRead, isFalse);
      expect(decision.canDownload, isFalse);
      expect(decision.canBorrow, isFalse);
      expect(decision.reason, contains('hết hạn'));
    });
  });
}

LibraryBook _book(
  BookAccessType accessType, {
  bool isActive = true,
  DateTime? licenseExpiresAt,
}) {
  return LibraryBook(
    id: 1,
    title: 'Test Book',
    subtitle: null,
    description: 'Test description',
    isbn: 'TEST-001',
    publisher: 'CampusMate Test',
    publishedYear: 2026,
    language: 'en',
    coverUrl: null,
    accessType: accessType,
    license: 'Test license',
    licenseExpiresAt: licenseExpiresAt,
    keywords: 'test',
    searchText: 'test book',
    popularityScore: 1,
    featuredRank: null,
    isActive: isActive,
    createdAt: DateTime.utc(2026, 9, 8),
    updatedAt: DateTime.utc(2026, 9, 8),
  );
}
