import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/pages/task/task_page.dart';
import 'package:hiwork_mo/presentation/widgets/menu_card.dart';

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
    const Center(child: Text('🔔 Thông báo', style: TextStyle(fontSize: 22))),
    const Center(child: Text('👤 Tài khoản', style: TextStyle(fontSize: 22))),
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
                iconSize: 30,
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
    double iconSize = 30,
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
              color:
                  isActive
                      ? Colors.blueAccent.withOpacity(0.1)
                      : Colors.transparent,
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
              fontSize: AppFontSize.content_12,
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
          onTap: () {
            Navigator.pushNamed(context, '/nextPage'); // ví dụ điều hướng
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.secondaryBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset(AppAssets.faceCheck, height: 80),
                Text(
                  l10n.titleScan,
                  style: TextStyle(
                    fontSize: AppFontSize.title_24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                // AppPadding.h10,
                Text(
                  '${l10n.titleScanHello}, Huong Vo!',
                  style: TextStyle(
                    fontSize: AppFontSize.content_16,
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
                // subtitle: l10n.menuJobsSubtitle,
                onTap: () {
                  // Xử lý khi nhấn vào Menu Jobs
                },
              ),
              MenuCard(
                icon: AppAssets.travel,
                title: l10n.titleCardJob,
                // subtitle: l10n.menuJobsSubtitle,
                onTap: () {
                  // Xử lý khi nhấn vào Menu Jobs
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
                title: l10n.titleCardJob,
                // subtitle: l10n.menuJobsSubtitle,
                onTap: () {
                  // Xử lý khi nhấn vào Menu Jobs
                },
              ),
              MenuCard(
                icon: AppAssets.chat,
                title: l10n.titleCardJob,
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