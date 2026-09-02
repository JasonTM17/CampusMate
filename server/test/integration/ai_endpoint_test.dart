import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Phase-08 AI endpoint integration tests against a real (test) database.
///
/// Covers: auth-gated access, conversation lifecycle, streaming chat with
/// persistence, history replay, and tenant isolation (user A cannot read or
/// write user B's conversation — §31).
void main() {
  withServerpod(
    'Given AiEndpoint',
    (sessionBuilder, endpoints) {
      // Two distinct users for the isolation tests.
      final userA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          'user-a',
          const {},
        ),
      );
      final userB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          'user-b',
          const {},
        ),
      );

      test('rejects unauthenticated access to listConversations', () async {
        await expectLater(
          endpoints.ai.listConversations(sessionBuilder),
          throwsA(isA<ServerpodClientUnauthorized>()),
        );
      });

      test('creates a conversation owned by the caller', () async {
        final conv = await endpoints.ai.createConversation(
          userA,
          title: 'Học tập tuần 1',
        );
        expect(conv.title, 'Học tập tuần 1');
        expect(conv.userId, 'user-a');

        final list = await endpoints.ai.listConversations(userA);
        expect(list, hasLength(1));
        expect(list.first.id, conv.id);
      });

      test('streams a reply and persists both turns', () async {
        final conv = await endpoints.ai.createConversation(
          userA,
          title: 'Quiz',
        );

        final chunks = <String>[];
        await for (final chunk in endpoints.ai.sendMessage(
          userA,
          conversationId: conv.id!,
          userMessage: 'Tạo quiz lịch sử',
        )) {
          chunks.add(chunk);
        }

        // Streaming yields multiple chunks ending the reply.
        expect(chunks, isNotEmpty);
        final reply = chunks.join();
        expect(reply, contains('FakeAiProvider'));

        // Both turns persisted, oldest first.
        final messages = await endpoints.ai.getMessages(
          userA,
          conversationId: conv.id!,
        );
        expect(messages, hasLength(2));
        expect(messages[0].role, 'user');
        expect(messages[0].content, 'Tạo quiz lịch sử');
        expect(messages[1].role, 'assistant');
        expect(messages[1].content, reply);
      });

      test('returns 404 for a conversation the caller does not own', () async {
        final conv = await endpoints.ai.createConversation(
          userA,
          title: 'Private',
        );

        await expectLater(
          endpoints.ai.getMessages(userB, conversationId: conv.id!),
          throwsA(isA<ServerpodClientNotFound>()),
        );

        await expectLater(
          endpoints.ai.sendMessage(
            userB,
            conversationId: conv.id!,
            userMessage: 'đọc trộm',
          ),
          throwsA(isA<ServerpodClientNotFound>()),
        );
      });

      test('user B cannot see user A conversations in the list', () async {
        await endpoints.ai.createConversation(userA, title: 'A1');
        await endpoints.ai.createConversation(userA, title: 'A2');

        final bList = await endpoints.ai.listConversations(userB);
        expect(bList, isEmpty);
      });

      test('deleting a conversation removes it and is scoped to owner',
          () async {
        final conv = await endpoints.ai.createConversation(
          userA,
          title: 'Temp',
        );

        // Owner can delete.
        await endpoints.ai.deleteConversation(userA, conversationId: conv.id!);
        final aList = await endpoints.ai.listConversations(userA);
        expect(aList, isEmpty);

        // Others cannot delete it (already gone -> 404 either way).
        final other = await endpoints.ai.createConversation(userB, title: 'B1');
        await expectLater(
          endpoints.ai.deleteConversation(userA, conversationId: other.id!),
          throwsA(isA<ServerpodClientNotFound>()),
        );
      });
    },
  );
}
