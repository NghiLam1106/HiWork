import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_state.dart';
import 'package:hiwork_mo/presentation/pages/home/home_page.dart';
import 'package:hiwork_mo/presentation/pages/leave/leave_request_page.dart';
import 'package:hiwork_mo/presentation/pages/login/login_page.dart';
import 'package:hiwork_mo/presentation/pages/profile/profile_page.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // Lấy các arguments (nếu có)
    // final args = settings.arguments;

    switch (settings.name) {
      // --- Auth Flow ---
      case AppRoute.splash:
        // Màn hình SplashPage sẽ là màn hình "Gác cổng"
        // Nó sẽ lắng nghe AuthBloc và điều hướng đến /login hoặc /home
        // return MaterialPageRoute(builder: (_) => const SplashPage());
        
        // **Cách tiếp cận thay thế (Gác cổng ở đây):**
        // Đây là cách để kiểm tra Auth ngay tại Router,
        // nhưng nó yêu cầu bạn phải truyền BLoC state vào.
        // Cách tốt nhất là dùng SplashPage.
        
        // Giả sử SplashPage là màn hình chờ mặc định
        return MaterialPageRoute(builder: (_) => const _TempSplashPage());

      case AppRoute.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      
      // case AppRoute.register:
      //   return MaterialPageRoute(builder: (_) => const RegisterPage());

      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoute.leaveRequest:
        return MaterialPageRoute(builder: (_) => const LeaveRequestPage());
      
      case AppRoute.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
        
      default:
        return _errorRoute();
    }
  }

  // Hàm trả về trang Lỗi
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lỗi')),
        body: const Center(
          child: Text('Trang không tồn tại hoặc đã xảy ra lỗi điều hướng.'),
        ),
      );
    });
  }
}

// --- Màn hình Splash Tạm Thời (ĐỂ KIỂM TRA LOGIC) ---
// (Bạn nên tạo file splash_page.dart riêng)
class _TempSplashPage extends StatelessWidget {
  const _TempSplashPage();

  @override
  Widget build(BuildContext context) {
    // Màn hình này sẽ lắng nghe AuthBloc và điều hướng
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Nếu đã đăng nhập, chuyển đến Home
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.home, (route) => false);
        } else if (state is Unauthenticated || state is AuthError) {
          // Nếu chưa đăng nhập, chuyển đến Login
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.login, (route) => false);
        }
      },
      // Hiển thị vòng xoay trong khi BLoC đang kiểm tra (AuthLoading)
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}