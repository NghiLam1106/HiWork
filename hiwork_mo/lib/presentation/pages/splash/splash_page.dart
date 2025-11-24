import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hiwork_mo/presentation/pages/welcome/welcome_page.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart';
import '/core/constants/app_assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    // Chờ splash hiển thị
    await Future.delayed(const Duration(seconds: 2));

    // Kiểm tra FirebaseAuth sau khi Firebase đã được initialize từ main.dart
    User? user;

    try {
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      debugPrint("⚠️ FirebaseAuth chưa initialize hoặc lỗi: $e");
    }

    if (!mounted) return;

    if (user != null) {
      // Đã login → vào Home
      Navigator.pushReplacementNamed(context, AppRoute.home);
    } else {
      // Chưa login → vào Welcome
      Navigator.pushReplacement(
        context,
        _createRoute(),
      );
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const WelcomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.2);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeOutCubic));

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 120), // đổi lại logo của bạn
      ),
    );
  }
}
