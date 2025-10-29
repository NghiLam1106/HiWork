import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/widgets/menu_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                // Hành động khi click Container
                print('Container được bấm!');
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
            AppPadding.h10,
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
        ),
      ),
    );
  }
}
