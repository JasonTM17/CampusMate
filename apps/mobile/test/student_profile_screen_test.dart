import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';
import 'package:campusmate/features/student_profile/application/student_profile_controller.dart';
import 'package:campusmate/features/student_profile/domain/student_profile_repository.dart';
import 'package:campusmate/features/student_profile/presentation/student_profile_screen.dart';
import 'package:campusmate/l10n/generated/app_localizations.dart';

final _initialProfile = StudentProfile(
  authUserId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
  studentCode: 'SV001',
  fullName: 'Nguyen Van A',
  faculty: 'Cong nghe thong tin',
  major: 'Ky thuat phan mem',
  className: 'CNTT-K1',
  gpa: 3.5,
  credits: 42,
  conductScore: 90,
  role: 'student',
  createdAt: DateTime.utc(2026, 1, 1),
  updatedAt: DateTime.utc(2026, 1, 1),
);

class _ProfileRepository implements StudentProfileRepository {
  StudentProfile profile = _initialProfile;

  @override
  Future<StudentProfile> getMyProfile() async => profile;

  @override
  Future<StudentProfile> updateMyProfile({
    required String fullName,
    required String className,
  }) async {
    profile = profile.copyWith(fullName: fullName, className: className);
    return profile;
  }
}

class _AuthRepository implements AuthRepository {
  @override
  Future<AuthUser> signIn({required String email, required String password}) =>
      throw UnimplementedError();

  @override
  Future<UuidValue> startRegistration({required String email}) =>
      throw UnimplementedError();

  @override
  Future<String> verifyRegistrationCode({
    required UuidValue accountRequestId,
    required String verificationCode,
  }) => throw UnimplementedError();

  @override
  Future<AuthUser> completeRegistration({
    required String email,
    required String registrationToken,
    required String password,
  }) => throw UnimplementedError();

  @override
  Future<UuidValue> startPasswordReset({required String email}) =>
      throw UnimplementedError();

  @override
  Future<String> verifyPasswordResetCode({
    required UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => throw UnimplementedError();

  @override
  Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => throw UnimplementedError();

  @override
  Future<AuthUser?> restore() async => const AuthUser(
    authUserId: '00000000-0000-4000-8000-000000000001',
    email: 'student001@campusmate.local',
  );

  @override
  Future<void> signOut() async {}
}

void main() {
  testWidgets('loads and saves the authenticated student profile', (
    tester,
  ) async {
    final repository = _ProfileRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(_AuthRepository()),
          studentProfileRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          locale: const Locale('vi'),
          supportedLocales: const [Locale('vi'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          home: const StudentProfileScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('SV001'), findsOneWidget);
    expect(find.text('Cong nghe thong tin'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Nguyen Van A'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Tran Thi B');
    await tester.enterText(fields.at(1), 'CNTT-K2');
    await tester.tap(find.widgetWithText(FilledButton, 'Lưu thay đổi'));
    await tester.pumpAndSettle();

    expect(repository.profile.fullName, 'Tran Thi B');
    expect(repository.profile.className, 'CNTT-K2');
    expect(find.text('Đã lưu hồ sơ.'), findsOneWidget);
  });
}
