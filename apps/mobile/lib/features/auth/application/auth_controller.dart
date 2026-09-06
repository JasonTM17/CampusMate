import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../data/serverpod_auth_repository.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

/// Provides the app-wide [AuthRepository] implementation. Widget/unit tests
/// override this provider with a fake to exercise UI without a server.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => ServerpodAuthRepository(
    client: ref.watch(serverpodClientProvider),
    storage: ref.watch(authTokenStorageProvider),
  ),
);

/// Lifecycle of the signed-in state.
enum AuthStatus {
  /// Storage restore still in progress — the router must not redirect yet.
  unknown,

  /// A session was restored or a sign-in/registration completed.
  authenticated,

  /// No session (or it was cleared by sign-out / failed refresh).
  unauthenticated,
}

/// Immutable auth state consumed by the router and screens.
class AuthState {
  const AuthState({required this.status, this.user});

  final AuthStatus status;
  final AuthUser? user;

  /// Convenience check for router redirects.
  bool get isAuthenticated => status == AuthStatus.authenticated;
}

/// Owns the signed-in lifecycle: restore-on-start, sign-in, registration
/// completion, and sign-out.
///
/// Flow methods rethrow the typed [AuthFailure] from the repository so the
/// calling screen can render a localized message while the state itself only
/// transitions on success.
class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Fire the async restore; the state starts `unknown` so the router does
    // not bounce the user to /login before storage has been read.
    Future<void>(() async {
      final user = await ref.read(authRepositoryProvider).restore();
      state = user == null
          ? const AuthState(status: AuthStatus.unauthenticated)
          : AuthState(status: AuthStatus.authenticated, user: user);
    });
    return const AuthState(status: AuthStatus.unknown);
  }

  /// Signs in with [email]/[password]; throws [AuthFailure] on error.
  Future<void> signIn({required String email, required String password}) async {
    final user = await ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password);
    state = AuthState(status: AuthStatus.authenticated, user: user);
  }

  /// Completes registration with the verified [registrationToken].
  Future<void> completeRegistration({
    required String email,
    required String registrationToken,
    required String password,
  }) async {
    final user = await ref
        .read(authRepositoryProvider)
        .completeRegistration(
          email: email,
          registrationToken: registrationToken,
          password: password,
        );
    state = AuthState(status: AuthStatus.authenticated, user: user);
  }

  /// Clears the local session.
  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

/// Global auth state provider.
final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
