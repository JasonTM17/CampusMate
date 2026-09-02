import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/features/auth/application/auth_controller.dart';
import 'package:campusmate/features/auth/domain/auth_failure.dart';
import 'package:campusmate/features/auth/domain/auth_repository.dart';
import 'package:campusmate/features/auth/domain/auth_user.dart';

/// Configurable in-memory [AuthRepository] for controller/screen tests.
/// Records received calls so tests can assert the flow reached the repo.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.restoreResult, this.signInError});

  AuthUser? restoreResult;
  AuthFailure? signInError;
  int signInCalls = 0;
  int signOutCalls = 0;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    signInCalls++;
    final error = signInError;
    if (error != null) throw error;
    return AuthUser(authUserId: 'user-1', email: email);
  }

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
  Future<AuthUser?> restore() async => restoreResult;

  @override
  Future<void> signOut() async {
    signOutCalls++;
  }
}

const _demoUser = AuthUser(
  authUserId: 'user-1',
  email: 'student001@campusmate.local',
);

ProviderContainer _containerWith(AuthRepository repo) => ProviderContainer(
  overrides: [authRepositoryProvider.overrideWithValue(repo)],
);

/// The controller kicks off an async restore inside [Notifier.build] via a
/// nested future; poll until that restore settles out of the `unknown`
/// status (more reliable than a fixed microtask drain).
Future<void> _untilSettled(ProviderContainer container) async {
  for (var i = 0; i < 50; i++) {
    if (container.read(authControllerProvider).status != AuthStatus.unknown) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'restore transitions unknown → authenticated when a session exists',
    () async {
      final container = _containerWith(
        FakeAuthRepository(restoreResult: _demoUser),
      );
      addTearDown(container.dispose);

      expect(container.read(authControllerProvider).status, AuthStatus.unknown);
      await _untilSettled(container);
      final state = container.read(authControllerProvider);
      expect(state.status, AuthStatus.authenticated);
      expect(state.user?.email, 'student001@campusmate.local');
    },
  );

  test(
    'restore transitions unknown → unauthenticated without a session',
    () async {
      final container = _containerWith(FakeAuthRepository());
      addTearDown(container.dispose);

      await _untilSettled(container);
      expect(
        container.read(authControllerProvider).status,
        AuthStatus.unauthenticated,
      );
    },
  );

  test(
    'signIn success transitions to authenticated with the returned user',
    () async {
      final repo = FakeAuthRepository();
      final container = _containerWith(repo);
      addTearDown(container.dispose);

      await _untilSettled(container);
      await container
          .read(authControllerProvider.notifier)
          .signIn(
            email: 'student001@campusmate.local',
            password: 'CampusMate#2026',
          );

      expect(repo.signInCalls, 1);
      final state = container.read(authControllerProvider);
      expect(state.isAuthenticated, isTrue);
      expect(state.user?.authUserId, 'user-1');
    },
  );

  test(
    'signIn failure keeps state unauthenticated and rethrows the typed failure',
    () async {
      final repo = FakeAuthRepository(
        signInError: const InvalidCredentialsFailure(),
      );
      final container = _containerWith(repo);
      addTearDown(container.dispose);
      await _untilSettled(container);

      await expectLater(
        container
            .read(authControllerProvider.notifier)
            .signIn(
              email: 'student001@campusmate.local',
              password: 'wrong-password',
            ),
        throwsA(isA<InvalidCredentialsFailure>()),
      );
      expect(
        container.read(authControllerProvider).status,
        AuthStatus.unauthenticated,
      );
    },
  );

  test(
    'signOut clears the session state and notifies the repository',
    () async {
      final repo = FakeAuthRepository(restoreResult: _demoUser);
      final container = _containerWith(repo);
      addTearDown(container.dispose);
      await _untilSettled(container);

      await container.read(authControllerProvider.notifier).signOut();

      expect(repo.signOutCalls, 1);
      expect(
        container.read(authControllerProvider).status,
        AuthStatus.unauthenticated,
      );
    },
  );
}
