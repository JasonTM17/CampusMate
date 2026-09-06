import 'package:campusmate_client/campusmate_client.dart';

abstract interface class StudentProfileRepository {
  Future<StudentProfile> getMyProfile();

  Future<StudentProfile> updateMyProfile({
    required String fullName,
    required String className,
  });
}
