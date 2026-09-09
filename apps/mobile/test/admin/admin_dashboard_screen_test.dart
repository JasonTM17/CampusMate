import 'package:campusmate/features/admin/data/admin_repository.dart';
import 'package:campusmate/features/admin/presentation/admin_dashboard_screen.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAdminRepository implements AdminRepository {
  @override
  Future<AdminDashboardStats> getDashboardStats() async {
    return AdminDashboardStats(
      totalStudents: 120,
      activeStudents: 115,
      totalBooks: 45,
      activeLoans: 12,
      aiRequestsToday: 89,
    );
  }

  @override
  Future<AdminStudentPage> listStudents({String? query, String? status, int? limit}) async {
    return AdminStudentPage(
      students: [
        AdminStudentItem(
          id: 1,
          authUserId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
          studentCode: 'SV2026001',
          fullName: 'Nguyễn Minh Anh',
          className: 'K68PM01',
          faculty: 'Công nghệ Thông tin',
          role: 'student',
          status: 'active',
          createdAt: DateTime.utc(2026, 9, 1),
        ),
      ],
      totalCount: 1,
    );
  }

  @override
  Future<StudentProfile> setStudentStatus({required int profileId, required bool isActive}) async {
    return StudentProfile(
      id: profileId,
      authUserId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      role: 'student',
      status: isActive ? 'active' : 'inactive',
      createdAt: DateTime.utc(2026, 9, 1),
      updatedAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<AdminAnnouncementPage> listAnnouncements({bool? includeArchived, int? limit}) async {
    return AdminAnnouncementPage(
      announcements: [
        Announcement(
          id: 1,
          title: 'Chào đón tân sinh viên 2026',
          body: 'Thông báo lễ khai giảng cho toàn thể sinh viên.',
          audience: 'student',
          publishAt: DateTime.utc(2026, 9, 1),
          archived: false,
          createdAt: DateTime.utc(2026, 9, 1),
          updatedAt: DateTime.utc(2026, 9, 1),
        ),
      ],
      totalCount: 1,
    );
  }

  @override
  Future<Announcement> createAnnouncement({
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
  }) async {
    return Announcement(
      id: 2,
      title: title,
      body: body,
      audience: audience,
      publishAt: publishAt,
      archived: false,
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<Announcement> archiveAnnouncement({required int announcementId}) async {
    return Announcement(
      id: announcementId,
      title: 'Archived',
      body: 'Archived',
      audience: 'student',
      publishAt: DateTime.utc(2026, 9, 1),
      archived: true,
      createdAt: DateTime.utc(2026, 9, 1),
      updatedAt: DateTime.utc(2026, 9, 9),
    );
  }

  @override
  Future<AdminAuditLogPage> listAuditLogs({String? action, int? limit}) async {
    return AdminAuditLogPage(
      logs: [
        AuditLog(
          id: 1,
          actorUserId: UuidValue.fromString('00000000-0000-4000-8000-0000000000a1'),
          action: 'ADMIN_CREATE_STUDENT',
          resourceType: 'student_profile',
          resourceId: '1',
          metadataJson: '{"studentCode":"SV2026001"}',
          createdAt: DateTime.utc(2026, 9, 9, 10),
        ),
      ],
      totalCount: 1,
    );
  }

  @override
  Future<LibrarySearchPage> listBooks({String? query, int limit = 20}) async {
    return LibrarySearchPage(
      items: [
        BookSummary(
          id: 1,
          title: 'Nhập môn Lập trình',
          description: 'Giáo trình lập trình cơ bản',
          publisher: 'NXB ĐHSPKT',
          publishedYear: 2026,
          language: 'vi',
          accessType: BookAccessType.authenticatedFullText,
          license: 'Proprietary',
          authors: ['TS. Lê Văn Thắng'],
          categories: ['Công nghệ'],
          courseCodes: [],
          availableFormats: ['pdf'],
          isFavorite: false,
          access: BookAccessDecision(
            role: 'student',
            canRead: true,
            canDownload: false,
            canBorrow: false,
          ),
        ),
      ],
      totalCount: 1,
    );
  }

  @override
  Future<BookAccessPolicyUpdate> updateBookAccessPolicy({
    required int bookId,
    required BookAccessType accessType,
  }) async {
    return BookAccessPolicyUpdate(
      bookId: bookId,
      accessType: accessType,
      updatedAt: DateTime.utc(2026, 9, 9),
    );
  }
}

void main() {
  testWidgets('AdminDashboardScreen renders dashboard aggregates and navigation tabs', (tester) async {
    final fakeRepo = _FakeAdminRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminRepositoryProvider.overrideWithValue(fakeRepo),
        ],
        child: const MaterialApp(
          home: AdminDashboardScreen(),
        ),
      ),
    );

    // Initial loading
    await tester.pump();
    await tester.pumpAndSettle();

    // Verify screen title
    expect(find.text('Bảng điều khiển Quản trị'), findsOneWidget);

    // Verify metric badges
    expect(find.text('Tổng SV'), findsOneWidget);
    expect(find.text('120'), findsOneWidget);
    expect(find.text('SV Hoạt động'), findsOneWidget);
    expect(find.text('115'), findsOneWidget);
    expect(find.text('Tổng Sách'), findsOneWidget);
    expect(find.text('45'), findsOneWidget);
    expect(find.text('Đang mượn'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('AI Hôm nay'), findsOneWidget);
    expect(find.text('89'), findsOneWidget);

    // Verify tab labels
    expect(find.text('Sinh viên'), findsOneWidget);
    expect(find.text('Thư viện'), findsOneWidget);
    expect(find.text('Thông báo'), findsOneWidget);
    expect(find.text('Nhật ký kiểm toán'), findsOneWidget);

    // Verify student in the first tab
    expect(find.text('Nguyễn Minh Anh (SV2026001)'), findsOneWidget);
  });
}
