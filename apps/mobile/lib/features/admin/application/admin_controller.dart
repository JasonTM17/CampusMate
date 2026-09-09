import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/admin_repository.dart';

final adminStatsProvider = FutureProvider<AdminDashboardStats>((ref) async {
  final repo = ref.watch(adminRepositoryProvider);
  return repo.getDashboardStats();
});

class AdminStudentsQueryNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void setQuery(String? query) => state = query;
}

final adminStudentsQueryProvider =
    NotifierProvider<AdminStudentsQueryNotifier, String?>(
  AdminStudentsQueryNotifier.new,
);

class AdminStudentsStatusNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void setStatus(String? status) => state = status;
}

final adminStudentsStatusProvider =
    NotifierProvider<AdminStudentsStatusNotifier, String?>(
  AdminStudentsStatusNotifier.new,
);

final adminStudentsProvider = FutureProvider<AdminStudentPage>((ref) async {
  final repo = ref.watch(adminRepositoryProvider);
  final query = ref.watch(adminStudentsQueryProvider);
  final status = ref.watch(adminStudentsStatusProvider);
  return repo.listStudents(query: query, status: status);
});

final adminAnnouncementsProvider = FutureProvider<AdminAnnouncementPage>((ref) async {
  final repo = ref.watch(adminRepositoryProvider);
  return repo.listAnnouncements();
});

final adminAuditLogsProvider = FutureProvider<AdminAuditLogPage>((ref) async {
  final repo = ref.watch(adminRepositoryProvider);
  return repo.listAuditLogs();
});

class AdminBooksQueryNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void setQuery(String? query) => state = query;
}

final adminBooksQueryProvider =
    NotifierProvider<AdminBooksQueryNotifier, String?>(
  AdminBooksQueryNotifier.new,
);

final adminBooksProvider = FutureProvider<LibrarySearchPage>((ref) async {
  final repo = ref.watch(adminRepositoryProvider);
  final query = ref.watch(adminBooksQueryProvider);
  return repo.listBooks(query: query);
});

class AdminMutationsController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  AdminRepository get _repo => ref.read(adminRepositoryProvider);

  Future<void> toggleStudentStatus(int profileId, bool currentIsActive) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.setStudentStatus(profileId: profileId, isActive: !currentIsActive);
      ref.invalidate(adminStudentsProvider);
      ref.invalidate(adminStatsProvider);
    });
  }

  Future<void> createAnnouncement({
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.createAnnouncement(
        title: title,
        body: body,
        audience: audience,
        publishAt: publishAt,
      );
      ref.invalidate(adminAnnouncementsProvider);
    });
  }

  Future<void> archiveAnnouncement(int announcementId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.archiveAnnouncement(announcementId: announcementId);
      ref.invalidate(adminAnnouncementsProvider);
    });
  }

  Future<void> updateBookAccessPolicy(int bookId, BookAccessType accessType) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.updateBookAccessPolicy(bookId: bookId, accessType: accessType);
      ref.invalidate(adminBooksProvider);
    });
  }
}

final adminMutationsControllerProvider =
    AsyncNotifierProvider<AdminMutationsController, void>(
  AdminMutationsController.new,
);
