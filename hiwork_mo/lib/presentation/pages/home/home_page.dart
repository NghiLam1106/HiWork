import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/pages/attendance/scan_face_page.dart';
import 'package:hiwork_mo/presentation/pages/home/account_page.dart';
import 'package:hiwork_mo/presentation/pages/leave/leave_history_page.dart';
import 'package:hiwork_mo/presentation/pages/home/notification_page.dart';
import 'package:hiwork_mo/presentation/pages/home/task_page.dart';
import 'package:hiwork_mo/presentation/pages/payroll/work_efficiency_page.dart';
import 'package:hiwork_mo/presentation/pages/schedule/work_schedule_page.dart';
import 'package:hiwork_mo/presentation/widgets/menu_card.dart';
import 'package:hiwork_mo/data/local/employee_storage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;


  final List<Widget> _pages = [
    const HomeContent(),
    const TaskPage(),
    const NotificationPage(),
    const AccountPage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                AppAssets.home,
                AppAssets.homeSelect,
                l10n.navHome,
                0,
              ),
              _buildNavItem(
                AppAssets.task,
                AppAssets.taskSelect,
                l10n.navTask,
                1,
                // iconSize: 30,
              ),
              _buildNavItem(
                AppAssets.notification,
                AppAssets.notificationSelect,
                l10n.navNotification,
                2,
              ),
              _buildNavItem(
                AppAssets.account,
                AppAssets.accountSelect,
                l10n.navAccount,
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String icon,
    String activeIcon,
    String label,
    int index, {
    double iconSize = 18,
  }) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color:
              //     isActive
              //         ? Colors.blueAccent.withOpacity(0.1)
              //         : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              isActive ? activeIcon : icon,
              height: iconSize,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: AppFontSize.content_10,
              color: isActive ? AppColors.navBarText : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isCheckedIn = false;
  final EmployeeStorage _storage = EmployeeStorage();


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              AppAssets.peopleWorking,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                'HiWork!',
                style: TextStyle(
                  fontSize: AppFontSize.content_20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlue,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            if (_isCheckedIn) {
              setState(() => _isCheckedIn = false);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Bạn đã check-out thành công")),
              );
              return;
            }

            final employeeId = await EmployeeStorage().getEmployeeId();

            final selectedShift = await Navigator.push<String>(
              context,
              MaterialPageRoute(builder: (_) => ScanFacePage(idEmployee: employeeId ?? 0)),
            );

            if (selectedShift == null) return;

            setState(() => _isCheckedIn = true);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bạn đã check in ca $selectedShift")),
            );

            // if (result == null) return;

            // setState(() {
            //   _isCheckedIn = result;
            // });
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(44, 136, 235, 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset(AppAssets.faceCheck, height: 80),
                Text(
                  _isCheckedIn ? "CHECK-OUT" : "FACE SCAN TO CLOCK IN",
                  style: TextStyle(
                    fontSize: AppFontSize.title_16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                // AppPadding.h10,
                Text(
                  _isCheckedIn
                      ? "Check-out để hoàn thành công việc"
                      : '${l10n.titleScanHello}, Huong Vo!',
                  style: TextStyle(
                    fontSize: AppFontSize.content_12,
                    color: AppColors.textWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuCard(
                icon: AppAssets.calendar,
                title: l10n.titleCardJob,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkSchedulePage(),
                    ),
                  );
                },
              ),
              MenuCard(
                icon: AppAssets.travel,
                title: l10n.titleCardLeave,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LeaveHistoryRegisterPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuCard(
                icon: AppAssets.money,
                title: l10n.titleCardMoney,
                // subtitle: l10n.menuJobsSubtitle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkEfficiencyPage(),
                    ),
                  );
                },
              ),
              MenuCard(
                icon: AppAssets.chat,
                title: l10n.titleCardChat,
                // subtitle: l10n.menuJobsSubtitle,
                onTap: () {
                  // Xử lý khi nhấn vào Menu Jobs
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
