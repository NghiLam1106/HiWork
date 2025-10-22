import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';

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
              _buildInputField(
                icon: Icons.person_outline,
                hintText: l10n.hintTextFullname,
              ),

              AppPadding.h20,

              // Email
              _buildInputField(icon: Icons.email_outlined, hintText: l10n.hintTextEmail),

              AppPadding.h20,

              // Mật khẩu
              _buildInputField(
                icon: Icons.lock_outline,
                hintText: l10n.hintTextPassword,
                obscureText: true,
              ),

              AppPadding.h20,

              _buildInputField(
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

  // Widget con dùng chung cho các TextField
  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(icon, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFFBFD7ED)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF007BFF), width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
