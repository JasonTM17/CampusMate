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
import '../../features/chat/presentation/ai_settings_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/library/presentation/book_detail_screen.dart';
import '../../features/library/presentation/library_screen.dart';
import '../../features/library/presentation/my_loans_screen.dart';
import '../../features/notifications/presentation/notification_screen.dart';
import '../../features/reader/presentation/reader_screen.dart';
import '../../features/student_profile/presentation/student_profile_screen.dart';
import '../../features/admin/presentation/admin_dashboard_screen.dart';
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
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const NotificationScreen(),
        ),
      ),
      GoRoute(
        path: '/ai/settings',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const AiSettingsScreen(),
        ),
      ),
      GoRoute(
        path: '/admin',
        redirect: (context, state) {
          final role = authStateNotifier.value.user?.role;
          return role != null && canAccessPrivilegedArea(role) ? null : '/home';
        },
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const AdminDashboardScreen(),
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
                    pageBuilder: (context, state) {
                      final examId = int.tryParse(
                        state.pathParameters['examId'] ?? '',
                      );
                      if (examId == null) {
                        return _buildPageWithTransition(
                          context: context,
                          state: state,
                          child: const _InvalidDeepLinkScreen(
                            message:
                                'Mã lịch thi không hợp lệ hoặc đã kết thúc.',
                          ),
                        );
                      }
                      return _buildPageWithTransition(
                        context: context,
                        state: state,
                        child: ExamDetailScreen(examId: examId),
                      );
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
                    path: 'loans',
                    pageBuilder: (context, state) => _buildPageWithTransition(
                      context: context,
                      state: state,
                      child: const MyLoansScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'books/:bookId',
                    pageBuilder: (context, state) {
                      final bookId = int.tryParse(
                        state.pathParameters['bookId'] ?? '',
                      );
                      if (bookId == null) {
                        return _buildPageWithTransition(
                          context: context,
                          state: state,
                          child: const _InvalidDeepLinkScreen(
                            message:
                                'Mã sách không hợp lệ hoặc tài liệu không tồn tại.',
                          ),
                        );
                      }
                      return _buildPageWithTransition(
                        context: context,
                        state: state,
                        child: BookDetailScreen(bookId: bookId),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'read',
                        pageBuilder: (context, state) {
                          final bookId = int.tryParse(
                            state.pathParameters['bookId'] ?? '',
                          );
                          if (bookId == null) {
                            return _buildPageWithTransition(
                              context: context,
                              state: state,
                              child: const _InvalidDeepLinkScreen(
                                message:
                                    'Không thể mở trình đọc với mã sách này.',
                              ),
                            );
                          }
                          final format =
                              state.uri.queryParameters['format'] ?? 'pdf';
                          final title =
                              state.uri.queryParameters['title'] ??
                              'Tài liệu học tập';
                          return _buildPageWithTransition(
                            context: context,
                            state: state,
                            child: ReaderScreen(
                              bookId: bookId,
                              format: format,
                              title: title,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ai',
                builder: (context, state) {
                  final bookIdStr = state.uri.queryParameters['bookId'];
                  final bookId = bookIdStr != null
                      ? int.tryParse(bookIdStr)
                      : null;
                  final bookTitle = state.uri.queryParameters['title'];
                  final selectedText =
                      state.uri.queryParameters['selectedText'];
                  return ChatScreen(
                    bookId: bookId,
                    bookTitle: bookTitle,
                    selectedText: selectedText,
                  );
                },
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
  const _InvalidDeepLinkScreen({
    this.message = 'Liên kết không hợp lệ hoặc không tìm thấy nội dung.',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Không tìm thấy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Quay lại',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
      ),
      body: AppEmptyState(
        icon: Icons.link_off_outlined,
        title: 'Liên kết không hợp lệ',
        message: message,
        actionLabel: 'Về trang chủ',
        onAction: () => context.go('/home'),
      ),
    );
  }
}

Page<dynamic> _buildPageWithTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.04, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        ),
      );
    },
  );
}
