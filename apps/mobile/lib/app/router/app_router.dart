import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/domain/auth_user.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/password_reset_screen.dart';
import '../../features/auth/presentation/registration_screen.dart';
import '../../features/academics/presentation/academic_screen.dart';
import '../../features/academics/presentation/exam_detail_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/library/presentation/book_detail_screen.dart';
import '../../features/library/presentation/library_screen.dart';
import '../../features/notifications/presentation/notification_screen.dart';
import '../../features/student_profile/presentation/student_profile_screen.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../core/widgets/app_empty_state.dart';
import 'auth_redirects.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authStateNotifier = ValueNotifier(ref.read(authControllerProvider));
  ref
    ..onDispose(authStateNotifier.dispose)
    ..listen<AuthState>(
      authControllerProvider,
      (_, next) => authStateNotifier.value = next,
    );

  return GoRouter(
    initialLocation: '/home',
    refreshListenable: authStateNotifier,
    redirect: (context, state) {
      final authState = authStateNotifier.value;
      final path = state.uri.path;
      final isAuthRoute = isAuthScreenPath(path);
      final isLoadingRoute = path == authLoadingPath;

      if (authState.status == AuthStatus.unknown) {
        return isAuthRoute || isLoadingRoute
            ? null
            : guardedAuthRouteFor(state.uri, authLoadingPath);
      }
      if (!authState.isAuthenticated) {
        return isAuthRoute ? null : guardedAuthRouteFor(state.uri, loginPath);
      }
      if (isAuthRoute || isLoadingRoute) return postAuthRouteFor(state.uri);
      return null;
    },
    routes: [
      // Auth screens live outside the navigation shell (no bottom bar).
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const PasswordResetScreen(),
      ),
      GoRoute(
        path: authLoadingPath,
        builder: (context, state) => const _AuthLoadingScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/admin',
        redirect: (context, state) {
          final role = authStateNotifier.value.user?.role;
          return role != null && canAccessPrivilegedArea(role) ? null : '/home';
        },
        builder: (context, state) => BranchPlaceholderScreen(
          icon: Icons.admin_panel_settings_outlined,
          title: AppLocalizations.of(context)!.profilePrivilegedArea,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/academic',
                builder: (context, state) => const AcademicScreen(),
                routes: [
                  GoRoute(
                    path: 'exams/:examId',
                    builder: (context, state) {
                      final examId = int.tryParse(
                        state.pathParameters['examId'] ?? '',
                      );
                      if (examId == null) {
                        return const _InvalidDeepLinkScreen();
                      }
                      return ExamDetailScreen(examId: examId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryScreen(),
                routes: [
                  GoRoute(
                    path: 'books/:bookId',
                    builder: (context, state) {
                      final bookId = int.tryParse(
                        state.pathParameters['bookId'] ?? '',
                      );
                      if (bookId == null) {
                        return const _InvalidDeepLinkScreen();
                      }
                      return BookDetailScreen(bookId: bookId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ai',
                builder: (context, state) => const ChatScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const StudentProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class _AuthLoadingScreen extends StatelessWidget {
  const _AuthLoadingScreen();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Semantics(
          label: loc.authLoading,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _InvalidDeepLinkScreen extends StatelessWidget {
  const _InvalidDeepLinkScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppEmptyState(
        icon: Icons.link_off_outlined,
        title: 'Liên kết không hợp lệ',
        message: 'Màn hình này cần một mã lịch thi hợp lệ.',
      ),
    );
  }
}
