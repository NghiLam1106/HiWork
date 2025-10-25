import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/presentation/widgets/input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.logo, height: 100),
                  Text(
                    'HiWork!',
                    style: TextStyle(
                      fontSize: AppFontSize.title_36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlue,
                    ),
                  ),
                ],
              ),
              AppPadding.h40,
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: AppFontSize.title_22,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: l10n.titleLogin,
                      style: TextStyle(color: AppColors.textBlack),
                    ),
                    const TextSpan(
                      text: ' HiWork!',
                      style: TextStyle(color: AppColors.textBlue),
                    ),
                  ],
                ),
              ),
              AppPadding.h40,

              // Tên đăng nhập hoặc Email
              InputField(
                hintText: l10n.hintTextUsername,
                icon: Icons.person_outline,
                obscureText: false,
              ),
              AppPadding.h20,

              // Mật khẩu
              InputField(
                hintText: l10n.hintTextPassword,
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              AppPadding.h50,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: xử lý đăng nhập
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      l10n.loginBtn,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              AppPadding.h50,
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  overlayColor: Colors.transparent,
                ),
                child: Text(
                  l10n.forgotPasword,
                  style: TextStyle(
                    fontSize: AppFontSize.content_16,
                    color: AppColors.textBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              AppPadding.h20,

              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: AppFontSize.content_16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: l10n.dontHaveAccount),
                    TextSpan(
                      text: l10n.registerNow,
                      style: const TextStyle(
                        color: AppColors.textBlue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/register');
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
