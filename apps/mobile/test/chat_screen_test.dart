import 'package:campusmate/features/chat/application/chat_controller.dart';
import 'package:campusmate/features/chat/domain/chat_message.dart';
import 'package:campusmate/features/chat/domain/chat_repository.dart';
import 'package:campusmate/features/chat/presentation/chat_screen.dart';
import 'package:campusmate_client/campusmate_client.dart';
import 'package:campusmate/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _HistoryFailureRepo implements AiRepository {
  _HistoryFailureRepo({this.failCreate = false});

  final bool failCreate;
  int openCalls = 0;
  int createCalls = 0;

  @override
  Future<List<ConversationSummary>> listConversations() async => [];

  @override
  Future<ConversationSummary> createConversation({
    required String title,
  }) async {
    createCalls++;
    if (failCreate) {
      throw StateError('offline');
    }
    return ConversationSummary(id: 7, title: title, updatedAt: DateTime.now());
  }

  @override
  Future<void> deleteConversation(int conversationId) async {}

  @override
  Future<List<ChatMessage>> getMessages(int conversationId) async {
    openCalls++;
    throw StateError('offline');
  }

  @override
  Stream<String> sendMessage({
    required int conversationId,
    required String content,
    int? bookId,
    String? selectedText,
  }) async* {}

  @override
  Future<StudentAiPreference> getPreferences() async => StudentAiPreference(
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        explanationStyle: 'standard',
        personalizationEnabled: true,
        memoryEnabled: true,
        updatedAt: DateTime.now(),
      );

  @override
  Future<StudentAiPreference> updatePreferences({
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) async =>
      StudentAiPreference(
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        explanationStyle: explanationStyle,
        personalizationEnabled: personalizationEnabled,
        memoryEnabled: memoryEnabled,
        updatedAt: DateTime.now(),
      );

  @override
  Future<List<AiUserMemory>> getMemories({bool activeOnly = false}) async => [];

  @override
  Future<AiUserMemory> addMemory({required String content, String? source}) async =>
      AiUserMemory(
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        content: content,
        source: source ?? 'user',
        createdAt: DateTime.now(),
      );

  @override
  Future<AiUserMemory> toggleMemory({
    required int memoryId,
    required bool disabled,
  }) async =>
      AiUserMemory(
        id: memoryId,
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        content: 'Sample',
        source: 'user',
        createdAt: DateTime.now(),
        disabledAt: disabled ? DateTime.now() : null,
      );

  @override
  Future<void> deleteMemory({required int memoryId}) async {}

  @override
  Future<StudySuggestion?> getStudySuggestion() async => null;
}

Widget _host(AiRepository repository, {int? conversationId = 7}) {
  return ProviderScope(
    overrides: [aiRepositoryProvider.overrideWithValue(repository)],
    child: MaterialApp(
      locale: const Locale('vi'),
      supportedLocales: const [Locale('vi'), Locale('en')],
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      home: ChatScreen(conversationId: conversationId),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('shows history load errors with retry', (tester) async {
    final repo = _HistoryFailureRepo();

    await tester.pumpWidget(_host(repo));
    await tester.pumpAndSettle();

    expect(repo.openCalls, 1);
    expect(find.text('Không thể tải lịch sử.'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Thử lại'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Thử lại'));
    await tester.pumpAndSettle();

    expect(repo.openCalls, 2);
  });

  testWidgets('shows conversation creation errors with retry', (tester) async {
    final repo = _HistoryFailureRepo(failCreate: true);

    await tester.pumpWidget(_host(repo, conversationId: null));
    await tester.pumpAndSettle();

    expect(repo.createCalls, 1);
    expect(repo.openCalls, 0);
    expect(find.text('Không thể tải lịch sử.'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Thử lại'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Thử lại'));
    await tester.pumpAndSettle();

    expect(repo.createCalls, 2);
  });
}
