import 'package:serverpod/serverpod.dart';

/// Temporary streaming spike endpoint (phase-08 step 1).
///
/// Proves the Serverpod WebSocket streaming pattern end-to-end — mock token
/// generator on the server, `Stream<String>` on the Flutter client — before
/// the real chat architecture is committed (ADR-008). This endpoint is
/// replaced by the real `AiEndpoint` once the pattern is validated and is
/// removed before phase-08 exits.
class AiSpikeEndpoint extends Endpoint {
  /// Streams a mock Vietnamese assistant reply back token-by-token, echoing
  /// the caller's [prompt] so the client can verify round-trip streaming.
  Stream<String> mockStream(Session session, String prompt) async* {
    final reply =
        'CampusMate AI (spike): bạn vừa hỏi "$prompt". '
        'Mỗi từ trong câu trả lời này được stream riêng qua WebSocket '
        'để chứng minh pattern streaming hoạt động.';
    for (final token in reply.split(' ')) {
      await Future<void>.delayed(const Duration(milliseconds: 80));
      yield '$token ';
    }
  }
}
