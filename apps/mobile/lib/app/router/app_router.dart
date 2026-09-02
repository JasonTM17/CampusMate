import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/registration_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../l10n/generated/app_localizations.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      // Auth screens live outside the navigation shell (no bottom bar).
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegistrationScreen(),
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
                builder: (context, state) => BranchPlaceholderScreen(
                  icon: Icons.school_outlined,
                  title: AppLocalizations.of(context)!.navAcademic,
                ),
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
                builder: (context, state) => BranchPlaceholderScreen(
                  icon: Icons.person_outline,
                  title: AppLocalizations.of(context)!.navProfile,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
