import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/admin_controller.dart';

class AdminAnnouncementsView extends ConsumerWidget {
  const AdminAnnouncementsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcementsAsync = ref.watch(adminAnnouncementsProvider);

    return Scaffold(
      body: announcementsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Lỗi tải thông báo: $err')),
        data: (page) {
          if (page.announcements.isEmpty) {
            return const Center(child: Text('Chưa có thông báo nào.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: page.announcements.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = page.announcements[index];
              return Card(
                elevation: item.archived ? 0 : 1,
                color: item.archived ? Colors.grey.shade100 : null,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: item.archived
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                          Chip(
                            label: Text(
                              item.archived ? 'Đã lưu trữ' : 'Đang phát hành',
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(item.body),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Đối tượng: ${item.audience.toUpperCase()} • Xuất bản: ${item.publishAt.toLocal().toString().split('.').first}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          if (!item.archived)
                            TextButton.icon(
                              icon: const Icon(
                                Icons.archive_outlined,
                                size: 16,
                              ),
                              label: const Text('Lưu trữ'),
                              onPressed: () {
                                ref
                                    .read(
                                      adminMutationsControllerProvider.notifier,
                                    )
                                    .archiveAnnouncement(item.id!);
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Thêm thông báo'),
        onPressed: () => _createAnnouncementDialog(context, ref),
      ),
    );
  }

  void _createAnnouncementDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    String audience = 'all';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Tạo thông báo mới'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Tiêu đề thông báo',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Nội dung chi tiết',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: audience,
                  decoration: const InputDecoration(
                    labelText: 'Đối tượng người nhận',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'all',
                      child: Text('Tất cả trường'),
                    ),
                    DropdownMenuItem(
                      value: 'student',
                      child: Text('Sinh viên'),
                    ),
                    DropdownMenuItem(
                      value: 'lecturer',
                      child: Text('Giảng viên'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => audience = val);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy'),
            ),
            FilledButton(
              onPressed: () {
                final title = titleController.text.trim();
                final body = bodyController.text.trim();
                if (title.isEmpty || body.isEmpty) return;
                Navigator.pop(ctx);
                ref
                    .read(adminMutationsControllerProvider.notifier)
                    .createAnnouncement(
                      title: title,
                      body: body,
                      audience: audience,
                      publishAt: DateTime.now().toUtc(),
                    );
              },
              child: const Text('Xuất bản'),
            ),
          ],
        ),
      ),
    );
  }
}
