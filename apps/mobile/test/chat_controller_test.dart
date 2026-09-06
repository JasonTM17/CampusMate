import 'package:campusmate/features/chat/application/chat_controller.dart';
import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/domain/chat_repository.dart';
import 'package:campusmate/features/chat/domain/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// In-memory [AiRepository] that records calls and scripts replies.
class FakeAiRepository implements AiRepository {
  FakeAiRepository({this.reply = 'Xin chào từ fake.', this.history = const []});

  String reply;
  List<ChatMessage> history;
  int sendCalls = 0;
  int openCalls = 0;
  int createCalls = 0;
  String? lastMessage;

  @override
  Future<List<ConversationSummary>> listConversations() async => [];

  @override
  Future<ConversationSummary> createConversation({
    required String title,
  }) async {
    createCalls++;
    return ConversationSummary(id: 1, title: title, updatedAt: DateTime.now());
  }

  @override
  Future<void> deleteConversation(int conversationId) async {}

  @override
  Future<List<ChatMessage>> getMessages(int conversationId) async {
    openCalls++;
    return history;
  }

  @override
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
  }) async* {
    sendCalls++;
    lastMessage = content;
    for (final token in reply.split(' ')) {
      yield '$token ';
    }
  }
}

ProviderContainer _containerWith(AiRepository repo) => ProviderContainer(
  overrides: [aiRepositoryProvider.overrideWithValue(repo)],
);

Future<void> _untilIdle(ProviderContainer container) async {
  for (var i = 0; i < 50; i++) {
    if (container.read(chatControllerProvider).status != ChatStatus.streaming) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('ChatState.copyWith can clear nullable fields', () {
    const state = ChatState(
      status: ChatStatus.error,
      conversationId: 7,
      error: 'stale',
    );

    final next = state.copyWith(
      status: ChatStatus.idle,
      conversationId: null,
      error: null,
    );

    expect(next.status, ChatStatus.idle);
    expect(next.conversationId, isNull);
    expect(next.error, isNull);
  });

  test('openConversation loads history and transitions idle', () async {
    final history = [
      const ChatMessage(
        id: '1',
        role: MessageRole.user,
        content: 'Chào',
        status: MessageStatus.sent,
      ),
    ];
    final repo = FakeAiRepository(history: history);
    final container = _containerWith(repo);
    addTearDown(container.dispose);

    await container.read(chatControllerProvider.notifier).openConversation(42);
    await _untilIdle(container);

    final state = container.read(chatControllerProvider);
    expect(repo.openCalls, 1);
    expect(state.status, ChatStatus.idle);
    expect(state.messages, hasLength(1));
    expect(state.messages.first.content, 'Chào');
  });

  test(
    'openOrCreateConversation creates a new conversation then loads it',
    () async {
      final repo = FakeAiRepository();
      final container = _containerWith(repo);
      addTearDown(container.dispose);

      await container
          .read(chatControllerProvider.notifier)
          .openOrCreateConversation(newConversationTitle: 'Hội thoại mới');

      final state = container.read(chatControllerProvider);
      expect(repo.createCalls, 1);
      expect(repo.openCalls, 1);
      expect(state.status, ChatStatus.idle);
      expect(state.conversationId, 1);
      expect(state.error, isNull);
    },
  );

  test(
    'openOrCreateConversation surfaces conversation creation failures',
    () async {
      final repo = _CreateThrowingRepo();
      final container = _containerWith(repo);
      addTearDown(container.dispose);

      await container.read(chatControllerProvider.notifier).openConversation(7);
      expect(container.read(chatControllerProvider).conversationId, 7);

      await container
          .read(chatControllerProvider.notifier)
          .openOrCreateConversation(newConversationTitle: 'Hội thoại mới');

      final state = container.read(chatControllerProvider);
      expect(state.status, ChatStatus.error);
      expect(state.conversationId, isNull);
      expect(state.messages, isEmpty);
      expect(state.error, 'Không thể tải lịch sử.');

      await container
          .read(chatControllerProvider.notifier)
          .sendMessage('stale?');
      expect(repo.sendCalls, 0);
    },
  );

  test('sendMessage streams reply into assistant bubble', () async {
    final repo = FakeAiRepository(reply: 'Một hai ba');
    final container = _containerWith(repo);
    addTearDown(container.dispose);

    await container.read(chatControllerProvider.notifier).openConversation(7);
    await _untilIdle(container);
    await container.read(chatControllerProvider.notifier).sendMessage('Đếm đi');
    await _untilIdle(container);

    final state = container.read(chatControllerProvider);
    expect(repo.sendCalls, 1);
    expect(repo.lastMessage, 'Đếm đi');
    expect(state.messages, hasLength(2));
    expect(state.messages.first.role, MessageRole.user);
    expect(state.messages.first.status, MessageStatus.sent);
    expect(state.messages.last.role, MessageRole.assistant);
    expect(state.messages.last.content, 'Một hai ba ');
    expect(state.messages.last.status, MessageStatus.sent);
  });

  test(
    'sendMessage on repository error marks assistant turn as error',
    () async {
      // Override sendMessage to throw by using a throwing subclass.
      final container = _containerWith(_ThrowingRepo());
      addTearDown(container.dispose);

      await container.read(chatControllerProvider.notifier).openConversation(7);
      await _untilIdle(container);
      await container
          .read(chatControllerProvider.notifier)
          .sendMessage('gặp lỗi');
      await _untilIdle(container);

      final state = container.read(chatControllerProvider);
      expect(state.status, ChatStatus.error);
      expect(state.messages.first.status, MessageStatus.error);
      expect(state.messages.last.status, MessageStatus.error);
    },
  );

  test('ignores empty sends', () async {
    final repo = FakeAiRepository();
    final container = _containerWith(repo);
    addTearDown(container.dispose);

    await container.read(chatControllerProvider.notifier).sendMessage('   ');

    expect(repo.sendCalls, 0);
    expect(container.read(chatControllerProvider).messages, isEmpty);
  });
}

/// Fake whose sendMessage throws to exercise the error path.
class _ThrowingRepo extends FakeAiRepository {
  @override
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
  }) {
    throw constFormatException('boom');
  }
}

/// Fake whose createConversation throws to exercise the bootstrap error path.
class _CreateThrowingRepo extends FakeAiRepository {
  @override
  Future<ConversationSummary> createConversation({required String title}) {
    throw StateError('offline');
  }
}

// Small helper so we don't import dart:io in the test.
FormatException constFormatException(String m) => FormatException(m);
