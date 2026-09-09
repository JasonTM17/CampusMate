import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

/// Supported explanation styles for personalized AI.
const validExplanationStyles = {
  'standard',
  'concise',
  'detailed',
  'socratic',
  'eli5',
};

class AiPreferenceService {
  /// Loads caller's AI preferences, inserting defaults if not yet created.
  Future<StudentAiPreference> getPreferences(
    Session session, {
    required UuidValue userId,
  }) async {
    final existing = await StudentAiPreference.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (existing != null) return existing;

    final defaultPref = StudentAiPreference(
      userId: userId,
      explanationStyle: 'standard',
      personalizationEnabled: true,
      memoryEnabled: true,
      updatedAt: DateTime.now().toUtc(),
    );
    try {
      return await StudentAiPreference.db.insertRow(session, defaultPref);
    } on Exception {
      // In case of a race condition on unique user index
      final winner = await StudentAiPreference.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
      );
      if (winner != null) return winner;
      rethrow;
    }
  }

  /// Updates caller's AI preferences.
  Future<StudentAiPreference> updatePreferences(
    Session session, {
    required UuidValue userId,
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
  }) async {
    final normalizedStyle = validExplanationStyles.contains(explanationStyle)
        ? explanationStyle
        : 'standard';

    final pref = await getPreferences(session, userId: userId);
    pref.explanationStyle = normalizedStyle;
    pref.personalizationEnabled = personalizationEnabled;
    pref.memoryEnabled = memoryEnabled;
    pref.updatedAt = DateTime.now().toUtc();

    return StudentAiPreference.db.updateRow(session, pref);
  }
}
