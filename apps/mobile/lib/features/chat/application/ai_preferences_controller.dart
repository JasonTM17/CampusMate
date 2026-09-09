import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chat_controller.dart';

/// Provides the active study suggestion for the dashboard card.
final studySuggestionProvider = FutureProvider.autoDispose<StudySuggestion?>((
  ref,
) async {
  final repo = ref.watch(aiRepositoryProvider);
  return repo.getStudySuggestion();
});

/// Manages student AI preferences state and persistence.
class AiPreferencesController extends AsyncNotifier<StudentAiPreference> {
  @override
  Future<StudentAiPreference> build() async {
    final repo = ref.watch(aiRepositoryProvider);
    return repo.getPreferences();
  }

  Future<void> updatePreferences({
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) async {
    final repo = ref.read(aiRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => repo.updatePreferences(
        explanationStyle: explanationStyle,
        personalizationEnabled: personalizationEnabled,
        memoryEnabled: memoryEnabled,
      ),
    );
    // Invalidate suggestion so dashboard updates to reflect new preferences
    ref.invalidate(studySuggestionProvider);
  }
}

final aiPreferencesControllerProvider =
    AsyncNotifierProvider<AiPreferencesController, StudentAiPreference>(
      AiPreferencesController.new,
    );

/// Manages student AI memories state and actions.
class AiMemoriesController extends AsyncNotifier<List<AiUserMemory>> {
  @override
  Future<List<AiUserMemory>> build() async {
    final repo = ref.watch(aiRepositoryProvider);
    return repo.getMemories(activeOnly: false);
  }

  Future<void> addMemory(String content) async {
    final repo = ref.read(aiRepositoryProvider);
    await repo.addMemory(content: content);
    ref.invalidateSelf();
    await future;
  }

  Future<void> toggleMemory({
    required int memoryId,
    required bool disabled,
  }) async {
    final repo = ref.read(aiRepositoryProvider);
    await repo.toggleMemory(memoryId: memoryId, disabled: disabled);
    final current = state.hasValue ? state.value : null;
    if (current != null) {
      state = AsyncValue.data([
        for (final m in current)
          if (m.id == memoryId)
            m.copyWith(disabledAt: disabled ? DateTime.now().toUtc() : null)
          else
            m,
      ]);
    } else {
      ref.invalidateSelf();
    }
  }

  Future<void> deleteMemory(int memoryId) async {
    final repo = ref.read(aiRepositoryProvider);
    await repo.deleteMemory(memoryId: memoryId);
    final current = state.hasValue ? state.value : null;
    if (current != null) {
      state = AsyncValue.data(current.where((m) => m.id != memoryId).toList());
    } else {
      ref.invalidateSelf();
    }
  }
}

final aiMemoriesControllerProvider =
    AsyncNotifierProvider<AiMemoriesController, List<AiUserMemory>>(
      AiMemoriesController.new,
    );
