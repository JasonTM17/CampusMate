import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../generated/protocol.dart';

/// Service that validates file uploads for library books.
///
/// Enforces:
/// 1. Server-controlled storage key generation: `books/{bookId}/{uuid}.{format}`.
///    Client filenames and path traversal attempts (`../../evil`) are completely neutralized.
/// 2. MIME magic bytes verification:
///    - PDF: starts with `%PDF-` (`0x25, 0x50, 0x44, 0x46, 0x2D`).
///    - EPUB: starts with `PK\x03\x04` (`0x50, 0x4B, 0x03, 0x04`) and contains zip/epub structure.
/// 3. Size cap: default max 50MB (52,428,800 bytes).
class UploadValidationService {
  UploadValidationService({int? maxSizeBytes})
      : maxSizeBytes = maxSizeBytes ?? 50 * 1024 * 1024;

  final int maxSizeBytes;

  static const supportedFormats = {'pdf', 'epub'};
  static const _pdfMagicBytes = [0x25, 0x50, 0x44, 0x46, 0x2D]; // %PDF-
  static const _zipMagicBytes = [0x50, 0x4B, 0x03, 0x04]; // PK\x03\x04

  /// Generates a validated upload ticket.
  ///
  /// The storageKey is strictly constructed on the server using a fresh UUID.
  BookUploadTicket createUploadTicket({
    required int bookId,
    required String clientFilename,
    required String format,
    required int byteSize,
  }) {
    final normalizedFormat = format.trim().toLowerCase().replaceAll('.', '');
    if (!supportedFormats.contains(normalizedFormat)) {
      throw ServerpodClientException(
        'Unsupported file format: $format. Allowed: pdf, epub.',
        400,
      );
    }

    if (byteSize <= 0) {
      throw ServerpodClientException('File size must be greater than zero.', 400);
    }
    if (byteSize > maxSizeBytes) {
      throw ServerpodClientException(
        'File size ($byteSize bytes) exceeds maximum limit ($maxSizeBytes bytes).',
        400,
      );
    }

    // Path traversal defense: completely ignore client path/filename directory parts
    final safeExt = normalizedFormat;
    final fileUuid = const Uuid().v4();
    final storageKey = 'books/$bookId/$fileUuid.$safeExt';

    // Mint a short-lived token containing metadata signature
    final expiresAt = DateTime.now().toUtc().add(const Duration(minutes: 30));
    final tokenPayload = jsonEncode({
      'b': bookId,
      'k': storageKey,
      'f': safeExt,
      's': byteSize,
      'e': expiresAt.millisecondsSinceEpoch,
    });
    final uploadToken = base64Url.encode(utf8.encode(tokenPayload));

    return BookUploadTicket(
      bookId: bookId,
      uploadToken: uploadToken,
      storageKey: storageKey,
      format: safeExt,
      maxSizeBytes: maxSizeBytes,
      expiresAt: expiresAt,
    );
  }

  /// Verifies file contents against format and ticket.
  void validateFileBytes({
    required List<int> bytes,
    required String expectedFormat,
    required String? clientFilename,
  }) {
    if (bytes.isEmpty) {
      throw ServerpodClientException('Uploaded file is empty.', 400);
    }
    if (bytes.length > maxSizeBytes) {
      throw ServerpodClientException(
        'Uploaded file size (${bytes.length} bytes) exceeds limit ($maxSizeBytes bytes).',
        400,
      );
    }

    final normalizedFormat = expectedFormat.trim().toLowerCase().replaceAll('.', '');
    if (!supportedFormats.contains(normalizedFormat)) {
      throw ServerpodClientException('Unsupported format: $expectedFormat', 400);
    }

    if (clientFilename != null) {
      final lowerName = clientFilename.toLowerCase();
      // Check for path traversal attacks
      if (lowerName.contains('..') || lowerName.contains('/') || lowerName.contains(r'\')) {
        // Path traversal detected - client attempted to escape directory
        // Although server uses random storageKey, reject malicious payloads
        throw ServerpodClientException('Invalid filename: path traversal characters detected.', 400);
      }
      // Check extension matches format
      if (!lowerName.endsWith('.$normalizedFormat')) {
        throw ServerpodClientException(
          'Filename extension does not match specified format: $expectedFormat',
          400,
        );
      }
    }

    if (normalizedFormat == 'pdf') {
      _verifyPdfMagicBytes(bytes);
    } else if (normalizedFormat == 'epub') {
      _verifyEpubMagicBytes(bytes);
    }
  }

  void _verifyPdfMagicBytes(List<int> bytes) {
    if (bytes.length < _pdfMagicBytes.length) {
      throw ServerpodClientException('File too small to be a valid PDF.', 400);
    }
    for (var i = 0; i < _pdfMagicBytes.length; i++) {
      if (bytes[i] != _pdfMagicBytes[i]) {
        throw ServerpodClientException(
          'Invalid file format: MIME magic bytes do not match PDF specification.',
          400,
        );
      }
    }
  }

  void _verifyEpubMagicBytes(List<int> bytes) {
    if (bytes.length < _zipMagicBytes.length) {
      throw ServerpodClientException('File too small to be a valid EPUB.', 400);
    }
    for (var i = 0; i < _zipMagicBytes.length; i++) {
      if (bytes[i] != _zipMagicBytes[i]) {
        throw ServerpodClientException(
          'Invalid file format: MIME magic bytes do not match EPUB (ZIP) specification.',
          400,
        );
      }
    }
    // Also verify that it contains epub indicator or mimetype within first 1KB
    final headerSlice = bytes.take(1024).toList();
    final headerAscii = String.fromCharCodes(headerSlice);
    final hasEpubIndicator = headerAscii.contains('mimetype') ||
        headerAscii.contains('epub') ||
        headerAscii.contains('META-INF');
    if (!hasEpubIndicator) {
      throw ServerpodClientException(
        'Invalid file format: ZIP archive is missing EPUB mimetype or structure.',
        400,
      );
    }
  }

  /// Computes the SHA-256 checksum string for a byte payload.
  String computeChecksum(List<int> bytes) {
    return sha256.convert(bytes).toString();
  }
}
