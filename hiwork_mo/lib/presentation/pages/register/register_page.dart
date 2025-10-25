import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/presentation/widgets/input_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                      text: l10n.titleRegister,
                      style: const TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: ' HiWork!',
                      style: TextStyle(color: AppColors.textBlue),
                    ),
                  ],
                ),
              ),

              AppPadding.h40,

              // Họ và tên
              InputField(
                icon: Icons.person_outline,
                hintText: l10n.hintTextFullname,
              ),

              AppPadding.h20,

              // Email
              InputField(icon: Icons.email_outlined, hintText: l10n.hintTextEmail),

              AppPadding.h20,

              // Mật khẩu
              InputField(
                icon: Icons.lock_outline,
                hintText: l10n.hintTextPassword,
                obscureText: true,
              ),

              AppPadding.h20,

              InputField(
                icon: Icons.lock_outline,
                hintText: l10n.hintTextConfirmPassword,
                obscureText: true,
              ),

              AppPadding.h40,

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Xử lý đăng ký
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      l10n.registerBtn,
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

              AppPadding.h20,

              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: AppFontSize.content_16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: l10n.haveAcconunt),
                    TextSpan(
                      text: l10n.loginNow,
                      style: const TextStyle(
                        color: AppColors.textBlue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/login');
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
