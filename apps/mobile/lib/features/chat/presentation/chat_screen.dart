import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/chat_controller.dart';
import '../domain/chat_message.dart';
import '../domain/chat_state.dart';
import 'message_bubble.dart';

/// The AI chat screen: message list + streaming-aware input bar.
///
/// Reads the `conversationId` route extra; on first open it creates a
/// conversation via the authenticated user's session. Shows a first-run
/// empty state with the 4 suggested prompts (📚 🧠 📅 📖) per phase-08.
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    this.conversationId,
    this.bookId,
    this.bookTitle,
    this.selectedText,
  });

  final int? conversationId;
  final int? bookId;
  final String? bookTitle;
  final String? selectedText;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  bool _inputNotEmpty = false;
  int? _attachedBookId;
  String? _attachedBookTitle;
  String? _attachedSelectedText;

  static const _suggestions = [
    '📚 Giải thích bài học',
    '🧠 Tạo quiz',
    '📅 Lập kế hoạch học',
    '📖 Gợi ý sách',
  ];

  @override
  void initState() {
    super.initState();
    _attachedBookId = widget.bookId;
    _attachedBookTitle = widget.bookTitle;
    _attachedSelectedText = widget.selectedText;
    _inputController.addListener(() {
      final notEmpty = _inputController.text.trim().isNotEmpty;
      if (notEmpty != _inputNotEmpty) {
        setState(() {
          _inputNotEmpty = notEmpty;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  /// Ensures there is a conversation to talk to, then loads its history.
  Future<void> _bootstrap() async {
    final title = _attachedBookTitle != null
        ? 'Hỏi về ${_attachedBookTitle!}'
        : 'Hội thoại mới';
    await ref
        .read(chatControllerProvider.notifier)
        .openOrCreateConversation(
          conversationId: widget.conversationId,
          newConversationTitle: title,
        );
    _scrollToBottom();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _send() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    await ref
        .read(chatControllerProvider.notifier)
        .sendMessage(
          text,
          bookId: _attachedBookId,
          selectedText: _attachedSelectedText,
        );
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final chat = ref.watch(chatControllerProvider);
    final isStreaming = chat.status == ChatStatus.streaming;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navAi),
        actions: [
          IconButton(
            tooltip: 'Cài đặt & Bộ nhớ AI',
            icon: const Icon(Icons.tune_outlined),
            onPressed: () => context.push('/ai/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _attachedContextChip(theme),
            Expanded(child: _body(context, chat)),
            _inputBar(context, theme, isStreaming),
          ],
        ),
      ),
    );
  }

  Widget _attachedContextChip(ThemeData theme) {
    if (_attachedBookTitle == null && _attachedSelectedText == null) {
      return const SizedBox.shrink();
    }
    final title = _attachedBookTitle ?? 'Đoạn trích tài liệu';
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.xs,
      ),
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.m,
        AppSpacing.xs,
        AppSpacing.m,
        0,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.m),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              'Đang hỏi về: $title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Gỡ tài liệu đính kèm',
            icon: const Icon(Icons.close, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _attachedBookId = null;
                _attachedBookTitle = null;
                _attachedSelectedText = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, ChatState chat) {
    final l10n = AppLocalizations.of(context)!;
    final isStreaming = chat.status == ChatStatus.streaming;
    if (chat.status == ChatStatus.loadingHistory) {
      return const Center(child: CircularProgressIndicator());
    }
    if (chat.status == ChatStatus.error && chat.messages.isEmpty) {
      return _ErrorState(
        message: chat.error ?? l10n.errorGeneric,
        actionLabel: l10n.retry,
        onRetry: () {
          _bootstrap();
        },
      );
    }
    if (chat.messages.isEmpty) {
      return _EmptyState(
        suggestions: _suggestions,
        chipsLabel: l10n.chatSuggestions,
        onSuggestion: (text) {
          _inputController.text = text;
          _send();
        },
      );
    }
    return ListView.separated(
      controller: _scrollController,
      padding: AppSpacing.mHorizontal,
      itemCount: chat.messages.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final message = chat.messages[index];
        final isLastAssistant =
            index == chat.messages.length - 1 &&
            message.role == MessageRole.assistant;
        return Column(
          children: [
            MessageBubble(message: message),
            if (isStreaming && isLastAssistant)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: AppSpacing.sTop,
                  child: Text(
                    '…',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    semanticsLabel: l10n.chatTyping,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _inputBar(BuildContext context, ThemeData theme, bool isStreaming) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: AppSpacing.mPadding.copyWith(
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.dividerColor, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
              decoration: InputDecoration(
                hintText: l10n.chatInputHint,
                border: OutlineInputBorder(borderRadius: AppRadius.lRadius),
              ),
              enabled: !isStreaming,
            ),
          ),
          SizedBox(width: AppSpacing.s),
          IconButton.filled(
            onPressed: (_inputNotEmpty && !isStreaming) ? _send : null,
            icon: const Icon(Icons.send),
            tooltip: l10n.chatSend,
            style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
          ),
        ],
      ),
    );
  }
}

/// Error state shown when a conversation cannot be loaded.
class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.actionLabel,
    required this.onRetry,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: AppSpacing.lHorizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            SizedBox(height: AppSpacing.m),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: AppSpacing.m),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(actionLabel),
            ),
          ],
        ),
      ),
    );
  }
}

/// First-run empty state with tappable suggestion chips.
class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.suggestions,
    required this.chipsLabel,
    required this.onSuggestion,
  });

  final List<String> suggestions;
  final String chipsLabel;
  final ValueChanged<String> onSuggestion;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: AppSpacing.lHorizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.smart_toy_outlined,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            SizedBox(height: AppSpacing.m),
            Text(chipsLabel, style: theme.textTheme.titleMedium),
            SizedBox(height: AppSpacing.m),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                for (final s in suggestions)
                  ActionChip(label: Text(s), onPressed: () => onSuggestion(s)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
