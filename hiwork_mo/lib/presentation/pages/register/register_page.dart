import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/core/constants/app_animation.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/data/repository/auth/auth_repository.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_event.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_state.dart';
import 'package:hiwork_mo/presentation/widgets/input_field.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authRepository = AuthRepository();

    return BlocProvider(
      create: (_) => AuthBloc(authRepository, l10n),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.isFailure && state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state.isSuccess) {
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // không cho tắt khi đang chạy animation
                    builder: (context) {
                      return Center(
                        child: Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white, // nền trắng cho khối animation
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Lottie.asset(
                            AppAnimation.success,
                            repeat: false,
                            onLoaded: (composition) {
                              Future.delayed(composition.duration, () {
                                Navigator.pop(context); // đóng dialog
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                );
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: Column(
                children: [
                  // Logo và tiêu đề
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

                  // --- Form inputs ---
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final bloc = context.read<AuthBloc>();

                      return Column(
                        children: [
                          // Họ và tên
                          InputField(
                            icon: Icons.person_outline,
                            hintText: l10n.hintTextFullname,
                            onChanged:
                                (value) =>
                                    bloc.add(RegisterFullnameChanged(value)),
                          ),

                          AppPadding.h20,

                          // Email
                          InputField(
                            icon: Icons.email_outlined,
                            hintText: l10n.hintTextEmail,
                            onChanged:
                                (value) =>
                                    bloc.add(RegisterEmailChanged(value)),
                          ),

                          AppPadding.h20,

                          // Mật khẩu
                          InputField(
                            icon: Icons.lock_outline,
                            hintText: l10n.hintTextPassword,
                            obscureText: true,
                            onChanged:
                                (value) =>
                                    bloc.add(RegisterPasswordChanged(value)),
                          ),

                          AppPadding.h20,

                          // Xác nhận mật khẩu
                          InputField(
                            icon: Icons.lock_outline,
                            hintText: l10n.hintTextConfirmPassword,
                            obscureText: true,
                            onChanged:
                                (value) => bloc.add(
                                  RegisterConfirmPasswordChanged(value),
                                ),
                          ),

                          AppPadding.h40,

                          // Nút đăng ký
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    state.isSubmitting
                                        ? null
                                        : () =>
                                            bloc.add(const RegisterSubmitted()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.textBlue,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child:
                                    state.isSubmitting
                                        ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : Text(
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

                          // Chuyển sang login
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
                                          Navigator.pushNamed(
                                            context,
                                            '/login',
                                          );
                                        },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
