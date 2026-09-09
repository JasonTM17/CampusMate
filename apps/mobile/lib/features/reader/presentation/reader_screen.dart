import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../application/reader_controller.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({
    super.key,
    required this.bookId,
    this.format = 'pdf',
    this.title = 'Tài liệu học tập',
  });

  final int bookId;
  final String format;
  final String title;

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(readerControllerProvider.notifier)
          .openBook(bookId: widget.bookId, format: widget.format);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(readerControllerProvider);
    final controller = ref.read(readerControllerProvider.notifier);

    final isDark = state.themeMode == ReaderThemeMode.dark;
    final isSepia = state.themeMode == ReaderThemeMode.sepia;

    final backgroundColor = isDark
        ? const Color(0xFF1E1E1E)
        : isSepia
        ? const Color(0xFFFBF0D9)
        : Colors.white;

    final textColor = isDark
        ? const Color(0xFFE0E0E0)
        : isSepia
        ? const Color(0xFF5F4B32)
        : const Color(0xFF212121);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        title: Text('${widget.title} (${widget.format.toUpperCase()})'),
        leading: IconButton(
          tooltip: 'Quay lại',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            unawaited(controller.syncProgressNow());
            context.pop();
          },
        ),
        actions: [
          IconButton(
            tooltip: 'Giao diện & Cỡ chữ',
            icon: const Icon(Icons.format_size),
            onPressed: () =>
                _showDisplaySettingsSheet(context, state, controller),
          ),
          IconButton(
            tooltip: 'Đánh dấu & Ghi chú',
            icon: const Icon(Icons.collections_bookmark_outlined),
            onPressed: () => _showAnnotationsSheet(context, state, controller),
          ),
          IconButton(
            tooltip: 'Hỏi AI về tài liệu',
            icon: const Icon(Icons.auto_awesome_outlined),
            onPressed: () {
              final encodedTitle = Uri.encodeComponent(widget.title);
              context.push('/ai?bookId=${widget.bookId}&title=$encodedTitle');
            },
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? AppEmptyState(
              icon: Icons.error_outline,
              title: 'Không thể mở tài liệu',
              message: state.errorMessage!,
              actionLabel: 'Thử lại',
              onAction: () => controller.initialize(),
            )
          : Column(
              children: [
                if (state.showResumePrompt)
                  _ResumeBanner(
                    savedPercent: state.savedProgressPercent,
                    savedLocation: state.savedLocation,
                    onResume: controller.resumeFromSavedProgress,
                    onDismiss: controller.dismissResumePrompt,
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đang đọc tại vị trí: ${state.currentLocation}',
                          style: TextStyle(
                            color: textColor.withAlpha(180),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.m),
                        SelectableText(
                          'Nội dung tài liệu đang được nạp thông qua trình đọc ${widget.format.toUpperCase()}.\n\n'
                          'CampusMate hỗ trợ theo dõi tiến trình đọc theo thời gian thực (LWW conflict resolution), '
                          'cho phép bạn lưu vị trí, đánh dấu trang và tạo ghi chú học tập ngay trên thiết bị.',
                          style: TextStyle(
                            color: textColor,
                            fontSize: state.fontSize,
                            height: 1.6,
                          ),
                          contextMenuBuilder: (context, editableTextState) {
                            final textSelection =
                                editableTextState.textEditingValue.selection;
                            final selectedText = textSelection
                                .textInside(
                                  editableTextState.textEditingValue.text,
                                )
                                .trim();
                            final buttonItems =
                                editableTextState.contextMenuButtonItems;
                            if (selectedText.isNotEmpty) {
                              buttonItems.insert(
                                0,
                                ContextMenuButtonItem(
                                  label: 'Hỏi AI đoạn này',
                                  onPressed: () {
                                    ContextMenuController.removeAny();
                                    final encodedTitle = Uri.encodeComponent(
                                      widget.title,
                                    );
                                    final encodedSelected = Uri.encodeComponent(
                                      selectedText,
                                    );
                                    context.push(
                                      '/ai?bookId=${widget.bookId}&title=$encodedTitle&selectedText=$encodedSelected',
                                    );
                                  },
                                ),
                              );
                            }
                            return AdaptiveTextSelectionToolbar.buttonItems(
                              anchors: editableTextState.contextMenuAnchors,
                              buttonItems: buttonItems,
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.l),
                        Wrap(
                          spacing: AppSpacing.s,
                          children: [
                            ActionChip(
                              avatar: const Icon(
                                Icons.bookmark_add_outlined,
                                size: 18,
                              ),
                              label: const Text('Đánh dấu vị trí này'),
                              onPressed: () {
                                unawaited(HapticFeedback.lightImpact());
                                controller.addBookmark(
                                  title:
                                      'Đánh dấu trang ${state.currentLocation}',
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Đã đánh dấu vị trí đọc này'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            ActionChip(
                              avatar: const Icon(
                                Icons.note_add_outlined,
                                size: 18,
                              ),
                              label: const Text('Thêm ghi chú'),
                              onPressed: () =>
                                  _showAddNoteDialog(context, controller),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                _BottomProgressToolbar(
                  state: state,
                  textColor: textColor,
                  onLocationChanged: (newLocation, newPercent) {
                    controller.updateLocation(
                      location: newLocation,
                      progressPercent: newPercent,
                    );
                    unawaited(controller.syncProgressNow());
                  },
                ),
              ],
            ),
    );
  }

  void _showDisplaySettingsSheet(
    BuildContext context,
    ReaderState state,
    ReaderController controller,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cài đặt hiển thị',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    const Text('Màu nền giao diện:'),
                    const SizedBox(height: AppSpacing.s),
                    SegmentedButton<ReaderThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ReaderThemeMode.light,
                          label: Text('Sáng'),
                        ),
                        ButtonSegment(
                          value: ReaderThemeMode.sepia,
                          label: Text('Sepia'),
                        ),
                        ButtonSegment(
                          value: ReaderThemeMode.dark,
                          label: Text('Tối'),
                        ),
                      ],
                      selected: {state.themeMode},
                      onSelectionChanged: (selection) {
                        controller.setThemeMode(selection.first);
                        setModalState(() {});
                      },
                    ),
                    const SizedBox(height: AppSpacing.m),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cỡ chữ:'),
                        Text('${state.fontSize.toInt()} px'),
                      ],
                    ),
                    Slider(
                      min: 12.0,
                      max: 26.0,
                      divisions: 7,
                      value: state.fontSize,
                      onChanged: (val) {
                        controller.setFontSize(val);
                        setModalState(() {});
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAnnotationsSheet(
    BuildContext context,
    ReaderState state,
    ReaderController controller,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: SizedBox(
            height: 420,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.bookmark), text: 'Đánh dấu'),
                    Tab(icon: Icon(Icons.note), text: 'Ghi chú'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      state.bookmarks.isEmpty
                          ? const Center(
                              child: Text('Chưa có trang đánh dấu nào.'),
                            )
                          : ListView.builder(
                              itemCount: state.bookmarks.length,
                              itemBuilder: (context, index) {
                                final item = state.bookmarks[index];
                                return ListTile(
                                  title: Text(item.title),
                                  subtitle: Text('Vị trí: ${item.location}'),
                                  trailing: IconButton(
                                    tooltip: 'Xóa đánh dấu',
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () =>
                                        controller.removeBookmark(item.id!),
                                  ),
                                  onTap: () {
                                    controller.updateLocation(
                                      location: item.location,
                                      progressPercent: state.progressPercent,
                                    );
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                      state.notes.isEmpty
                          ? const Center(child: Text('Chưa có ghi chú nào.'))
                          : ListView.builder(
                              itemCount: state.notes.length,
                              itemBuilder: (context, index) {
                                final note = state.notes[index];
                                return ListTile(
                                  title: Text(note.content),
                                  subtitle: Text('Vị trí: ${note.location}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        tooltip: 'Sao chép ghi chú',
                                        icon: const Icon(
                                          Icons.copy_outlined,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(text: note.content),
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Đã sao chép ghi chú',
                                              ),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        tooltip: 'Xóa ghi chú',
                                        icon: const Icon(Icons.delete_outline),
                                        onPressed: () =>
                                            controller.deleteNote(note.id!),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddNoteDialog(BuildContext context, ReaderController controller) {
    final noteController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm ghi chú'),
        content: TextField(
          controller: noteController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Nhập nội dung ghi chú...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () {
              final text = noteController.text.trim();
              if (text.isNotEmpty) {
                controller.saveNote(content: text);
              }
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }
}

class _ResumeBanner extends StatelessWidget {
  const _ResumeBanner({
    required this.savedPercent,
    required this.savedLocation,
    required this.onResume,
    required this.onDismiss,
  });

  final double savedPercent;
  final String savedLocation;
  final VoidCallback onResume;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: AppSpacing.s,
      ),
      child: Row(
        children: [
          Icon(Icons.history, color: theme.colorScheme.onPrimaryContainer),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              'Tiếp tục từ ${savedPercent.toInt()}% (Vị trí $savedLocation)?',
              style: TextStyle(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(onPressed: onDismiss, child: const Text('Bỏ qua')),
          FilledButton.tonal(
            onPressed: onResume,
            child: const Text('Tiếp tục'),
          ),
        ],
      ),
    );
  }
}

class _BottomProgressToolbar extends StatelessWidget {
  const _BottomProgressToolbar({
    required this.state,
    required this.textColor,
    required this.onLocationChanged,
  });

  final ReaderState state;
  final Color textColor;
  final void Function(String location, double percent) onLocationChanged;

  @override
  Widget build(BuildContext context) {
    final currentLoc = int.tryParse(state.currentLocation) ?? 1;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s,
      ),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withAlpha(120),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.m),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                tooltip: 'Vị trí trước',
                onPressed: currentLoc > 1
                    ? () {
                        final prev = currentLoc - 1;
                        final percent = (prev / 100.0) * 100.0;
                        onLocationChanged(prev.toString(), percent);
                      }
                    : null,
              ),
              Text(
                'Vị trí: ${state.currentLocation} (${state.progressPercent.toInt()}%)',
                style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                tooltip: 'Vị trí kế tiếp',
                onPressed: () {
                  final next = currentLoc + 1;
                  final percent = (next / 100.0) * 100.0;
                  onLocationChanged(next.toString(), percent.clamp(0.0, 100.0));
                },
              ),
            ],
          ),
          Slider(
            value: state.progressPercent.clamp(0.0, 100.0),
            min: 0.0,
            max: 100.0,
            divisions: 100,
            onChanged: (val) {
              final loc = ((val / 100.0) * 50).clamp(1, 100).toInt().toString();
              onLocationChanged(loc, val);
            },
          ),
        ],
      ),
    );
  }
}
