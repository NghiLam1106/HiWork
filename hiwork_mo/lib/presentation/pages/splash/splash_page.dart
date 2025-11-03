import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiwork_mo/presentation/pages/welcome/welcome_page.dart';

import '/core/constants/app_assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(_createRoute());
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 800,
      ), // thời gian animation
      pageBuilder:
          (context, animation, secondaryAnimation) => const WelcomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Hiệu ứng kết hợp fade + slide
        const begin = Offset(0.0, 0.2); // trượt nhẹ từ dưới lên
        const end = Offset.zero;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

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
    return Scaffold(body: Center(child: Image.asset(AppAssets.logoText)));
  }
}
