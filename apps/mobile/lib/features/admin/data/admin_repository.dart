import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';

abstract class AdminRepository {
  Future<AdminDashboardStats> getDashboardStats();
  Future<AdminStudentPage> listStudents({
    String? query,
    String? status,
    int? limit,
  });
  Future<StudentProfile> setStudentStatus({
    required int profileId,
    required bool isActive,
  });
  Future<AdminAnnouncementPage> listAnnouncements({
    bool? includeArchived,
    int? limit,
  });
  Future<Announcement> createAnnouncement({
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
  });
  Future<Announcement> archiveAnnouncement({required int announcementId});
  Future<AdminAuditLogPage> listAuditLogs({String? action, int? limit});
  Future<LibrarySearchPage> listBooks({String? query, int limit = 20});
  Future<BookAccessPolicyUpdate> updateBookAccessPolicy({
    required int bookId,
    required BookAccessType accessType,
  });
}

class ServerpodAdminRepository implements AdminRepository {
  ServerpodAdminRepository(this._client);

  final Client _client;

  @override
  Future<AdminDashboardStats> getDashboardStats() {
    return _client.admin.getDashboardStats();
  }

  @override
  Future<AdminStudentPage> listStudents({
    String? query,
    String? status,
    int? limit,
  }) {
    return _client.admin.listStudents(
      query: query,
      status: status,
      limit: limit,
    );
  }

  @override
  Future<StudentProfile> setStudentStatus({
    required int profileId,
    required bool isActive,
  }) {
    return _client.admin.setStudentStatus(
      profileId: profileId,
      isActive: isActive,
    );
  }

  @override
  Future<AdminAnnouncementPage> listAnnouncements({
    bool? includeArchived,
    int? limit,
  }) {
    return _client.admin.listAnnouncements(
      includeArchived: includeArchived,
      limit: limit,
    );
  }

  @override
  Future<Announcement> createAnnouncement({
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
  }) {
    return _client.admin.createAnnouncement(
      title: title,
      body: body,
      audience: audience,
      publishAt: publishAt,
    );
  }

  @override
  Future<Announcement> archiveAnnouncement({required int announcementId}) {
    return _client.admin.archiveAnnouncement(announcementId: announcementId);
  }

  @override
  Future<AdminAuditLogPage> listAuditLogs({String? action, int? limit}) {
    return _client.admin.listAuditLogs(action: action, limit: limit);
  }

  @override
  Future<LibrarySearchPage> listBooks({String? query, int limit = 20}) {
    return _client.library.search(
      query: query,
      limit: limit,
      relatedToMyCourses: false,
    );
  }

  @override
  Future<BookAccessPolicyUpdate> updateBookAccessPolicy({
    required int bookId,
    required BookAccessType accessType,
  }) {
    return _client.library.updateAccessPolicy(
      bookId: bookId,
      accessType: accessType,
    );
  }
}

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  final client = ref.watch(serverpodClientProvider);
  return ServerpodAdminRepository(client);
});
