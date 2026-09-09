import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/admin_controller.dart';
import 'admin_announcements_view.dart';
import 'admin_audit_logs_view.dart';
import 'admin_book_management_view.dart';
import 'admin_student_list_view.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(adminStatsProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bảng điều khiển Quản trị'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.people_outline), text: 'Sinh viên'),
              Tab(icon: Icon(Icons.library_books_outlined), text: 'Thư viện'),
              Tab(icon: Icon(Icons.campaign_outlined), text: 'Thông báo'),
              Tab(icon: Icon(Icons.history_edu_outlined), text: 'Nhật ký kiểm toán'),
            ],
          ),
        ),
        body: Column(
          children: [
            // Top Aggregates Summary
            statsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (err, _) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Lỗi tải số liệu: $err', style: const TextStyle(color: Colors.red)),
              ),
              data: (stats) => _DashboardMetricsHeader(stats: stats),
            ),
            const Divider(height: 1),
            // Tab Views
            const Expanded(
              child: TabBarView(
                children: [
                  AdminStudentListView(),
                  AdminBookManagementView(),
                  AdminAnnouncementsView(),
                  AdminAuditLogsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardMetricsHeader extends StatelessWidget {
  const _DashboardMetricsHeader({required this.stats});

  final AdminDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _MetricBadge(
              label: 'Tổng SV',
              value: '${stats.totalStudents}',
              icon: Icons.school,
              color: Colors.indigo,
            ),
            const SizedBox(width: 8),
            _MetricBadge(
              label: 'SV Hoạt động',
              value: '${stats.activeStudents}',
              icon: Icons.check_circle_outline,
              color: Colors.green,
            ),
            const SizedBox(width: 8),
            _MetricBadge(
              label: 'Tổng Sách',
              value: '${stats.totalBooks}',
              icon: Icons.menu_book,
              color: Colors.blue,
            ),
            const SizedBox(width: 8),
            _MetricBadge(
              label: 'Đang mượn',
              value: '${stats.activeLoans}',
              icon: Icons.bookmark_added,
              color: Colors.orange,
            ),
            const SizedBox(width: 8),
            _MetricBadge(
              label: 'AI Hôm nay',
              value: '${stats.aiRequestsToday}',
              icon: Icons.auto_awesome,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
