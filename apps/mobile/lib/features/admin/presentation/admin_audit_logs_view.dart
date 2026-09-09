import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/admin_controller.dart';

class AdminAuditLogsView extends ConsumerWidget {
  const AdminAuditLogsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(adminAuditLogsProvider);

    return logsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Lỗi tải nhật ký kiểm toán: $err')),
      data: (page) {
        if (page.logs.isEmpty) {
          return const Center(child: Text('Chưa có bản ghi kiểm toán nào.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: page.logs.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final log = page.logs[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: _actionColor(
                  log.action,
                ).withValues(alpha: 0.15),
                child: Icon(
                  _actionIcon(log.action),
                  color: _actionColor(log.action),
                  size: 20,
                ),
              ),
              title: Text(
                log.action,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                'Tài nguyên: ${log.resourceType} #${log.resourceId}\nThời gian: ${log.createdAt.toLocal().toString().split('.').first}',
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.info_outline, size: 20),
                onPressed: () =>
                    _showMetadataDialog(context, log.action, log.metadataJson),
              ),
            );
          },
        );
      },
    );
  }

  Color _actionColor(String action) {
    if (action.contains('DISABLE') || action.contains('ARCHIVE')) {
      return Colors.red;
    }
    if (action.contains('CREATE') ||
        action.contains('ACTIVATE') ||
        action.contains('UPLOAD')) {
      return Colors.green;
    }
    return Colors.blue;
  }

  IconData _actionIcon(String action) {
    if (action.contains('STUDENT')) return Icons.school;
    if (action.contains('BOOK')) return Icons.menu_book;
    if (action.contains('ANNOUNCEMENT')) return Icons.campaign;
    return Icons.security;
  }

  void _showMetadataDialog(
    BuildContext context,
    String action,
    String metadataJson,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Chi tiết: $action'),
        content: SingleChildScrollView(child: SelectableText(metadataJson)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}
