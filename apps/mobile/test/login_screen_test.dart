import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_failure.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/presentation/login_screen.dart';
import 'package:campusmate/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'auth_controller_test.dart';

/// Boots [LoginScreen] inside a router with a Vietnamese locale so l10n and
/// navigation behave like production.
Widget _app(AuthRepository repository) {
  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
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

  testWidgets('signs in and routes to /ai on valid credentials', (
    tester,
  ) async {
    final repo = FakeAuthRepository(restoreResult: null);
    await tester.pumpWidget(_app(repo));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'student001@campusmate.local',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mật khẩu'),
      'CampusMate#2026',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Đăng nhập'));
    await tester.pumpAndSettle();

    expect(repo.signInCalls, 1);
    expect(find.text('AI_SCREEN'), findsOneWidget);
  });

  testWidgets('shows the friendly invalid-credentials message on failure', (
    tester,
  ) async {
    final repo = FakeAuthRepository(
      signInError: const InvalidCredentialsFailure(),
    );
    await tester.pumpWidget(_app(repo));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'student001@campusmate.local',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mật khẩu'),
      'wrong-password',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Đăng nhập'));
    await tester.pumpAndSettle();

    expect(find.text('Email hoặc mật khẩu không đúng.'), findsOneWidget);
    expect(repo.signInCalls, 1);
  });

  testWidgets('blocks submit with invalid email before calling the server', (
    tester,
  ) async {
    final repo = FakeAuthRepository();
    await tester.pumpWidget(_app(repo));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'khong-phai-email',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Đăng nhập'));
    await tester.pumpAndSettle();

    expect(repo.signInCalls, 0);
    expect(find.text('Vui lòng nhập email hợp lệ.'), findsOneWidget);
  });
}
