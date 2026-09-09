import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../audit/audit_service.dart';
import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import 'upload_validation_service.dart';

class LibrarianService {
  LibrarianService({
    AuditService? audit,
    UploadValidationService? uploadValidation,
  })  : _audit = audit ?? AuditService(),
        _uploadValidation = uploadValidation ?? UploadValidationService();

  final AuditService _audit;
  final UploadValidationService _uploadValidation;

  Future<LibraryBook> createBook(
    Session session, {
    required String title,
    required List<String> authorNames,
    required int publishedYear,
    required String language,
    String? description,
    String? isbn,
    String? publisher,
    String? coverUrl,
    BookAccessType accessType = BookAccessType.authenticatedFullText,
    List<String>? categoryNames,
    int totalCopies = 1,
  }) async {
    final actorUserId = CampusMateAuth.requireUserId(session);
    final role = CampusMateAuth.roleFor(session);
    if (role != 'librarian' && role != 'admin') {
      throw ServerpodClientForbidden();
    }

    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      throw ServerpodClientException('Book title cannot be empty.', 400);
    }

    return session.db.transaction((transaction) async {
      final now = CampusClock.nowUtc();
      final book = await LibraryBook.db.insertRow(
        session,
        LibraryBook(
          title: trimmedTitle,
          description: description?.trim() ?? 'Chưa có mô tả.',
          isbn: isbn?.trim(),
          publisher: publisher?.trim() ?? 'NXB Trường ĐH Sư phạm Kỹ thuật',
          publishedYear: publishedYear,
          language: language.trim(),
          coverUrl: coverUrl?.trim(),
          accessType: accessType,
          license: 'Proprietary - CampusMate Library',
          keywords: authorNames.join(', '),
          searchText: '${trimmedTitle.toLowerCase()} ${authorNames.join(' ').toLowerCase()}',
          popularityScore: 0,
          isActive: true,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );

      // Link authors
      for (final authorName in authorNames.map((e) => e.trim()).where((e) => e.isNotEmpty)) {
        var author = await LibraryAuthor.db.findFirstRow(
          session,
          where: (t) => t.displayName.equals(authorName),
          transaction: transaction,
        );
        author ??= await LibraryAuthor.db.insertRow(
          session,
          LibraryAuthor(
            displayName: authorName,
            normalizedName: authorName.toLowerCase().replaceAll(RegExp(r'\s+'), ' '),
            createdAt: now,
            updatedAt: now,
          ),
          transaction: transaction,
        );
        await LibraryBookAuthor.db.insertRow(
          session,
          LibraryBookAuthor(
            bookId: book.id!,
            authorId: author.id!,
          ),
          transaction: transaction,
        );
      }

      // Link categories if provided
      if (categoryNames != null) {
        for (final catName in categoryNames.map((e) => e.trim()).where((e) => e.isNotEmpty)) {
          var cat = await LibraryCategory.db.findFirstRow(
            session,
            where: (t) => t.name.equals(catName),
            transaction: transaction,
          );
          cat ??= await LibraryCategory.db.insertRow(
            session,
            LibraryCategory(
              name: catName,
              slug: catName.toLowerCase().replaceAll(RegExp(r'\s+'), '-'),
              createdAt: now,
              updatedAt: now,
            ),
            transaction: transaction,
          );
          await LibraryBookCategory.db.insertRow(
            session,
            LibraryBookCategory(
              bookId: book.id!,
              categoryId: cat.id!,
            ),
            transaction: transaction,
          );
        }
      }

      // Create copies
      for (var i = 1; i <= totalCopies; i++) {
        final barcode = 'CM-B${book.id!}-C$i';
        await BookCopy.db.insertRow(
          session,
          BookCopy(
            bookId: book.id!,
            barcode: barcode,
            status: BookCopyStatus.available,
            createdAt: now,
            updatedAt: now,
          ),
          transaction: transaction,
        );
      }

      final action = role == 'admin' ? 'ADMIN_CREATE_BOOK' : 'LIBRARIAN_CREATE_BOOK';
      await _audit.record(
        session,
        actorUserId: actorUserId,
        action: action,
        resourceType: 'book',
        resourceId: book.id!.toString(),
        metadata: {
          'title': book.title,
          'accessType': accessType.name,
          'totalCopies': totalCopies,
        },
        transaction: transaction,
      );

      return book;
    });
  }

  Future<LibraryBook> updateBook(
    Session session, {
    required int bookId,
    String? title,
    int? publishedYear,
    String? language,
    String? description,
    String? isbn,
    String? publisher,
    String? coverUrl,
    BookAccessType? accessType,
    bool? isActive,
  }) async {
    final actorUserId = CampusMateAuth.requireUserId(session);
    final role = CampusMateAuth.roleFor(session);
    if (role != 'librarian' && role != 'admin') {
      throw ServerpodClientForbidden();
    }

    return session.db.transaction((transaction) async {
      final book = await LibraryBook.db.findById(
        session,
        bookId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (book == null) {
        throw ServerpodClientException('Book not found', 404);
      }

      final now = CampusClock.nowUtc();
      final updated = book.copyWith(
        title: title?.trim() ?? book.title,
        publishedYear: publishedYear ?? book.publishedYear,
        language: language?.trim() ?? book.language,
        description: description?.trim() ?? book.description,
        isbn: isbn?.trim() ?? book.isbn,
        publisher: publisher?.trim() ?? book.publisher,
        coverUrl: coverUrl?.trim() ?? book.coverUrl,
        accessType: accessType ?? book.accessType,
        isActive: isActive ?? book.isActive,
        updatedAt: now,
      );

      await LibraryBook.db.updateRow(session, updated, transaction: transaction);

      final action = role == 'admin' ? 'ADMIN_UPDATE_BOOK' : 'LIBRARIAN_UPDATE_BOOK';
      await _audit.record(
        session,
        actorUserId: actorUserId,
        action: action,
        resourceType: 'book',
        resourceId: bookId.toString(),
        metadata: {
          'title': updated.title,
          'accessType': updated.accessType.name,
          'isActive': updated.isActive,
        },
        transaction: transaction,
      );

      return updated;
    });
  }

  Future<LibraryBook> archiveBook(Session session, {required int bookId}) async {
    final actorUserId = CampusMateAuth.requireUserId(session);
    final role = CampusMateAuth.roleFor(session);
    if (role != 'librarian' && role != 'admin') {
      throw ServerpodClientForbidden();
    }

    return session.db.transaction((transaction) async {
      final book = await LibraryBook.db.findById(
        session,
        bookId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (book == null) {
        throw ServerpodClientException('Book not found', 404);
      }

      final now = CampusClock.nowUtc();
      final updated = book.copyWith(isActive: false, updatedAt: now);
      await LibraryBook.db.updateRow(session, updated, transaction: transaction);

      final action = role == 'admin' ? 'ADMIN_ARCHIVE_BOOK' : 'LIBRARIAN_ARCHIVE_BOOK';
      await _audit.record(
        session,
        actorUserId: actorUserId,
        action: action,
        resourceType: 'book',
        resourceId: bookId.toString(),
        metadata: {'title': book.title, 'isActive': false},
        transaction: transaction,
      );

      return updated;
    });
  }

  BookUploadTicket requestUploadTicket(
    Session session, {
    required int bookId,
    required String filename,
    required String format,
    required int byteSize,
  }) {
    final role = CampusMateAuth.roleFor(session);
    if (role != 'librarian' && role != 'admin') {
      throw ServerpodClientForbidden();
    }

    return _uploadValidation.createUploadTicket(
      bookId: bookId,
      clientFilename: filename,
      format: format,
      byteSize: byteSize,
    );
  }

  Future<LibraryBookFile> uploadBookFile(
    Session session, {
    required int bookId,
    required String uploadToken,
    required List<int> fileBytes,
    required String format,
    String? clientFilename,
  }) async {
    final actorUserId = CampusMateAuth.requireUserId(session);
    final role = CampusMateAuth.roleFor(session);
    if (role != 'librarian' && role != 'admin') {
      throw ServerpodClientForbidden();
    }

    // Validate the file payload and magic bytes
    _uploadValidation.validateFileBytes(
      bytes: fileBytes,
      expectedFormat: format,
      clientFilename: clientFilename,
    );

    final checksum = _uploadValidation.computeChecksum(fileBytes);
    final cleanFormat = format.trim().toLowerCase().replaceAll('.', '');
    final fileUuid = const Uuid().v4();
    final storageKey = 'books/$bookId/$fileUuid.$cleanFormat';
    final now = CampusClock.nowUtc();

    return session.db.transaction((transaction) async {
      final book = await LibraryBook.db.findById(
        session,
        bookId,
        transaction: transaction,
      );
      if (book == null) {
        throw ServerpodClientException('Book not found', 404);
      }

      // Check if file format already exists for this book
      final existing = await LibraryBookFile.db.findFirstRow(
        session,
        where: (t) => t.bookId.equals(bookId) & t.format.equals(cleanFormat),
        transaction: transaction,
      );

      LibraryBookFile savedFile;
      if (existing != null) {
        savedFile = existing.copyWith(
          storageKey: storageKey,
          byteSize: fileBytes.length,
          checksum: checksum,
          isPrimary: true,
          createdAt: now,
        );
        await LibraryBookFile.db.updateRow(
          session,
          savedFile,
          transaction: transaction,
        );
      } else {
        savedFile = await LibraryBookFile.db.insertRow(
          session,
          LibraryBookFile(
            bookId: bookId,
            format: cleanFormat,
            storageKey: storageKey,
            byteSize: fileBytes.length,
            checksum: checksum,
            isPrimary: true,
            createdAt: now,
          ),
          transaction: transaction,
        );
      }

      final action = role == 'admin' ? 'ADMIN_UPLOAD_BOOK' : 'LIBRARIAN_UPLOAD_BOOK';
      await _audit.record(
        session,
        actorUserId: actorUserId,
        action: action,
        resourceType: 'book_file',
        resourceId: savedFile.id!.toString(),
        metadata: {
          'bookId': bookId,
          'format': cleanFormat,
          'byteSize': fileBytes.length,
          'storageKey': storageKey,
          'checksum': checksum,
        },
        transaction: transaction,
      );

      return savedFile;
    });
  }
}
