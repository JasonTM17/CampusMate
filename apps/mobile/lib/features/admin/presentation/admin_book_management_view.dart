import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/admin_controller.dart';

class AdminBookManagementView extends ConsumerWidget {
  const AdminBookManagementView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(adminBooksProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Tìm tài liệu thư viện...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (val) {
              ref
                  .read(adminBooksQueryProvider.notifier)
                  .setQuery(val.trim().isEmpty ? null : val.trim());
            },
          ),
        ),
        Expanded(
          child: booksAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Lỗi tải danh mục: $err')),
            data: (page) {
              if (page.items.isEmpty) {
                return const Center(child: Text('Không có tài liệu nào.'));
              }
              return ListView.separated(
                itemCount: page.items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final book = page.items[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.menu_book),
                    ),
                    title: Text(book.title),
                    subtitle: Text(
                      'Tác giả: ${book.authors.join(', ')} • Năm: ${book.publishedYear}',
                    ),
                    trailing: ActionChip(
                      label: Text(
                        _accessPolicyLabel(book.accessType),
                        style: const TextStyle(fontSize: 12),
                      ),
                      avatar: const Icon(Icons.policy_outlined, size: 16),
                      onPressed: () => _changePolicyDialog(context, ref, book.id, book.accessType),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String _accessPolicyLabel(BookAccessType type) {
    return switch (type) {
      BookAccessType.publicFullText => 'Công khai',
      BookAccessType.authenticatedFullText => 'Đăng nhập',
      BookAccessType.borrowRequired => 'Cần mượn',
      BookAccessType.metadataOnly => 'Chỉ tra cứu',
      BookAccessType.restricted => 'Hạn chế',
    };
  }

  void _changePolicyDialog(
    BuildContext context,
    WidgetRef ref,
    int bookId,
    BookAccessType currentType,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Thay đổi chính sách truy cập'),
        children: BookAccessType.values.map((type) {
          final isSelected = type == currentType;
          return SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              ref
                  .read(adminMutationsControllerProvider.notifier)
                  .updateBookAccessPolicy(bookId, type);
            },
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? Theme.of(context).colorScheme.primary : null,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(_accessPolicyLabel(type)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
