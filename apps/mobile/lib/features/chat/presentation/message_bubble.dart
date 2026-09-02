import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../domain/chat_message.dart';

/// A single chat bubble, styled per role.
///
/// User bubbles right-aligned on `primaryContainer`; assistant bubbles
/// left-aligned on `surfaceVariant` with markdown rendering. Consecutive
/// same-role bubbles collapse the avatar gap (handled by the list).
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    this.showAvatar = true,
  });

  final ChatMessage message;
  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;
    final bubbleColor = isUser
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;
    final textColor = isUser
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurface;

    return Row(
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isUser && showAvatar)
          _Avatar(
            icon: Icons.smart_toy_outlined,
            color: theme.colorScheme.secondary,
          ),
        if (!isUser && showAvatar) const SizedBox(width: 8),
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: AppSpacing.mPadding,
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: AppRadius.lRadius,
            ),
            child: isUser
                ? Text(message.content, style: TextStyle(color: textColor))
                : MarkdownBody(
                    data: message.content,
                    styleSheet: MarkdownStyleSheet(
                      p: theme.textTheme.bodyMedium?.copyWith(color: textColor),
                      code: theme.textTheme.bodySmall?.copyWith(
                        backgroundColor: theme.colorScheme.surface,
                        fontFamily: 'monospace',
                      ),
                    ),
                    shrinkWrap: true,
                  ),
          ),
        ),
        if (isUser && showAvatar) const SizedBox(width: 8),
        if (isUser && showAvatar)
          _Avatar(icon: Icons.person_outline, color: theme.colorScheme.primary),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.icon, required this.color});
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: color.withValues(alpha: 0.15),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
