# ADR-008: Stream AI chat over Serverpod WebSocket endpoints

- Status: Accepted (2026-09-01)
- Phase: 08-ai-core

## Context

Phase-08 requires token-by-token chat streaming from the Serverpod server to
the Flutter app. ADR-002 left the transport open: Serverpod WebSocket
streaming endpoints had to be spike-verified on Windows before the chat
architecture was committed, with SSE/poll-chunk as the designed fallback.

## Decision

Use **Serverpod streaming endpoints over WebSocket** as the only chat
transport. The server method returns `Stream<String>`; the generated client
exposes the same `Stream<String>` via `callStreamingServerEndpoint`. No SSE
or polling fallback is implemented.

## Spike evidence (2026-09-01, this machine)

- Endpoint `AiSpikeEndpoint.mockStream(Session, String) → Stream<String>`
  yielding spaced tokens with an 80 ms delay per token.
- `serverpod generate` produced a client method routed through
  `callStreamingServerEndpoint<Stream<String>, String>` (WebSocket-backed
  `MethodStreamManager`).
- Live run: `docker compose up -d` + `dart run bin/main.dart
  --apply-migrations`, then
  `CAMPUSMATE_LIVE_SPIKE=1 flutter test test/ai_stream_spike_test.dart
  --dart-define=CAMPUSMATE_SERVER_URL=http://localhost:8083/`
  → **All tests passed** in ~2 s wall time; the test asserts multiple chunks
  arrive as separate events (`chunks.length > 1`) and the joined reply echoes
  the prompt, so a single-payload response would fail the test.
- Environment note: on this machine the unrelated `infrastructure` compose
  stack holds ports 8080/9000, so the dev API server was temporarily run on
  8083 (config shift never committed; default remains 8080).

## Alternatives considered

- **SSE / poll-chunk fallback**: would add a second transport, auth path, and
  client state machine for no observed benefit — WebSocket worked on the
  first spike.
- **Raw `web_socket_channel` protocol**: loses Serverpod auth injection
  (`authKeyProvider`), codegen typing, and reconnect handling.

## Consequences

- Chat endpoints declare `Stream<String>` (or `Stream<AiStreamChunk>`)
  returns; cancel on the client closes the socket subscription (stop button
  = cancel subscription, server `addStream` abort propagates).
- Authentication for streams rides on the same session key as unary calls;
  `authenticated: true` (default) is kept for chat.
- `web_socket_channel` stays a transitive dependency of `serverpod_flutter`;
  the app does not depend on it directly.
