import 'dart:io';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase-08 streaming spike evidence: the Serverpod-generated client opens
/// its WebSocket, calls a streaming endpoint, and receives the reply
/// token-by-token (phase-08 step 1 — must pass before the chat architecture
/// is committed; outcome feeds ADR-008).
///
/// Requires `docker compose up -d` in `server/` and the server booted with
/// `dart run bin/main.dart --apply-migrations`. Opt in locally with
/// `CAMPUSMATE_LIVE_SPIKE=1` so CI never depends on a live backend. The
/// server URL must be provided via `--dart-define=CAMPUSMATE_SERVER_URL=…`
/// because the local API port can differ from the default 8080.
void main() {
  final liveSpikeEnabled = Platform.environment['CAMPUSMATE_LIVE_SPIKE'] == '1';

  test(
    'generated client receives token-by-token stream from the spike endpoint',
    () async {
      final serverUrl = const String.fromEnvironment(
        'CAMPUSMATE_SERVER_URL',
        defaultValue: 'http://localhost:8080/',
      );
      final client = Client(serverUrl);

      final chunks = <String>[];
      await for (final chunk in client.aiSpike.mockStream(
        'giải thích phase 8',
      )) {
        chunks.add(chunk);
      }

      expect(chunks, isNotEmpty, reason: 'stream must yield multiple tokens');
      final fullReply = chunks.join();
      expect(fullReply, contains('CampusMate AI (spike)'));
      expect(fullReply, contains('giải thích phase 8'));
      client.close();
    },
    skip: liveSpikeEnabled
        ? false
        : 'needs a live dev server; run with CAMPUSMATE_LIVE_SPIKE=1',
  );
}
