import 'package:campusmate_server/src/auth/auth_setup.dart';
import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:test/test.dart';

void main() {
  test('defaults public registration to the student scope', () {
    expect(scopesForNewCampusMateUser({}), {campusMateStudentScope});
  });

  test('preserves an explicit trusted role scope', () {
    expect(
      scopesForNewCampusMateUser({campusMateAdminScope}),
      {campusMateAdminScope},
    );
  });
}
