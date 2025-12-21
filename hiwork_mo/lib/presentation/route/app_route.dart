import 'package:flutter/material.dart';
import 'package:hiwork_mo/presentation/pages/attendance/add_edit_attendance_page.dart';
import 'package:hiwork_mo/presentation/pages/attendance/scan_face_page.dart';
import 'package:hiwork_mo/presentation/pages/home/home_page.dart';
import 'package:hiwork_mo/presentation/pages/leave/leave_request_page.dart';
import 'package:hiwork_mo/presentation/pages/login/login_page.dart';
import 'package:hiwork_mo/presentation/pages/profile/profile_page.dart';
import 'package:hiwork_mo/presentation/pages/register/register_page.dart';
import 'package:hiwork_mo/presentation/pages/schedule/common_work_schedule_page.dart';
import 'package:hiwork_mo/presentation/pages/splash/splash_page.dart';
import 'package:hiwork_mo/presentation/pages/home/task_page.dart';
import 'package:hiwork_mo/presentation/pages/welcome/welcome_page.dart';
import 'package:hiwork_mo/presentation/pages/schedule/register_work_schedule_page.dart';

class AppRoute {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String task = '/task';
  static const String leaveRequest = '/leave_request';

  static const String scanFace = '/scan_face';

  static const String commonWorkSchedule = '/common_work_schedule';

  static const String registerWorkSchedule = '/register_work_schedule';

  static const String addEditAttendance = '/add_edit_attendance';

  static const String profilePage = '/profile_page';

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
      case scanFace:
        return MaterialPageRoute(builder: (_) => const ScanFacePage());
      case leaveRequest:
        return MaterialPageRoute(builder: (_) => const LeaveRequestPage());
      case commonWorkSchedule:
        return MaterialPageRoute(builder: (_) => const CommonWorkSchedulePage());
      case registerWorkSchedule:
        return MaterialPageRoute(builder: (_) => const RegisterWorkSchedulePage());
      case addEditAttendance:
        return MaterialPageRoute(builder: (_) => const AddEditAttendancePage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  Scaffold(body: Center(child: Text("404 - Page Not Found"))),
        );
    }
  }
}
