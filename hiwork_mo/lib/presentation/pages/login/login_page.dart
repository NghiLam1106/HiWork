import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      // appBar: AppBar(backgroundColor: AppColors.backgroundColor),
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
                      style: TextStyle(
                        color: AppColors.textBlack,
                      ),
                    ),
                    const TextSpan(
                      text: ' HiWork!',
                      style: TextStyle(
                        color: AppColors.textBlue,
                      ),
                    ),
                  ],
                ),
              ),
              AppPadding.h40,
              Container(
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
                  decoration: InputDecoration(
                    hintText: l10n.hintTextUsername,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFFBFD7ED),
                      ), // viền xanh nhạt
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF007BFF),
                        width: 1.5,
                      ), // viền xanh khi focus
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              AppPadding.h20,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
                  obscureText: true, // 👈 Ẩn ký tự khi nhập mật khẩu
                  decoration: InputDecoration(
                    hintText: l10n.hintTextPassword,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline, // 👈 Icon ổ khóa
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFFBFD7ED), // viền xanh nhạt
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF007BFF), // viền xanh khi focus
                        width: 1.5,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              AppPadding.h50,
              AppPadding.h20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity, // chiếm toàn chiều ngang
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: xử lý sự kiện đăng nhập ở đây
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textBlue, // màu xanh đậm
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // 👈 bo tròn đều 4 góc
                      ),
                    ),
                    child: Text(
                      l10n.loginBtn,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2, // giãn nhẹ chữ như hình
                      ),
                    ),
                  ),
                ),
              ),

              AppPadding.h50,
              AppPadding.h40,

              TextButton(
                onPressed: () {
                  // TODO: xử lý khi bấmy
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // bỏ khoảng trống mặc định
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
                              // ví dụ:
                              // Navigator.pushNamed(context, '/register');
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
