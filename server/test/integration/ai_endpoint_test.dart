import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import '../fixtures/prompt_injection_fixtures.dart';
import 'test_tools/serverpod_test_tools.dart';

/// Collects a streaming reply into its full text.
Future<String> _drain(Stream<String> stream) async {
  final buffer = StringBuffer();
  await for (final chunk in stream) {
    buffer.write(chunk);
  }
  return buffer.toString();
}

Future<void> _expectStreamThrows(
  Stream<String> stream,
  Object matcher,
) async {
  await expectLater(stream.drain<void>(), throwsA(matcher));
}

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

        await _expectStreamThrows(
          endpoints.ai.sendMessage(
            userB,
            conversationId: conv.id!,
            userMessage: 'đọc trộm',
          ),
          isA<ServerpodClientNotFound>(),
        );
      });

      test('counts usage and passes while below the daily limit', () async {
        final session = sessionBuilder.build();
        final conv = await endpoints.ai.createConversation(
          userA,
          title: 'Counter',
        );

        final reply = await _drain(
          endpoints.ai.sendMessage(
            userA,
            conversationId: conv.id!,
            userMessage: 'lần 1',
          ),
        );
        expect(reply, isNotEmpty);

        final usage = await AiUsage.db.find(session);
        expect(usage, hasLength(1));
        expect(usage.single.userId, 'user-a');
        expect(usage.single.requestCount, 1);
      });

      test(
        'blocks the 51st message of the day with a friendly error',
        () async {
          final session = sessionBuilder.build();
          final conv = await endpoints.ai.createConversation(
            userA,
            title: 'Quota',
          );

          // Simulate a user who has already used the whole daily quota.
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          await AiUsage.db.insertRow(
            session,
            AiUsage(
              userId: 'user-a',
              day: today,
              requestCount: 50,
              inputTokens: 0,
              outputTokens: 0,
              estimatedCost: 0,
            ),
          );

          await _expectStreamThrows(
            endpoints.ai.sendMessage(
              userA,
              conversationId: conv.id!,
              userMessage: 'xin chào',
            ),
            isA<ServerpodClientException>()
                .having((e) => e.statusCode, 'statusCode', 429)
                .having((e) => e.message, 'message', contains('hạn mức')),
          );

          // The blocked turn must not be persisted.
          final messages = await endpoints.ai.getMessages(
            userA,
            conversationId: conv.id!,
          );
          expect(messages, isEmpty);
        },
      );

      test('injection payloads cannot change authorization behavior', () async {
        final conv = await endpoints.ai.createConversation(
          userA,
          title: 'Vault',
        );

        // A foreign user with an injection payload still gets 404 — message
        // content never overrides the server-side ownership predicate.
        for (final payload in promptInjectionFixtures) {
          await _expectStreamThrows(
            endpoints.ai.sendMessage(
              userB,
              conversationId: conv.id!,
              userMessage: payload,
            ),
            isA<ServerpodClientNotFound>(),
          );
        }

        // The owner sending the same payloads is treated as plain data: the
        // reply streams and the stored user turn matches byte-for-byte.
        final reply = await _drain(
          endpoints.ai.sendMessage(
            userA,
            conversationId: conv.id!,
            userMessage: promptInjectionFixtures.first,
          ),
        );
        expect(reply, isNotEmpty);

        final messages = await endpoints.ai.getMessages(
          userA,
          conversationId: conv.id!,
        );
        expect(messages.first.role, 'user');
        expect(messages.first.content, promptInjectionFixtures.first);
      });

      test('user B cannot see user A conversations in the list', () async {
        await endpoints.ai.createConversation(userA, title: 'A1');
        await endpoints.ai.createConversation(userA, title: 'A2');

        final bList = await endpoints.ai.listConversations(userB);
        expect(bList, isEmpty);
      });

      test(
        'deleting a conversation removes it and is scoped to owner',
        () async {
          final conv = await endpoints.ai.createConversation(
            userA,
            title: 'Temp',
          );

          // Owner can delete.
          await endpoints.ai.deleteConversation(
            userA,
            conversationId: conv.id!,
          );
          final aList = await endpoints.ai.listConversations(userA);
          expect(aList, isEmpty);

          // Others cannot delete it (already gone -> 404 either way).
          final other = await endpoints.ai.createConversation(
            userB,
            title: 'B1',
          );
          await expectLater(
            endpoints.ai.deleteConversation(userA, conversationId: other.id!),
            throwsA(isA<ServerpodClientNotFound>()),
          );
        },
      );
    },
  );
}
