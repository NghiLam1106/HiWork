import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tác vụ',
          style: TextStyle(
            color: AppColors.textBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF4F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Lịch làm việc',
              items: [
                TaskItem(
                  icon: Icons.calendar_month_outlined,
                  label: 'Lịch làm việc chung',
                  onTap: () {},
                ),
                TaskItem(
                  icon: Icons.edit_calendar_outlined,
                  label: 'Đăng ký lịch làm việc',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Chấm công',
              items: [
                TaskItem(
                  icon: Icons.add_task_outlined,
                  label: 'Bổ sung/ sửa chấm công',
                  onTap: () {},
                ),
                TaskItem(
                  icon: Icons.devices_other_outlined,
                  label: 'Thiết bị chấm công',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Lương',
              items: [
                TaskItem(
                  icon: Icons.request_quote_outlined,
                  label: 'Phiếu tạm ứng lương',
                  onTap: () {},
                ),
                TaskItem(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Lương đang giữ',
                  onTap: () {},
                ),
                TaskItem(
                  icon: Icons.trending_up_outlined,
                  label: 'Tiến trình tự động tăng lương',
                  onTap: () {},
                ),
                TaskItem(
                  icon: Icons.history_outlined,
                  label: 'Lịch sử tự động tăng lương',
                  onTap: () {},
                ),
                TaskItem(
                  icon: Icons.receipt_long_outlined,
                  label: 'Phiếu lương',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<TaskItem> items}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.textBlue,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.title_18,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: items,
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const TaskItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textBlue, size: 40),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppFontSize.content_14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
