import 'package:campusmate_shared/campusmate_shared.dart' as shared;

import 'system_prompt.dart';

/// Assembles the provider-facing message list for one chat turn.
///
/// Prompt-injection baseline (§30): the [campusmateSystemPrompt] is ALWAYS the
/// first message and is produced only here, server-side. Stored history rows
/// with role `system` are dropped so a tampered row can never replace it, and
/// the caller's [userMessage] always travels as role `user` — user content is
/// data for the model to answer about, never spliced into instructions.
List<shared.AiMessage> assembleChatMessages({
  required Iterable<(String role, String content)> history,
  required String userMessage,
}) => [
  shared.AiMessage(role: 'system', content: campusmateSystemPrompt),
  for (final (role, content) in history)
    if (role != 'system') shared.AiMessage(role: role, content: content),
  shared.AiMessage(role: 'user', content: userMessage),
];
