import 'dart:io';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart';

/// Phase-02/08 auth evidence: a REAL registration (code read from the dev
/// server log, because no mail service exists in dev), a REAL login, and a
/// REAL JWT refresh against the running server.
///
/// Requires `docker compose up -d` and the server booted with
/// `dart run bin/main.dart --apply-migrations`. Opt in with
/// `CAMPUSMATE_LIVE_SPIKE=1`. The server URL comes from
/// `--dart-define=CAMPUSMATE_SERVER_URL=…`, and the server console log file
/// path from `CAMPUSMATE_SERVER_LOG` (used to read the verification code —
/// in production the code is emailed instead of logged).
void main() {
  final liveSpikeEnabled = Platform.environment['CAMPUSMATE_LIVE_SPIKE'] == '1';

  test(
    'registers (when needed), signs in, and refreshes the session for the demo student',
    () async {
      final serverUrl = const String.fromEnvironment(
        'CAMPUSMATE_SERVER_URL',
        defaultValue: 'http://localhost:8080/',
      );
      const email = 'student001@campusmate.local';
      final password = Platform.environment['CAMPUSMATE_SEED_PASSWORD'];
      if (password == null || password.length < 12) {
        fail(
          'CAMPUSMATE_SEED_PASSWORD must be set to the same local-only '
          'password used by server/bin/seed.dart.',
        );
      }

      final client = Client(serverUrl);

      AuthSuccess success;
      try {
        success = await client.emailIdp.login(email: email, password: password);
      } on EmailAccountLoginException catch (e) {
        expect(
          e.reason,
          EmailAccountLoginExceptionReason.invalidCredentials,
          reason:
              'a fresh dev database only fails login because the demo '
              'account does not exist yet; other reasons must fail the test',
        );
        success = await _registerThroughRealFlow(client, email, password);
      }

      expect(success.authUserId.uuid, isNotEmpty);
      expect(success.token, isNotEmpty);

      // Refresh round-trip proves the JWT token manager accepts the stored
      // refresh token and issues a fresh pair.
      final refreshed = await client.jwtRefresh.refreshAccessToken(
        refreshToken: success.refreshToken!,
      );
      expect(refreshed.token, isNotEmpty);
      expect(refreshed.authUserId.uuid, success.authUserId.uuid);

      client.close();
    },
    skip: liveSpikeEnabled
        ? false
        : 'needs a live dev server; run with CAMPUSMATE_LIVE_SPIKE=1',
  );
}

/// Drives the real three-step registration flow, reading the verification
/// code from the server console log (dev behavior of `_sendRegistrationCode`).
Future<AuthSuccess> _registerThroughRealFlow(
  Client client,
  String email,
  String password,
) async {
  final logPath = Platform.environment['CAMPUSMATE_SERVER_LOG'];
  if (logPath == null) {
    fail(
      'CAMPUSMATE_SERVER_LOG must point to the dev server console log '
      'so the registration verification code can be read.',
    );
  }

  final accountRequestId = await client.emailIdp.startRegistration(
    email: email,
  );

  final code = await _readVerificationCodeFromLog(logPath, email);
  final registrationToken = await client.emailIdp.verifyRegistrationCode(
    accountRequestId: accountRequestId,
    verificationCode: code,
  );

  return client.emailIdp.finishRegistration(
    registrationToken: registrationToken,
    password: password,
  );
}

/// Polls the server log for the registration code sent to [email].
Future<String> _readVerificationCodeFromLog(
  String logPath,
  String email,
) async {
  final pattern = RegExp(
    'Registration code \\(${RegExp.escape(email)}\\):\\s*(\\S+)',
  );
  final logFile = File(logPath);
  final deadline = DateTime.now().add(const Duration(seconds: 15));
  while (DateTime.now().isBefore(deadline)) {
    if (logFile.existsSync()) {
      final matches = pattern.allMatches(logFile.readAsStringSync()).toList();
      if (matches.isNotEmpty) return matches.last.group(1)!;
    }
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
  fail('No registration code for $email found in $logPath within 15 s.');
}
