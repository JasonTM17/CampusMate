import 'package:campusmate_shared/campusmate_shared.dart';

import 'ai_provider.dart';

/// Deterministic, key-free [AiProvider] for development and tests.
///
/// [streamChunk] is emitted one chunk at a time with a small delay so the
/// client observes genuine streaming (the dev AI is still "thinking"). Tokens
/// and embeddings are derived deterministically from the prompt so phase-10
/// retrieval and streaming tests are reproducible without a live model
/// (plan.md §23: deterministic stream + deterministic embedding hash).
class FakeAiProvider implements AiProvider {
  FakeAiProvider({this.chunkDelay = const Duration(milliseconds: 60)});

  /// Simulated per-chunk latency so streaming is observable.
  final Duration chunkDelay;

  static const _suggestions = [
    '📚 Giải thích bài học',
    '🧠 Tạo quiz',
    '📅 Lập kế hoạch học',
    '📖 Gợi ý sách',
  ];

  @override
  Stream<AiStreamChunk> streamChat(AiRequest request) async* {
    final prompt = request.messages.isEmpty
        ? ''
        : request.messages.last.content;
    final reply = _replyFor(prompt);
    final chunks = reply.split(' ');
    for (var i = 0; i < chunks.length; i++) {
      await Future<void>.delayed(chunkDelay);
      yield AiStreamChunk(
        text: '${chunks[i]} ',
        isDone: i == chunks.length - 1,
      );
    }
  }

  /// Deterministic pseudo-embedding: a normalized bag-of-codeunits vector.
  /// Same text always yields the same vector — enough for RAG tests.
  @override
  Future<List<double>> createEmbedding(String text) async {
    const dim = 16;
    final counts = List<double>.filled(dim, 0);
    final lower = text.toLowerCase();
    for (var i = 0; i < lower.length; i++) {
      counts[i % dim] += lower.codeUnitAt(i);
    }
    final norm = counts.fold<double>(0, (s, v) => s + v * v);
    final magnitude = norm == 0 ? 1.0 : norm;
    return counts.map((v) => v / magnitude).toList(growable: false);
  }

  /// Builds a canned, citation-free reply echoing the prompt plus a few
  /// starter suggestions for an empty conversation.
  String _replyFor(String prompt) {
    final suggestionLine = 'Gợi ý bắt đầu: ${_suggestions.join(' · ')}.';
    if (prompt.trim().isEmpty) {
      return 'Xin chào! Tôi là trợ lý CampusMate. $suggestionLine';
    }
    return 'Bạn hỏi: "$prompt". Đây là phản hồi mẫu (FakeAiProvider). '
        '$suggestionLine';
  }
}
