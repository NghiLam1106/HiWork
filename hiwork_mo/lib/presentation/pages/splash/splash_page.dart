import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_event.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_state.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart';
import '/core/constants/app_assets.dart';
import 'package:hiwork_mo/presentation/pages/welcome/welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Kích hoạt event kiểm tra trạng thái đăng nhập
    context.read<AuthBloc>().add(AppStarted());
  }

  void _navigateTo(String route) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) {
          if (route == AppRoute.welcome) return const WelcomePage();
          return Container(); // Home route sẽ do Navigator.pushReplacementNamed xử lý
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.2);
          const end = Offset.zero;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOutCubic));
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: animation.drive(tween), child: child),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          // Chờ 2s để giữ animation splash
          await Future.delayed(const Duration(seconds: 2));

          if (!mounted) return;

          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, AppRoute.home);
          } else if (state is Unauthenticated) {
            _navigateTo(AppRoute.welcome);
          }
        },
        child: Center(
          child: Image.asset(AppAssets.logoText),
        ),
      ),
    );
  }
}
