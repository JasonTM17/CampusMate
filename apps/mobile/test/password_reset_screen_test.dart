import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';
import 'package:campusmate/features/auth/presentation/password_reset_screen.dart';
import 'package:campusmate/l10n/generated/app_localizations.dart';

class _PasswordResetRepository implements AuthRepository {
  int startCalls = 0;
  int verifyCalls = 0;
  int finishCalls = 0;
  String? newPassword;

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
  Future<UuidValue> startPasswordReset({required String email}) async {
    startCalls++;
    return UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  }

  @override
  Future<String> verifyPasswordResetCode({
    required UuidValue passwordResetRequestId,
    required String verificationCode,
  }) async {
    verifyCalls++;
    return 'finish-token';
  }

  @override
  Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) async {
    finishCalls++;
    this.newPassword = newPassword;
  }

  @override
  Future<AuthUser?> restore() async => null;

  @override
  Future<void> signOut() async {}
}

Widget _app(_PasswordResetRepository repository) {
  final router = GoRouter(
    initialLocation: '/reset-password',
    routes: [
      GoRoute(
        path: '/reset-password',
        builder: (_, _) => const PasswordResetScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, _) => const Scaffold(body: Text('LOGIN_SCREEN')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [authRepositoryProvider.overrideWithValue(repository)],
    child: MaterialApp.router(
      routerConfig: router,
      locale: const Locale('vi'),
      supportedLocales: const [Locale('vi'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
    ),
  );
}

void main() {
  testWidgets('password reset advances through email, code, and new password', (
    tester,
  ) async {
    final repository = _PasswordResetRepository();
    await tester.pumpWidget(_app(repository));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'student001@campusmate.local',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Gửi mã'));
    await tester.pumpAndSettle();
    expect(repository.startCalls, 1);
    expect(find.text('Bước 2 · Mã xác minh'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mã xác minh'),
      '123456',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Xác minh mã'));
    await tester.pumpAndSettle();
    expect(repository.verifyCalls, 1);
    expect(find.text('Bước 3 · Mật khẩu mới'), findsOneWidget);

    final passwordFields = find.byType(TextFormField);
    await tester.enterText(passwordFields.at(0), 'local-test-password');
    await tester.enterText(passwordFields.at(1), 'local-test-password');
    await tester.tap(find.widgetWithText(FilledButton, 'Đổi mật khẩu'));
    await tester.pumpAndSettle();

    expect(repository.finishCalls, 1);
    expect(repository.newPassword, 'local-test-password');
    expect(find.text('LOGIN_SCREEN'), findsOneWidget);
  });
}
