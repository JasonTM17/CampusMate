import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../data/serverpod_student_profile_repository.dart';
import '../domain/student_profile_repository.dart';

final studentProfileRepositoryProvider = Provider<StudentProfileRepository>(
  (ref) =>
      ServerpodStudentProfileRepository(ref.watch(serverpodClientProvider)),
);

final studentProfileControllerProvider =
    AsyncNotifierProvider<StudentProfileController, StudentProfile>(
      StudentProfileController.new,
    );

class StudentProfileController extends AsyncNotifier<StudentProfile> {
  StudentProfileRepository get _repository =>
      ref.read(studentProfileRepositoryProvider);

  @override
  Future<StudentProfile> build() => _repository.getMyProfile();

  Future<void> updateMyProfile({
    required String fullName,
    required String className,
  }) async {
    // No AsyncLoading swap here: wiping `state` would unmount the form for a
    // full-screen spinner on every save. The screen drives the save spinner
    // locally while the profile data (and scroll position) stays put.
    state = await AsyncValue.guard(
      () =>
          _repository.updateMyProfile(fullName: fullName, className: className),
    );
  }
}
