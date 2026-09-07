import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/domain/auth_user.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/password_reset_screen.dart';
import '../../features/auth/presentation/registration_screen.dart';
import '../../features/academics/presentation/academic_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/student_profile/presentation/student_profile_screen.dart';
import '../../l10n/generated/app_localizations.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthRoute =
          path == '/login' || path == '/register' || path == '/reset-password';
      final isLoadingRoute = path == '/auth-loading';

      if (authState.status == AuthStatus.unknown) {
        return isAuthRoute || isLoadingRoute ? null : '/auth-loading';
      }
      if (!authState.isAuthenticated) {
        return isAuthRoute ? null : '/login';
      }
      if (isAuthRoute || isLoadingRoute) return '/home';
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
        path: '/auth-loading',
        builder: (context, state) => const _AuthLoadingScreen(),
      ),
      GoRoute(
        path: '/admin',
        redirect: (context, state) {
          final role = authState.user?.role;
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
                builder: (context, state) => BranchPlaceholderScreen(
                  icon: Icons.home_outlined,
                  title: AppLocalizations.of(context)!.navHome,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/academic',
                builder: (context, state) => const AcademicScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => BranchPlaceholderScreen(
                  icon: Icons.local_library_outlined,
                  title: AppLocalizations.of(context)!.navLibrary,
                ),
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
