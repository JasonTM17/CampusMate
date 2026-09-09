import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../domain/chat_message.dart';

/// A single chat bubble, styled per role.
///
/// User bubbles right-aligned on `primaryContainer`; assistant bubbles
/// left-aligned on `surfaceVariant` with markdown rendering. When citations
/// are present on assistant turns, renders clickable citation chips linking to
/// the corresponding book or showing document references.
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
            constraints: const BoxConstraints(maxWidth: 320),
            padding: AppSpacing.mPadding,
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: AppRadius.lRadius,
            ),
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isUser)
                  Text(message.content, style: TextStyle(color: textColor))
                else
                  MarkdownBody(
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
                if (!isUser && message.citations.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Divider(height: 1, thickness: 0.5),
                  const SizedBox(height: 6),
                  Text(
                    'Nguồn trích dẫn:',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      for (final citation in message.citations)
                        ActionChip(
                          avatar: const Icon(Icons.menu_book_outlined, size: 14),
                          label: Text(
                            citation.displayText,
                            style: const TextStyle(fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            if (citation.bookId != null) {
                              context.push('/library/${citation.bookId}');
                            } else {
                              _showCitationDialog(context, citation);
                            }
                          },
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        if (isUser && showAvatar) const SizedBox(width: 8),
        if (isUser && showAvatar)
          _Avatar(icon: Icons.person_outline, color: theme.colorScheme.primary),
      ],
    );
  }

  void _showCitationDialog(BuildContext context, ChatCitation citation) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.menu_book_outlined, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                citation.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (citation.chapter != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('Chương: ${citation.chapter}'),
              ),
            if (citation.page != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('Trang: ${citation.page}'),
              ),
            if (citation.documentId != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  'Mã tài liệu: #${citation.documentId}',
                  style: Theme.of(ctx).textTheme.bodySmall,
                ),
              ),
            if (citation.quote != null && citation.quote!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Đoạn trích:',
                style: Theme.of(ctx).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  citation.quote!,
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Đóng'),
          ),
        ],
      ),
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
