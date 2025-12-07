import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_event.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_state.dart';
import 'package:hiwork_mo/presentation/widgets/input_field.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(String email, String password) {
    context.read<AuthBloc>().add(
      LogInRequested(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(

      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (Route<dynamic> route) => false,
            );
          }
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
                      fontSize: AppFontSize.title_28,
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
                AppPadding.h70,

                // (InputFields giữ nguyên)
                InputField(
                  controller: _emailController,
                  hintText: l10n.hintTextUsername,
                  icon: Icons.person_outline,
                  obscureText: false,
                ),
                AppPadding.h20,
                InputField(
                  controller: _passwordController,
                  hintText: l10n.hintTextPassword,
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),

                AppPadding.h40,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    // 6. BlocBuilder VẪN GIỮ NGUYÊN
                    // (Nó sẽ không hiển thị Loading vì BLoC không được gọi)
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          // (Phần Loading này sẽ không chạy vì BLoC bị bỏ qua)
                          return ElevatedButton(
                            onPressed: null,
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

                        // Nút Đăng nhập (Sẽ gọi hàm _onLoginPressed đã sửa)
                        return ElevatedButton(
                          onPressed: () => _onLoginPressed(_emailController.text, _passwordController.text),
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

                AppPadding.h70,

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
                      fontSize: AppFontSize.content_18,
                      color: AppColors.textBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppPadding.h20,
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: AppFontSize.content_18,
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
      ),
    );
  }
}
