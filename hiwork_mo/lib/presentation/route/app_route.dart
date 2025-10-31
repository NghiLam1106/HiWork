import 'package:flutter/material.dart';
import 'package:hiwork_mo/presentation/pages/home/home_page.dart';
import 'package:hiwork_mo/presentation/pages/login/login_page.dart';
import 'package:hiwork_mo/presentation/pages/register/register_page.dart';
import 'package:hiwork_mo/presentation/pages/splash/splash_page.dart';
import 'package:hiwork_mo/presentation/pages/task/task_page.dart';
import 'package:hiwork_mo/presentation/pages/welcome/welcome_page.dart';

class AppRoute {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String task = '/task';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case task:
        return MaterialPageRoute(builder: (_) => const TaskPage());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("404 - Page Not Found"),
            ),
          ),
        );
    }
  }
}
