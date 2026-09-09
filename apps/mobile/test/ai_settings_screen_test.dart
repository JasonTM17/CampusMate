import 'package:campusmate/features/chat/application/chat_controller.dart';
import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/domain/chat_repository.dart';
import 'package:campusmate/features/chat/presentation/ai_settings_screen.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestAiRepository implements AiRepository {
  StudentAiPreference pref = StudentAiPreference(
    userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
    explanationStyle: 'standard',
    personalizationEnabled: true,
    memoryEnabled: true,
    updatedAt: DateTime.utc(2026, 9, 8),
  );

  List<AiUserMemory> memories = [
    AiUserMemory(
      id: 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      content: 'Thích học bằng mindmap',
      source: 'user',
      createdAt: DateTime.utc(2026, 9, 8),
    ),
  ];

  @override
  Future<StudentAiPreference> getPreferences() async => pref;

  @override
  Future<StudentAiPreference> updatePreferences({
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) async {
    pref = pref.copyWith(
      explanationStyle: explanationStyle,
      personalizationEnabled: personalizationEnabled,
      memoryEnabled: memoryEnabled,
    );
    return pref;
  }

  @override
  Future<List<AiUserMemory>> getMemories({bool activeOnly = false}) async =>
      memories;

  @override
  Future<AiUserMemory> addMemory({
    required String content,
    String? source,
  }) async {
    final newMem = AiUserMemory(
      id: memories.length + 1,
      userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      content: content,
      source: source ?? 'user',
      createdAt: DateTime.utc(2026, 9, 8),
    );
    memories.add(newMem);
    return newMem;
  }

  @override
  Future<AiUserMemory> toggleMemory({
    required int memoryId,
    required bool disabled,
  }) async {
    final idx = memories.indexWhere((m) => m.id == memoryId);
    final updated = memories[idx].copyWith(
      disabledAt: disabled ? DateTime.utc(2026, 9, 8) : null,
    );
    memories[idx] = updated;
    return updated;
  }

  @override
  Future<void> deleteMemory({required int memoryId}) async {
    memories.removeWhere((m) => m.id == memoryId);
  }

  @override
  Future<StudySuggestion?> getStudySuggestion() async => null;

  @override
  Future<List<ConversationSummary>> listConversations() async => [];
  @override
  Future<ConversationSummary> createConversation({required String title}) =>
      throw UnimplementedError();
  @override
  Future<void> deleteConversation(int conversationId) =>
      throw UnimplementedError();
  @override
  Future<List<ChatMessage>> getMessages(int conversationId) =>
      throw UnimplementedError();
  @override
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
    int? bookId,
    String? selectedText,
  }) =>
      throw UnimplementedError();
}

Widget _buildScreen(_TestAiRepository repo) {
  return ProviderScope(
    overrides: [aiRepositoryProvider.overrideWithValue(repo)],
    child: const MaterialApp(
      home: AiSettingsScreen(),
    ),
  );
}

void main() {
  testWidgets('renders AI settings screen and displays preferences and memories', (
    tester,
  ) async {
    final repo = _TestAiRepository();
    await tester.pumpWidget(_buildScreen(repo));
    await tester.pumpAndSettle();

    expect(find.text('Cài đặt & Bộ nhớ AI'), findsOneWidget);
    expect(find.text('Bật cá nhân hóa AI'), findsOneWidget);
    expect(find.text('Bật bộ nhớ học tập dài hạn'), findsOneWidget);
    expect(find.text('Thích học bằng mindmap'), findsOneWidget);
    expect(find.text('Đang kích hoạt'), findsOneWidget);
  });

  testWidgets('toggling switch updates preferences', (tester) async {
    final repo = _TestAiRepository();
    await tester.pumpWidget(_buildScreen(repo));
    await tester.pumpAndSettle();

    // Toggle personalization switch off
    final switches = find.byType(Switch);
    expect(switches, findsNWidgets(2));

    await tester.tap(switches.first);
    await tester.pumpAndSettle();

    expect(repo.pref.personalizationEnabled, isFalse);
  });

  testWidgets('adds new memory via dialog', (tester) async {
    final repo = _TestAiRepository();
    await tester.pumpWidget(_buildScreen(repo));
    await tester.pumpAndSettle();

    // Tap Thêm button
    await tester.tap(find.byKey(const Key('add-memory-button')));
    await tester.pumpAndSettle();

    expect(find.text('Thêm ghi nhớ cho AI'), findsOneWidget);

    // Enter content
    await tester.enterText(
      find.byKey(const Key('add-memory-input')),
      'Đang ôn thi chứng chỉ IELTS',
    );
    await tester.pumpAndSettle();

    // Confirm
    await tester.tap(find.byKey(const Key('add-memory-confirm-button')));
    await tester.pumpAndSettle();

    expect(find.text('Đang ôn thi chứng chỉ IELTS'), findsOneWidget);
  });
}
