import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/admin_controller.dart';

class AdminStudentListView extends ConsumerWidget {
  const AdminStudentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync = ref.watch(adminStudentsProvider);
    final statusFilter = ref.watch(adminStudentsStatusProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Tìm theo tên, MSSV, lớp...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (val) {
                    ref
                        .read(adminStudentsQueryProvider.notifier)
                        .setQuery(val.trim().isEmpty ? null : val.trim());
                  },
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String?>(
                initialValue: statusFilter,
                icon: const Icon(Icons.filter_list),
                onSelected: (val) {
                  ref
                      .read(adminStudentsStatusProvider.notifier)
                      .setStatus(val);
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: null, child: Text('Tất cả trạng thái')),
                  PopupMenuItem(value: 'active', child: Text('Đang hoạt động')),
                  PopupMenuItem(value: 'inactive', child: Text('Bị khóa')),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: studentsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Lỗi: $err')),
            data: (page) {
              if (page.students.isEmpty) {
                return const Center(child: Text('Không tìm thấy sinh viên nào.'));
              }
              return ListView.separated(
                itemCount: page.students.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final student = page.students[index];
                  final isActive = student.status == 'active';
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isActive ? Colors.green.shade100 : Colors.red.shade100,
                      child: Icon(
                        isActive ? Icons.person : Icons.person_off,
                        color: isActive ? Colors.green.shade800 : Colors.red.shade800,
                      ),
                    ),
                    title: Text('${student.fullName ?? 'Chưa đặt tên'} (${student.studentCode ?? 'N/A'})'),
                    subtitle: Text('Lớp: ${student.className ?? 'N/A'} • Khoa: ${student.faculty ?? 'N/A'}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Chip(
                          label: Text(
                            isActive ? 'Hoạt động' : 'Đã khóa',
                            style: TextStyle(
                              fontSize: 12,
                              color: isActive ? Colors.green.shade900 : Colors.red.shade900,
                            ),
                          ),
                          backgroundColor: isActive ? Colors.green.shade50 : Colors.red.shade50,
                        ),
                        IconButton(
                          icon: Icon(
                            isActive ? Icons.block : Icons.check_circle_outline,
                            color: isActive ? Colors.red : Colors.green,
                          ),
                          tooltip: isActive ? 'Khóa tài khoản' : 'Kích hoạt tài khoản',
                          onPressed: () => _confirmToggleStatus(context, ref, student.id, isActive),
                        ),
                      ],
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

  void _confirmToggleStatus(BuildContext context, WidgetRef ref, int profileId, bool currentIsActive) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(currentIsActive ? 'Khóa tài khoản sinh viên?' : 'Mở khóa tài khoản sinh viên?'),
        content: Text(
          currentIsActive
              ? 'Sinh viên sẽ không thể đăng nhập hoặc sử dụng hệ thống ngay lập tức.'
              : 'Sinh viên sẽ có thể tiếp tục sử dụng các dịch vụ sinh viên.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: currentIsActive ? Colors.red : Colors.green,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ref
                  .read(adminMutationsControllerProvider.notifier)
                  .toggleStudentStatus(profileId, currentIsActive);
            },
            child: Text(currentIsActive ? 'Khóa' : 'Kích hoạt'),
          ),
        ],
      ),
    );
  }
}
