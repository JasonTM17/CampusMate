import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../auth/application/auth_controller.dart';
import '../data/serverpod_academic_repository.dart';
import '../domain/academic_repository.dart';

final academicRepositoryProvider = Provider<AcademicRepository>(
  (ref) => ServerpodAcademicRepository(
    ServerpodAcademicRemoteDataSource(ref.watch(serverpodClientProvider)),
    ref.watch(campusMateDatabaseProvider),
  ),
);

final academicControllerProvider =
    AsyncNotifierProvider<AcademicController, AcademicSnapshot>(
      AcademicController.new,
    );

class AcademicController extends AsyncNotifier<AcademicSnapshot> {
  AcademicRepository get _repository => ref.read(academicRepositoryProvider);

  @override
  Future<AcademicSnapshot> build() async {
    final accountId = ref.watch(authControllerProvider).user?.authUserId;
    if (accountId == null) {
      throw StateError('Academic data requires an authenticated account.');
    }
    return _repository.loadDashboard(accountId: accountId);
  }

  Future<void> refresh() async {
    final accountId = ref.read(authControllerProvider).user?.authUserId;
    if (accountId == null) return;
    state = const AsyncLoading<AcademicSnapshot>();
    state = await AsyncValue.guard(
      () => _repository.loadDashboard(accountId: accountId),
    );
  }

  Future<void> loadFor({DateTime? weekStart, int? semesterId}) async {
    final accountId = ref.read(authControllerProvider).user?.authUserId;
    if (accountId == null) return;
    state = const AsyncLoading<AcademicSnapshot>();
    state = await AsyncValue.guard(
      () => _repository.loadDashboard(
        accountId: accountId,
        weekStart: weekStart,
        semesterId: semesterId,
      ),
    );
  }
}
