import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../application/ai_preferences_controller.dart';

class AiSettingsScreen extends ConsumerWidget {
  const AiSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefState = ref.watch(aiPreferencesControllerProvider);
    final memoriesState = ref.watch(aiMemoriesControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt & Bộ nhớ AI')),
      body: prefState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: AppSpacing.m),
              const Text('Không thể tải cài đặt AI.'),
              const SizedBox(height: AppSpacing.s),
              FilledButton(
                onPressed: () =>
                    ref.invalidate(aiPreferencesControllerProvider),
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
        data: (pref) => ListView(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          children: [
            _PreferencesSection(pref: pref),
            const SizedBox(height: AppSpacing.l),
            _MemoriesSection(
              memoriesState: memoriesState,
              memoryEnabled: pref.memoryEnabled && pref.personalizationEnabled,
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferencesSection extends ConsumerWidget {
  const _PreferencesSection({required this.pref});

  final StudentAiPreference pref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.tune_outlined, color: AppColors.primary),
                const SizedBox(width: AppSpacing.s),
                Text(
                  'Tùy chọn cá nhân hóa',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: AppSpacing.l),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Bật cá nhân hóa AI'),
              subtitle: const Text(
                'Cho phép AI dùng thời khóa biểu, lịch thi và sách thư viện để hỗ trợ phù hợp với bạn.',
              ),
              value: pref.personalizationEnabled,
              onChanged: (val) {
                ref
                    .read(aiPreferencesControllerProvider.notifier)
                    .updatePreferences(
                      explanationStyle: pref.explanationStyle,
                      personalizationEnabled: val,
                      memoryEnabled: pref.memoryEnabled,
                    );
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Bật bộ nhớ học tập dài hạn'),
              subtitle: const Text(
                'Cho phép trợ lý lưu và áp dụng sở thích, mục tiêu học tập bạn cung cấp.',
              ),
              value: pref.memoryEnabled && pref.personalizationEnabled,
              onChanged: pref.personalizationEnabled
                  ? (val) {
                      ref
                          .read(aiPreferencesControllerProvider.notifier)
                          .updatePreferences(
                            explanationStyle: pref.explanationStyle,
                            personalizationEnabled: pref.personalizationEnabled,
                            memoryEnabled: val,
                          );
                    }
                  : null,
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Phong cách giải thích',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            DropdownButtonFormField<String>(
              key: const Key('explanation-style-dropdown'),
              initialValue: pref.explanationStyle,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppRadius.m)),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.m,
                  vertical: AppSpacing.s,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'standard',
                  child: Text('Chuẩn mực (Cân bằng, súc tích)'),
                ),
                DropdownMenuItem(
                  value: 'concise',
                  child: Text('Ngắn gọn (Trọng tâm, bullet points)'),
                ),
                DropdownMenuItem(
                  value: 'detailed',
                  child: Text('Chi tiết (Từng bước kèm ví dụ minh họa)'),
                ),
                DropdownMenuItem(
                  value: 'socratic',
                  child: Text('Gợi mở Socratic (Đặt câu hỏi tư duy)'),
                ),
                DropdownMenuItem(
                  value: 'eli5',
                  child: Text('Dễ hiểu ELI5 (Đơn giản, trực quan)'),
                ),
              ],
              onChanged: (val) {
                if (val != null) {
                  ref
                      .read(aiPreferencesControllerProvider.notifier)
                      .updatePreferences(
                        explanationStyle: val,
                        personalizationEnabled: pref.personalizationEnabled,
                        memoryEnabled: pref.memoryEnabled,
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoriesSection extends ConsumerWidget {
  const _MemoriesSection({
    required this.memoriesState,
    required this.memoryEnabled,
  });

  final AsyncValue<List<AiUserMemory>> memoriesState;
  final bool memoryEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.psychology_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.s),
                    Text(
                      'Bộ nhớ của AI',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                FilledButton.tonalIcon(
                  key: const Key('add-memory-button'),
                  onPressed: memoryEnabled
                      ? () => _showAddMemoryDialog(context, ref)
                      : null,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Thêm'),
                ),
              ],
            ),
            const Divider(height: AppSpacing.l),
            if (!memoryEnabled)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
                child: Text(
                  'Bộ nhớ AI đang bị tắt. Hãy bật tính năng ở trên để xem và thêm ghi nhớ.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              memoriesState.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.m),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (_, _) => const Text('Không thể tải danh sách ghi nhớ.'),
                data: (memories) => memories.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.m,
                        ),
                        child: Text(
                          'Chưa có thông tin ghi nhớ nào. Bạn có thể thêm các sở thích, mục tiêu học tập (ví dụ: "Thích học bằng mindmap", "Đang ôn thi chứng chỉ...").',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          for (final m in memories)
                            _MemoryTile(
                              key: ValueKey('memory-${m.id}'),
                              memory: m,
                              onToggle: (disabled) => ref
                                  .read(aiMemoriesControllerProvider.notifier)
                                  .toggleMemory(
                                    memoryId: m.id!,
                                    disabled: disabled,
                                  ),
                              onDelete: () => ref
                                  .read(aiMemoriesControllerProvider.notifier)
                                  .deleteMemory(m.id!),
                            ),
                        ],
                      ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddMemoryDialog(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Thêm ghi nhớ cho AI'),
        content: TextField(
          key: const Key('add-memory-input'),
          controller: textController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Ví dụ: Tôi thích học giải thuật qua bài tập thực tế',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Hủy'),
          ),
          FilledButton(
            key: const Key('add-memory-confirm-button'),
            onPressed: () async {
              final content = textController.text.trim();
              if (content.isEmpty) return;
              try {
                await ref
                    .read(aiMemoriesControllerProvider.notifier)
                    .addMemory(content);
                if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
              } on ServerpodClientException catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Không thể thêm ghi nhớ. Vui lòng thử lại.',
                      ),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }
}

class _MemoryTile extends StatelessWidget {
  const _MemoryTile({
    super.key,
    required this.memory,
    required this.onToggle,
    required this.onDelete,
  });

  final AiUserMemory memory;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = memory.disabledAt != null;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      padding: const EdgeInsets.all(AppSpacing.s),
      decoration: BoxDecoration(
        color: isDisabled
            ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4)
            : theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.m),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memory.content,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    decoration: isDisabled ? TextDecoration.lineThrough : null,
                    color: isDisabled
                        ? theme.colorScheme.onSurfaceVariant
                        : null,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  isDisabled ? 'Đã tạm tắt' : 'Đang kích hoạt',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isDisabled
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: isDisabled ? 'Kích hoạt' : 'Tạm tắt',
            icon: Icon(
              isDisabled
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20,
            ),
            onPressed: () => onToggle(!isDisabled),
          ),
          IconButton(
            tooltip: 'Xóa',
            icon: const Icon(Icons.delete_outline, size: 20),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
