import 'package:serverpod/serverpod.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';

class BookAccessPolicyService {
  BookAccessDecision evaluateForSession(
    Session session,
    LibraryBook book, {
    bool hasActiveLoan = false,
    DateTime? now,
  }) {
    final role = CampusMateAuth.roleFor(session);
    return evaluate(
      role: role,
      book: book,
      hasActiveLoan: hasActiveLoan,
      now: now,
    );
  }

  BookAccessDecision evaluate({
    required String role,
    required LibraryBook book,
    bool hasActiveLoan = false,
    DateTime? now,
  }) {
    final normalizedRole = _normalizeRole(role);
    final timestamp = (now ?? DateTime.now().toUtc()).toUtc();
    if (!book.isActive) {
      return BookAccessDecision(
        role: normalizedRole,
        canRead: false,
        canDownload: false,
        canBorrow: false,
        reason: 'Tài liệu chưa được phát hành trong thư viện.',
      );
    }

    final licenseExpired =
        book.licenseExpiresAt != null &&
        !book.licenseExpiresAt!.toUtc().isAfter(timestamp);
    if (licenseExpired) {
      return BookAccessDecision(
        role: normalizedRole,
        canRead: false,
        canDownload: false,
        canBorrow: false,
        reason: 'Quyền truy cập tài liệu đã hết hạn.',
      );
    }

    return switch (book.accessType) {
      BookAccessType.publicFullText => BookAccessDecision(
        role: normalizedRole,
        canRead: true,
        canDownload: true,
        canBorrow: false,
        reason: null,
      ),
      BookAccessType.authenticatedFullText => BookAccessDecision(
        role: normalizedRole,
        canRead: _isCampusRole(normalizedRole),
        canDownload: _isCampusRole(normalizedRole),
        canBorrow: false,
        reason: _isCampusRole(normalizedRole)
            ? null
            : 'Bạn cần đăng nhập bằng tài khoản CampusMate.',
      ),
      BookAccessType.borrowRequired => BookAccessDecision(
        role: normalizedRole,
        canRead: hasActiveLoan || _isPrivilegedRole(normalizedRole),
        canDownload: false,
        canBorrow: !hasActiveLoan && _canBorrow(normalizedRole),
        reason: hasActiveLoan || _isPrivilegedRole(normalizedRole)
            ? null
            : 'Bạn cần mượn tài liệu trước khi đọc.',
      ),
      BookAccessType.metadataOnly => BookAccessDecision(
        role: normalizedRole,
        canRead: false,
        canDownload: false,
        canBorrow: false,
        reason: 'Tài liệu này hiện chỉ có thông tin tham khảo.',
      ),
      BookAccessType.restricted => BookAccessDecision(
        role: normalizedRole,
        canRead: _isPrivilegedRole(normalizedRole),
        canDownload: false,
        canBorrow: false,
        reason: _isPrivilegedRole(normalizedRole)
            ? 'Tài liệu giới hạn; chỉ mở trong khu vực quản trị thư viện.'
            : 'Tài liệu này bị giới hạn quyền truy cập.',
      ),
    };
  }

  bool mayViewDetail({
    required String role,
    required LibraryBook book,
  }) {
    if (book.isActive) return true;
    return _isPrivilegedRole(_normalizeRole(role));
  }

  bool _canBorrow(String role) => role == 'student' || role == 'lecturer';

  bool _isCampusRole(String role) =>
      role == 'student' ||
      role == 'lecturer' ||
      role == 'librarian' ||
      role == 'admin';

  bool _isPrivilegedRole(String role) => role == 'librarian' || role == 'admin';

  String _normalizeRole(String role) => switch (role.trim().toLowerCase()) {
    'admin' => 'admin',
    'librarian' => 'librarian',
    'lecturer' => 'lecturer',
    _ => 'student',
  };
}
