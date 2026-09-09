import 'package:serverpod/serverpod.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import '../library/library_catalog_service.dart';
import 'librarian_service.dart';

/// Primary librarian operations surface.
///
/// Protected by `campusMateLibrarianScope`. Students and unauthorized roles
/// are strictly rejected at the Serverpod scope boundary.
class LibrarianEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {campusMateLibrarianScope};

  final _service = LibrarianService();
  final _catalogService = LibraryCatalogService();

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
    BookAccessType? accessType,
    List<String>? categoryNames,
    int? totalCopies,
  }) => _service.createBook(
    session,
    title: title,
    authorNames: authorNames,
    publishedYear: publishedYear,
    language: language,
    description: description,
    isbn: isbn,
    publisher: publisher,
    coverUrl: coverUrl,
    accessType: accessType ?? BookAccessType.authenticatedFullText,
    categoryNames: categoryNames,
    totalCopies: totalCopies ?? 1,
  );

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
  }) => _service.updateBook(
    session,
    bookId: bookId,
    title: title,
    publishedYear: publishedYear,
    language: language,
    description: description,
    isbn: isbn,
    publisher: publisher,
    coverUrl: coverUrl,
    accessType: accessType,
    isActive: isActive,
  );

  Future<LibraryBook> archiveBook(
    Session session, {
    required int bookId,
  }) => _service.archiveBook(
    session,
    bookId: bookId,
  );

  Future<BookUploadTicket> requestUploadTicket(
    Session session, {
    required int bookId,
    required String filename,
    required String format,
    required int byteSize,
  }) async => _service.requestUploadTicket(
    session,
    bookId: bookId,
    filename: filename,
    format: format,
    byteSize: byteSize,
  );

  Future<LibraryBookFile> uploadBookFile(
    Session session, {
    required int bookId,
    required String uploadToken,
    required List<int> fileBytes,
    required String format,
    String? clientFilename,
  }) => _service.uploadBookFile(
    session,
    bookId: bookId,
    uploadToken: uploadToken,
    fileBytes: fileBytes,
    format: format,
    clientFilename: clientFilename,
  );

  Future<BookAccessPolicyUpdate> updateAccessPolicy(
    Session session, {
    required int bookId,
    required BookAccessType accessType,
  }) => _catalogService.updateAccessPolicy(
    session,
    bookId: bookId,
    accessType: accessType,
  );
}
