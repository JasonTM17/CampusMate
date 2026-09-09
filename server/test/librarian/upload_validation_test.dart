import 'dart:convert';

import 'package:campusmate_server/src/librarian/upload_validation_service.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

void main() {
  group('UploadValidationService (Phase-11)', () {
    late UploadValidationService service;

    setUp(() {
      service = UploadValidationService(
        maxSizeBytes: 5 * 1024 * 1024,
      ); // 5MB for testing
    });

    test('issues valid upload ticket with server-controlled storage key', () {
      final ticket = service.createUploadTicket(
        bookId: 42,
        clientFilename: 'sample.pdf',
        format: 'pdf',
        byteSize: 1024,
      );

      expect(ticket.bookId, 42);
      expect(ticket.format, 'pdf');
      expect(ticket.storageKey, startsWith('books/42/'));
      expect(ticket.storageKey, endsWith('.pdf'));
      expect(ticket.uploadToken, isNotEmpty);
      expect(ticket.expiresAt.isAfter(DateTime.now().toUtc()), isTrue);
    });

    test(
      'neutralizes path traversal attempts in filename during ticket creation',
      () {
        final ticket = service.createUploadTicket(
          bookId: 99,
          clientFilename: '../../../../etc/passwd.epub',
          format: 'epub',
          byteSize: 2048,
        );

        // The storage key NEVER contains path traversal components
        expect(ticket.storageKey, startsWith('books/99/'));
        expect(ticket.storageKey.contains('..'), isFalse);
        expect(ticket.storageKey.contains('passwd'), isFalse);
        expect(ticket.storageKey, endsWith('.epub'));
      },
    );

    test('validates valid PDF bytes (%PDF- header)', () {
      final validPdfBytes = utf8.encode(
        '%PDF-1.7\nSample PDF payload content for testing.',
      );

      expect(
        () => service.validateFileBytes(
          bytes: validPdfBytes,
          expectedFormat: 'pdf',
          clientFilename: 'document.pdf',
        ),
        returnsNormally,
      );
    });

    test('validates valid EPUB bytes (PK zip header with epub structure)', () {
      // PK\x03\x04 followed by epub/mimetype indicator
      final validEpubBytes = [
        0x50, 0x4B, 0x03, 0x04, // PK zip magic
        ...utf8.encode(
          'application/epub+zipMETA-INF/container.xml contents...',
        ),
      ];

      expect(
        () => service.validateFileBytes(
          bytes: validEpubBytes,
          expectedFormat: 'epub',
          clientFilename: 'ebook.epub',
        ),
        returnsNormally,
      );
    });

    test(
      'NEGATIVE GATE: rejects evil.pdf containing non-PDF bytes (MIME mismatch)',
      () {
        final fakePdfBytes = utf8.encode(
          'This is plain text pretending to be a PDF file.',
        );

        expect(
          () => service.validateFileBytes(
            bytes: fakePdfBytes,
            expectedFormat: 'pdf',
            clientFilename: 'evil.pdf',
          ),
          throwsA(
            isA<ServerpodClientException>().having(
              (e) => e.message,
              'message',
              contains('MIME magic bytes do not match PDF'),
            ),
          ),
        );
      },
    );

    test('NEGATIVE GATE: rejects fake EPUB without ZIP magic bytes', () {
      final fakeEpubBytes = utf8.encode('%PDF-1.4 but renamed to .epub');

      expect(
        () => service.validateFileBytes(
          bytes: fakeEpubBytes,
          expectedFormat: 'epub',
          clientFilename: 'fake.epub',
        ),
        throwsA(
          isA<ServerpodClientException>().having(
            (e) => e.message,
            'message',
            contains('MIME magic bytes do not match EPUB'),
          ),
        ),
      );
    });

    test('NEGATIVE GATE: rejects filename path traversal in validation', () {
      final validPdfBytes = utf8.encode('%PDF-1.7 payload');

      expect(
        () => service.validateFileBytes(
          bytes: validPdfBytes,
          expectedFormat: 'pdf',
          clientFilename: '../../traversal.pdf',
        ),
        throwsA(
          isA<ServerpodClientException>().having(
            (e) => e.message,
            'message',
            contains('path traversal characters detected'),
          ),
        ),
      );
    });

    test('NEGATIVE GATE: rejects file exceeding max size limit', () {
      final largeBytes = List<int>.filled(
        6 * 1024 * 1024,
        0x25,
      ); // 6MB > 5MB limit

      expect(
        () => service.validateFileBytes(
          bytes: largeBytes,
          expectedFormat: 'pdf',
          clientFilename: 'large.pdf',
        ),
        throwsA(
          isA<ServerpodClientException>().having(
            (e) => e.message,
            'message',
            contains('exceeds limit'),
          ),
        ),
      );
    });

    test('computes deterministic SHA-256 checksum', () {
      final bytes = utf8.encode('checksum-payload-test');
      final hash1 = service.computeChecksum(bytes);
      final hash2 = service.computeChecksum(bytes);

      expect(hash1, hash2);
      expect(hash1.length, 64); // SHA-256 hex string length
    });
  });
}
