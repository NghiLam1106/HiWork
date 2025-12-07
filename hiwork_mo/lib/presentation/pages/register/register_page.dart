import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_event.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_state.dart';
import 'package:hiwork_mo/presentation/widgets/input_field.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_event.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_state.dart';

// 3. Chuyển thành StatefulWidget
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 4. Thêm Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // 5. Hàm xử lý logic khi nhấn nút Đăng ký
  void _onRegisterPressed(BuildContext context) {
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Kiểm tra mật khẩu
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mật khẩu xác nhận không khớp."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // (Thêm các kiểm tra khác nếu cần)

    // Gửi Event đến BLoC
    context.read<AuthBloc>().add(
          RegisterRequested(
            email: email,
            password: password, username: fullName,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      // 6. Thêm BlocListener để lắng nghe trạng thái (Thành công, Lỗi)
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // A. Nếu xác thực thành công (Authenticated) -> Điều hướng đến Home
          if (state is Unauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (Route<dynamic> route) => false,
            );
          }
          // B. Nếu có lỗi (AuthError) -> Hiển thị SnackBar
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 80,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // (Phần Logo và Tiêu đề giữ nguyên)
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
                AppPadding.h30,
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
                AppPadding.h30,

                // 7. Kết nối Controllers với InputFields
                // Họ và tên
                InputField(
                  controller: _fullNameController,
                  icon: Icons.person_outline,
                  hintText: l10n.hintTextFullname,
                ),
                AppPadding.h20,

                // Email
                InputField(
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  hintText: l10n.hintTextEmail,
                ),
                AppPadding.h20,

                // Mật khẩu
                InputField(
                  controller: _passwordController,
                  icon: Icons.lock_outline,
                  hintText: l10n.hintTextPassword,
                  obscureText: true,
                ),
                AppPadding.h20,

                // Xác nhận Mật khẩu
                InputField(
                  controller: _confirmPasswordController,
                  icon: Icons.lock_outline,
                  hintText: l10n.hintTextConfirmPassword,
                  obscureText: true,
                ),
                AppPadding.h40,

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    // 8. Thêm BlocBuilder để quản lý trạng thái Nút
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        // Nếu đang tải (Loading) -> Hiển thị vòng xoay
                        if (state is AuthLoading) {
                          return ElevatedButton(
                            onPressed: null, // Vô hiệu hóa nút
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textBlue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        // Trạng thái bình thường
                        return ElevatedButton(
                          onPressed: () => _onRegisterPressed(context),
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                AppPadding.h40,

                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: AppFontSize.content_18,
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
                        recognizer: TapGestureRecognizer()
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
      ),
    );
  }
}
