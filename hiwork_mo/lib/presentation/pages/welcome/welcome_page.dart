import 'package:flutter/material.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              AppPadding.h50,
              Image.asset(AppAssets.peopleWorking),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  l10n.welcomeMessage,
                  textAlign: TextAlign.center, // căn giữa nội dung
                  style: const TextStyle(
                    fontSize: AppFontSize.title_20,
                    fontWeight: FontWeight.bold,
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 35),
              //   child: Text(
              //     l10n.welcomeMessage,
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: AppFontSize.title_20,
              //       fontWeight: FontWeight.bold,
              //       color: AppColors.textBlack,

                  ),
                ),
              ),
              AppPadding.h50,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textBlue,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      l10n.loginBtn,
                      style: TextStyle(
                        fontSize: AppFontSize.title_24,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ),
              ),
              AppPadding.h20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.textBlue,
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      l10n.registerBtn,
                      style: TextStyle(
                        fontSize: AppFontSize.title_24,
                        color: AppColors.textBlue,
                      ),
                    ),
                  ),
                ),
              ),
              AppPadding.h100,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.logo, height: 100),
                  Text(
                    'HiWork!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
