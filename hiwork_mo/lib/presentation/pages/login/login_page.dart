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
import 'package:hiwork_mo/presentation/widgets/input_field.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authRepository = AuthRepository();

    return BlocProvider(
      create: (_) => AuthBloc(authRepository, l10n),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isFailure && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
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
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
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
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final bloc = context.read<AuthBloc>();

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

                      // Email
                      InputField(
                        hintText: l10n.hintTextUsername,
                        icon: Icons.person_outline,
                        obscureText: false,
                        onChanged:
                            (value) => bloc.add(LoginEmailChanged(value)),
                      ),
                      AppPadding.h20,

                      // Password
                      InputField(
                        hintText: l10n.hintTextPassword,
                        icon: Icons.lock_outline,
                        obscureText: true,
                        onChanged:
                            (value) => bloc.add(LoginPasswordChanged(value)),
                      ),
                      AppPadding.h50,

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                state.isSubmitting
                                    ? null
                                    : () => bloc.add(const LoginSubmitted()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textBlue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
          },
        ),
      ),
    );
  }
}
