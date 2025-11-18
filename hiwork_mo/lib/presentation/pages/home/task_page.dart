import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.taskTitle,
          style: TextStyle(
            color: Color.fromRGBO(22, 98, 179, 1.0),
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.title_20
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF4F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: l10n.workScheduleTitle,
              items: [
                TaskItem(
                  imagePath: AppAssets.calendarr,
                  label: l10n.taskScheduleCommon,
                  onTap: () {
                    // Navigator.pushNamed(context, AppRoute.schedule);
                  },
                ),
                TaskItem(
                  imagePath: AppAssets.editCalendar,
                  label: l10n.taskScheduleRegister,
                  onTap: () {},
                ),
              ],
            ),
            AppPadding.h16,
            _buildSection(
              title: l10n.taskTimeKeepingTitle,
              items: [
                TaskItem(
                  imagePath: AppAssets.addTask,
                  label: l10n.taskAddAndEditAdtendance,
                  onTap: () {},
                ),
                TaskItem(
                  imagePath: AppAssets.device,
                  label: l10n.taskTimeKeepingEquipment,
                  onTap: () {},
                ),
              ],
            ),
            AppPadding.h16,
            _buildSection(
              title: l10n.taskSalaryTitle,
              items: [
                TaskItem(
                  imagePath: AppAssets.salaryAdvance,
                  label: l10n.taskSalaryAdvanceSlip,
                  onTap: () {},
                ),
                TaskItem(
                  imagePath: AppAssets.wallet,
                  label: l10n.taskSalaryIsOnHold,
                  onTap: () {},
                ),
                TaskItem(
                  imagePath: AppAssets.trendingUp,
                  label: l10n.taskAutomaticSalary,
                  onTap: () {},
                ),
                TaskItem(
                  imagePath: AppAssets.history,
                  label: l10n.taskSalaryHistory,
                  onTap: () {},
                ),
                TaskItem(
                  imagePath: AppAssets.receipt,
                  label: l10n.taskSalarySlip,
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
                color: const Color.fromARGB(255, 95, 95, 79),
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.title_16,
              ),
            ),
            AppPadding.h12,
            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
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
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const TaskItem({
    super.key,
    required this.imagePath,
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
          // color: const Color(0xFFF8FAFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 45, fit: BoxFit.contain),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppFontSize.content_12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
