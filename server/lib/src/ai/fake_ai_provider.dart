import 'dart:math' as math;

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

  static final List<AiRequest> capturedRequests = [];

  static void clearCapturedRequests() => capturedRequests.clear();

  @override
  Stream<AiStreamChunk> streamChat(AiRequest request) async* {
    capturedRequests.add(request);
    final prompt = request.messages.isEmpty
        ? ''
        : request.messages.last.content;
    final reply = _replyFor(prompt, context: request.studentContext);
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
    const dim = 1536;
    final counts = List<double>.filled(dim, 0);
    final lower = text.toLowerCase();
    for (var i = 0; i < lower.length; i++) {
      counts[i % dim] += lower.codeUnitAt(i);
    }
    final norm = counts.fold<double>(0, (s, v) => s + v * v);
    final magnitude = norm == 0 ? 1.0 : math.sqrt(norm);
    return counts.map((v) => v / magnitude).toList(growable: false);
  }

  /// Builds a reply echoing the prompt, or returning RAG knowledge answers
  /// with verifiable citations when reference context is provided.
  String _replyFor(String prompt, {String? context}) {
    final suggestionLine = 'Gợi ý bắt đầu: ${_suggestions.join(' · ')}.';
    if (prompt.trim().isEmpty) {
      return 'Xin chào! Tôi là trợ lý CampusMate. $suggestionLine';
    }

    final hasRagContext = context != null && context.contains('[Nguồn 1');

    if (prompt.contains('bịa citation') || prompt.contains('hallucinate citation')) {
      return 'Đây là câu trả lời có chứa trích dẫn bịa đặt [Sách Bịa Đặt - Chương 99, tr. 999] để kiểm tra hệ thống xác thực.';
    }

    final lower = prompt.toLowerCase();
    if (lower.contains('restricted') ||
        lower.contains('tai lieu mat') ||
        lower.contains('tài liệu mật') ||
        lower.contains('mật khẩu') ||
        lower.contains('giáo trình chưa đăng ký')) {
      return 'Xin lỗi, tôi không tìm thấy tài liệu phù hợp với câu hỏi của bạn trong các nguồn được cấp phép.';
    }

    if (hasRagContext) {
      return 'Theo tài liệu tham khảo được cấp phép: nội dung giải đáp cho câu hỏi "$prompt" được trình bày đầy đủ [Nguồn 1].';
    }

    return 'Bạn hỏi: "$prompt". Đây là phản hồi mẫu (FakeAiProvider). '
        '$suggestionLine';
  }
}
