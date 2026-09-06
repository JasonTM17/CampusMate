import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/app/app.dart';
import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';

class _UnauthenticatedRepository implements AuthRepository {
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
  Future<AuthUser?> restore() async => null;

  @override
  Future<void> signOut() async {}
}

void main() {
  testWidgets('redirects an unauthenticated initial route to login', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            _UnauthenticatedRepository(),
          ),
        ],
        child: const CampusMateApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chào mừng trở lại'), findsOneWidget);
    expect(find.text('Trang chủ'), findsNothing);
  });
}
