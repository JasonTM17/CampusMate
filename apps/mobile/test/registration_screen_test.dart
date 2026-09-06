import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';
import 'package:campusmate/features/auth/presentation/registration_screen.dart';
import 'package:campusmate/l10n/generated/app_localizations.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Drives the three-step registration screen without a live Serverpod server.
class _RegistrationRepo implements AuthRepository {
  int startCalls = 0;
  int verifyCalls = 0;
  int completeCalls = 0;
  String? completedPassword;

  @override
  Future<AuthUser> signIn({required String email, required String password}) =>
      throw UnimplementedError();

  @override
  Future<UuidValue> startRegistration({required String email}) async {
    startCalls++;
    return UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  }

  @override
  Future<String> verifyRegistrationCode({
    required UuidValue accountRequestId,
    required String verificationCode,
  }) async {
    verifyCalls++;
    return 'registration-token';
  }

  @override
  Future<AuthUser> completeRegistration({
    required String email,
    required String registrationToken,
    required String password,
  }) async {
    completeCalls++;
    completedPassword = password;
    return AuthUser(authUserId: 'user-1', email: email);
  }

  @override
  Future<AuthUser?> restore() async => null;

  @override
  Future<void> signOut() async {}
}

Widget _app(AuthRepository repository) {
  final router = GoRouter(
    initialLocation: '/register',
    routes: [
      GoRoute(path: '/register', builder: (_, _) => const RegistrationScreen()),
      GoRoute(
        path: '/ai',
        builder: (_, _) => const Scaffold(body: Text('AI_SCREEN')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [authRepositoryProvider.overrideWithValue(repository)],
    child: MaterialApp.router(
      routerConfig: router,
      locale: const Locale('vi'),
      supportedLocales: const [Locale('vi'), Locale('en')],
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('registration waits for the password step before finishing', (
    tester,
  ) async {
    final repo = _RegistrationRepo();
    await tester.pumpWidget(_app(repo));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'student001@campusmate.local',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Gửi mã'));
    await tester.pumpAndSettle();

    expect(repo.startCalls, 1);
    expect(find.text('Bước 2 · Mã xác minh'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mã xác minh'),
      '123456',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Xác minh mã'));
    await tester.pumpAndSettle();

    expect(repo.verifyCalls, 1);
    expect(repo.completeCalls, 0);
    expect(find.text('Bước 3 · Đặt mật khẩu'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mật khẩu mới'),
      'CampusMate#2026',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Xác nhận mật khẩu'),
      'CampusMate#2026',
    );
    await tester.tap(
      find.widgetWithText(FilledButton, 'Tạo tài khoản và đăng nhập'),
    );
    await tester.pumpAndSettle();

    expect(repo.completeCalls, 1);
    expect(repo.completedPassword, 'CampusMate#2026');
    expect(find.text('AI_SCREEN'), findsOneWidget);
  });
}
