import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// 1. Sự kiện: Kiểm tra trạng thái ban đầu khi khởi động ứng dụng
class AppStarted extends AuthEvent {}

// 2. Sự kiện: Người dùng yêu cầu Đăng nhập
class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  const LogInRequested({required this.email, required this.password,});

  @override
  List<Object?> get props => [email, password];
}

// 3. Sự kiện: Người dùng yêu cầu Đăng xuất (ĐÃ THÊM)
class LogOutRequested extends AuthEvent {

}

// 4. Sự kiện: Người dùng yêu cầu Đăng ký (ĐÃ THÊM)
class RegisterRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const RegisterRequested({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}
