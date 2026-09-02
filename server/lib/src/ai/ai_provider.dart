import 'package:campusmate_shared/campusmate_shared.dart';

/// Abstraction over the chat AI backend (phase-08 "Architecture").
///
/// The server talks to AI exclusively through this interface: a [FakeAiProvider]
/// powers local/dev and tests with no key, while [OpenAiCompatibleProvider]
/// talks to any OpenAI/GLM-compatible gateway. Switching is config-only
/// (env `AI_PROVIDER`); mobile never knows which one runs and never holds a
/// key (plan.md security constraint).
abstract interface class AiProvider {
  /// Streams an assistant reply for [request], one [AiStreamChunk] per token
  /// (or small token group). The stream closes with `isDone = true` on the
  /// final chunk; the caller treats cancellation as a normal end.
  Stream<AiStreamChunk> streamChat(AiRequest request);

  /// Embeds [text] into a dense vector for RAG retrieval. Deterministic
  /// implementations (fake) use a stable hash so phase-10 retrieval tests
  /// do not depend on a live embedding model.
  Future<List<double>> createEmbedding(String text);
}
