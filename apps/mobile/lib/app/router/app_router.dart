import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
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
                builder: (context, state) => BranchPlaceholderScreen(
                  icon: Icons.smart_toy_outlined,
                  title: AppLocalizations.of(context)!.navAi,
                ),
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
