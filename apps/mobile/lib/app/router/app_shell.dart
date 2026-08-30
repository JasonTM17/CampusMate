import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_empty_state.dart';
import '../../l10n/generated/app_localizations.dart';

/// Bottom navigation shell (§42): Home / Academic / Library / AI / Profile.
/// Branch screens land in their own feature folders as phases progress.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: loc.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.school_outlined),
            selectedIcon: const Icon(Icons.school),
            label: loc.navAcademic,
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_library_outlined),
            selectedIcon: const Icon(Icons.local_library),
            label: loc.navLibrary,
          ),
          NavigationDestination(
            icon: const Icon(Icons.smart_toy_outlined),
            selectedIcon: const Icon(Icons.smart_toy),
            label: loc.navAi,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: loc.navProfile,
          ),
        ],
      ),
    );
  }
}

/// Shared placeholder for branch screens whose phase has not delivered the
/// real content yet. Renders an honest empty state — never fake buttons.
class BranchPlaceholderScreen extends StatelessWidget {
  const BranchPlaceholderScreen({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AppEmptyState(
        icon: icon,
        title: loc.comingSoonTitle,
        message: loc.comingSoonMessage,
      ),
    );
  }
}
