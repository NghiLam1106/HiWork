import 'package:equatable/equatable.dart';

// Lớp cơ sở cho tất cả các loại lỗi
abstract class Failure extends Equatable {
  const Failure();
  @override
  List<Object> get props => [];
}

// Lỗi liên quan đến server (API)
class ServerFailure extends Failure {
  final String message;
  const ServerFailure({this.message = 'Lỗi kết nối hoặc xử lý từ máy chủ.'});
  @override
  List<Object> get props => [message];
}

// Lỗi dữ liệu cục bộ (Cache)
class CacheFailure extends Failure {}

// Lỗi xác thực (Đăng nhập, đăng ký)
class AuthFailure extends Failure {
  final String message;
  const AuthFailure({this.message = 'Tên đăng nhập hoặc mật khẩu không hợp lệ.'});
  @override
  List<Object> get props => [message];
}

// Lỗi yêu cầu (Ví dụ: dữ liệu không hợp lệ)
class InvalidInputFailure extends Failure {
  final String message;
  const InvalidInputFailure({this.message = 'Dữ liệu đầu vào không hợp lệ.'});
  @override
  List<Object> get props => [message];
}