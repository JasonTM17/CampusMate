import 'package:campusmate_client/campusmate_client.dart';

import '../domain/student_profile_repository.dart';

class ServerpodStudentProfileRepository implements StudentProfileRepository {
  const ServerpodStudentProfileRepository(this._client);

  final Client _client;

  @override
  Future<StudentProfile> getMyProfile() =>
      _client.studentProfile.getMyProfile();

  @override
  Future<StudentProfile> updateMyProfile({
    required String fullName,
    required String className,
  }) => _client.studentProfile.updateMyProfile(
    fullName: fullName,
    className: className,
  );
}
