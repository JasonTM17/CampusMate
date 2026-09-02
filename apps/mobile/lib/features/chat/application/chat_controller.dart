import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chat_message.dart';
import '../domain/chat_repository.dart';
import '../domain/chat_state.dart';

/// Provides the app-wide [AiRepository] implementation. Tests override this
/// with an in-memory fake; production wires it in main().
final aiRepositoryProvider = Provider<AiRepository>((ref) {
  throw UnimplementedError(
    'aiRepositoryProvider must be overridden in main() / tests',
  );
});

/// Drives a single conversation: loads history, sends messages, and turns the
/// server's token stream into progressively-rendered assistant bubbles.
class ChatController extends Notifier<ChatState> {
  @override
  ChatState build() => const ChatState();

  AiRepository get _repo => ref.read(aiRepositoryProvider);

  /// Opens [conversationId], loading its history into state.
  Future<void> openConversation(int conversationId) async {
    state = state.copyWith(
      status: ChatStatus.loadingHistory,
      conversationId: conversationId,
    );
    try {
      final rows = await _repo.getMessages(conversationId);
      state = state.copyWith(status: ChatStatus.idle, messages: rows);
    } on Object {
      state = state.copyWith(
        status: ChatStatus.error,
        error: 'Không thể tải lịch sử.',
      );
    }
  }

  /// Sends [text], streams the reply into a growing assistant bubble, and
  /// persists both turns once the stream completes.
  Future<void> sendMessage(String text) async {
    final conversationId = state.conversationId;
    if (conversationId == null || text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      role: MessageRole.user,
      content: text.trim(),
      status: MessageStatus.sending,
    );
    final assistantMsg = ChatMessage(
      id: 'assistant-streaming',
      role: MessageRole.assistant,
      content: '',
      status: MessageStatus.streaming,
    );
    state = state.copyWith(
      status: ChatStatus.streaming,
      messages: [...state.messages, userMsg, assistantMsg],
    );

    try {
      final stream = _repo.sendMessage(
        conversationId: conversationId,
        content: userMsg.content,
      );
      await for (final chunk in stream) {
        final updated = state.messages.toList();
        final last = updated.last;
        updated[updated.length - 1] = last.copyWith(
          content: last.content + chunk,
        );
        state = state.copyWith(messages: updated);
      }
      // Mark both turns as persisted/sent.
      final finalized = state.messages.toList();
      finalized[finalized.length - 2] = finalized[finalized.length - 2]
          .copyWith(status: MessageStatus.sent);
      finalized[finalized.length - 1] = finalized[finalized.length - 1]
          .copyWith(status: MessageStatus.sent);
      state = state.copyWith(status: ChatStatus.idle, messages: finalized);
    } on Object {
      final updated = state.messages.toList();
      updated[updated.length - 1] = updated.last.copyWith(
        content: 'Không gửi được. Thử lại.',
        status: MessageStatus.error,
      );
      state = state.copyWith(status: ChatStatus.error, messages: updated);
    }
  }
}

/// Per-conversation chat state.
final chatControllerProvider = NotifierProvider<ChatController, ChatState>(
  ChatController.new,
);
