import 'package:campusmate_server/src/ai/fake_ai_provider.dart';
import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _userAId = '00000000-0000-4000-8000-0000000000a1';
const _userBId = '00000000-0000-4000-8000-0000000000b2';

void main() {
  withServerpod(
    'Given AI Personalization & Context Isolation (Phase-09)',
    (sessionBuilder, endpoints) {
      final userA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _userAId,
          {campusMateStudentScope},
        ),
      );
      final userB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _userBId,
          {campusMateStudentScope},
        ),
      );

      setUp(() {
        FakeAiProvider.clearCapturedRequests();
      });

      group('AI Preferences', () {
        test('creates default preferences for a new student', () async {
          final pref = await endpoints.ai.getPreferences(userA);
          expect(pref.userId.toString(), _userAId);
          expect(pref.explanationStyle, 'standard');
          expect(pref.personalizationEnabled, isTrue);
          expect(pref.memoryEnabled, isTrue);
        });

        test('updates preferences and keeps user isolation', () async {
          await endpoints.ai.updatePreferences(
            userA,
            explanationStyle: 'concise',
            personalizationEnabled: true,
            memoryEnabled: false,
          );

          final prefA = await endpoints.ai.getPreferences(userA);
          expect(prefA.explanationStyle, 'concise');
          expect(prefA.memoryEnabled, isFalse);

          // User B still has their own default preferences
          final prefB = await endpoints.ai.getPreferences(userB);
          expect(prefB.explanationStyle, 'standard');
          expect(prefB.memoryEnabled, isTrue);
        });
      });

      group('AI Memory and Blocklist', () {
        test('adds valid memory and retrieves it', () async {
          // Reset User A preferences so memory is enabled
          await endpoints.ai.updatePreferences(
            userA,
            explanationStyle: 'standard',
            personalizationEnabled: true,
            memoryEnabled: true,
          );

          final memory = await endpoints.ai.addMemory(
            userA,
            content: 'Thích học bằng sơ đồ tư duy và ví dụ thực tế',
          );
          expect(memory.content, 'Thích học bằng sơ đồ tư duy và ví dụ thực tế');
          expect(memory.disabledAt, isNull);

          final list = await endpoints.ai.getMemories(userA, activeOnly: false);
          expect(list.any((m) => m.id == memory.id), isTrue);

          // User B cannot see User A memory
          final listB = await endpoints.ai.getMemories(userB, activeOnly: false);
          expect(listB.any((m) => m.id == memory.id), isFalse);
        });

        test('blocks memories containing passwords or secrets', () async {
          await expectLater(
            endpoints.ai.addMemory(
              userA,
              content: 'Mật khẩu email của tôi là myPassword123!',
            ),
            throwsA(
              isA<ServerpodClientException>().having(
                (e) => e.statusCode,
                'statusCode',
                400,
              ),
            ),
          );

          await expectLater(
            endpoints.ai.addMemory(
              userA,
              content: 'API token bí mật: ghp_123456789012345678901234567890123456',
            ),
            throwsA(
              isA<ServerpodClientException>().having(
                (e) => e.statusCode,
                'statusCode',
                400,
              ),
            ),
          );

          await expectLater(
            endpoints.ai.addMemory(
              userA,
              content: 'Số tài khoản ngân hàng: stk: 0987654321',
            ),
            throwsA(
              isA<ServerpodClientException>().having(
                (e) => e.statusCode,
                'statusCode',
                400,
              ),
            ),
          );
        });

        test('toggles and deletes memory with ownership verification', () async {
          final memory = await endpoints.ai.addMemory(
            userA,
            content: 'Ưu tiên bài tập lập trình C++',
          );

          // Disable
          final disabled = await endpoints.ai.toggleMemory(
            userA,
            memoryId: memory.id!,
            disabled: true,
          );
          expect(disabled.disabledAt, isNotNull);

          // activeOnly hides it
          final activeMemories = await endpoints.ai.getMemories(
            userA,
            activeOnly: true,
          );
          expect(activeMemories.any((m) => m.id == memory.id), isFalse);

          // all memories shows it
          final allMemories = await endpoints.ai.getMemories(
            userA,
            activeOnly: false,
          );
          expect(allMemories.any((m) => m.id == memory.id), isTrue);

          // User B cannot toggle or delete User A's memory
          await expectLater(
            endpoints.ai.toggleMemory(
              userB,
              memoryId: memory.id!,
              disabled: false,
            ),
            throwsA(isA<ServerpodClientException>()),
          );

          await expectLater(
            endpoints.ai.deleteMemory(userB, memoryId: memory.id!),
            throwsA(isA<ServerpodClientException>()),
          );

          // User A deletes successfully
          await endpoints.ai.deleteMemory(userA, memoryId: memory.id!);
          final remaining = await endpoints.ai.getMemories(
            userA,
            activeOnly: false,
          );
          expect(remaining.any((m) => m.id == memory.id), isFalse);
        });

        test('rejects adding memory when memoryEnabled is false', () async {
          await endpoints.ai.updatePreferences(
            userA,
            explanationStyle: 'standard',
            personalizationEnabled: true,
            memoryEnabled: false,
          );

          await expectLater(
            endpoints.ai.addMemory(userA, content: 'Tôi học ngành CNTT'),
            throwsA(isA<ServerpodClientException>()),
          );
        });
      });

      group('Student Context Isolation and Prompt Verification', () {
        test('injects student context and enforces strict cross-user isolation', () async {
          // Ensure personalization & memory are enabled for both
          await endpoints.ai.updatePreferences(
            userA,
            explanationStyle: 'concise',
            personalizationEnabled: true,
            memoryEnabled: true,
          );
          await endpoints.ai.updatePreferences(
            userB,
            explanationStyle: 'detailed',
            personalizationEnabled: true,
            memoryEnabled: true,
          );

          // Setup profile for User A
          final profileA = await endpoints.studentProfile.getMyProfile(userA);
          profileA.fullName = 'Nguyen Van Alpha';
          profileA.studentCode = 'SV_ALPHA_001';
          profileA.faculty = 'Khoa CNTT';
          await endpoints.studentProfile.updateMyProfile(
            userA,
            fullName: 'Nguyen Van Alpha',
            className: 'CNTT_K21A',
          );

          // Setup profile for User B
          final profileB = await endpoints.studentProfile.getMyProfile(userB);
          profileB.fullName = 'Tran Thi Beta';
          profileB.studentCode = 'SV_BETA_002';
          profileB.faculty = 'Khoa Kinh Te';
          await endpoints.studentProfile.updateMyProfile(
            userB,
            fullName: 'Tran Thi Beta',
            className: 'KT_K21B',
          );

          // Add distinctive memory for each
          await endpoints.ai.addMemory(
            userA,
            content: 'Dự định thi chứng chỉ AWS Cloud Practitioner',
          );
          await endpoints.ai.addMemory(
            userB,
            content: 'Đang nghiên cứu thị trường chứng khoán phái sinh',
          );

          // Create conversation for A and B
          final convA = await endpoints.ai.createConversation(
            userA,
            title: 'Hỏi Alpha',
          );
          final convB = await endpoints.ai.createConversation(
            userB,
            title: 'Hỏi Beta',
          );

          FakeAiProvider.clearCapturedRequests();

          // User A sends message
          final streamA = endpoints.ai.sendMessage(
            userA,
            conversationId: convA.id!,
            userMessage: 'Gợi ý lộ trình học tập',
          );
          await streamA.drain<void>();

          // User B sends same message
          final streamB = endpoints.ai.sendMessage(
            userB,
            conversationId: convB.id!,
            userMessage: 'Gợi ý lộ trình học tập',
          );
          await streamB.drain<void>();

          expect(FakeAiProvider.capturedRequests, hasLength(2));

          final reqA = FakeAiProvider.capturedRequests[0];
          final reqB = FakeAiProvider.capturedRequests[1];

          final promptA = reqA.messages.first.content;
          final promptB = reqB.messages.first.content;

          // Verify User A context
          expect(promptA, contains('Nguyen Van Alpha'));
          expect(promptA, contains('AWS Cloud Practitioner'));
          expect(promptA, contains('ngắn gọn, đi thẳng vào trọng tâm')); // concise style
          expect(promptA, isNot(contains('Tran Thi Beta')));
          expect(promptA, isNot(contains('chứng khoán phái sinh')));

          // Verify User B context
          expect(promptB, contains('Tran Thi Beta'));
          expect(promptB, contains('chứng khoán phái sinh'));
          expect(promptB, contains('Giải thích chi tiết, từng bước')); // detailed style
          expect(promptB, isNot(contains('Nguyen Van Alpha')));
          expect(promptB, isNot(contains('AWS Cloud Practitioner')));
        });

        test('omits student context when personalization is turned off', () async {
          await endpoints.ai.updatePreferences(
            userA,
            explanationStyle: 'standard',
            personalizationEnabled: false,
            memoryEnabled: false,
          );

          final convA = await endpoints.ai.createConversation(
            userA,
            title: 'Hỏi không context',
          );

          FakeAiProvider.clearCapturedRequests();

          final stream = endpoints.ai.sendMessage(
            userA,
            conversationId: convA.id!,
            userMessage: 'Cho tôi một câu danh ngôn',
          );
          await stream.drain<void>();

          expect(FakeAiProvider.capturedRequests, hasLength(1));
          final req = FakeAiProvider.capturedRequests.first;
          expect(req.studentContext, isNull);

          final systemMsg = req.messages.first.content;
          expect(systemMsg, isNot(contains('Nguyen Van Alpha')));
          expect(systemMsg, isNot(contains('AWS Cloud Practitioner')));
          expect(systemMsg, isNot(contains('[Personalized Student Context]')));
        });

        test('includes book excerpt in chat payload without dumping entire book', () async {
          await endpoints.ai.updatePreferences(
            userA,
            explanationStyle: 'standard',
            personalizationEnabled: true,
            memoryEnabled: true,
          );

          final conv = await endpoints.ai.createConversation(
            userA,
            title: 'Hỏi về sách',
          );

          FakeAiProvider.clearCapturedRequests();

          final selectedExcerpt =
              'Thuật toán Dijkstra tìm đường đi ngắn nhất từ một đỉnh nguồn đến tất cả các đỉnh còn lại.';

          final stream = endpoints.ai.sendMessage(
            userA,
            conversationId: conv.id!,
            userMessage: 'Giải thích đoạn này cho tôi',
            selectedText: selectedExcerpt,
          );
          await stream.drain<void>();

          expect(FakeAiProvider.capturedRequests, hasLength(1));
          final req = FakeAiProvider.capturedRequests.first;
          expect(req.studentContext, isNotNull);
          expect(req.studentContext, contains('Thuật toán Dijkstra'));
          expect(req.studentContext!.length, lessThan(2000));
        });
      });

      group('Study Suggestion', () {
        test('returns personalized study suggestion or null if personalization is off', () async {
          await endpoints.ai.updatePreferences(
            userA,
            explanationStyle: 'standard',
            personalizationEnabled: true,
            memoryEnabled: true,
          );

          final suggestion = await endpoints.ai.getStudySuggestion(userA);
          // When student has profile/data, a suggestion may be returned
          if (suggestion != null) {
            expect(suggestion.title, isNotEmpty);
            expect(suggestion.message, isNotEmpty);
            expect(suggestion.priority, isIn(['high', 'normal', 'low']));
          }

          // When personalization is turned off, suggestion is null
          await endpoints.ai.updatePreferences(
            userA,
            explanationStyle: 'standard',
            personalizationEnabled: false,
            memoryEnabled: false,
          );
          final disabledSuggestion = await endpoints.ai.getStudySuggestion(userA);
          expect(disabledSuggestion, isNull);
        });
      });
    },
  );
}
