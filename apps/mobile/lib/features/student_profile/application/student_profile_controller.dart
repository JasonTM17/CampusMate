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
    // Save failures propagate to the screen (which shows a snackbar) instead
    // of replacing `state`: an AsyncError here would swap the whole form for
    // the full-screen error view and destroy the user's typed input.
    await _repository.updateMyProfile(fullName: fullName, className: className);
  }
}
