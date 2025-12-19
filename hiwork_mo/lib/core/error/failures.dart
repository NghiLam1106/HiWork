import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

// Lỗi liên quan đến server (API)
class ServerFailure extends Failure {
  const ServerFailure({String message = 'Lỗi kết nối hoặc xử lý từ máy chủ.'})
      : super(message: message);
}

// Lỗi dữ liệu cục bộ (Cache)
class CacheFailure extends Failure {
  const CacheFailure({String message = 'Lỗi dữ liệu cục bộ (Cache).'})
      : super(message: message);
}

// Lỗi xác thực (Đăng nhập, đăng ký)
class AuthFailure extends Failure {
  const AuthFailure({String message = 'Tên đăng nhập hoặc mật khẩu không hợp lệ.'})
      : super(message: message);
}

// Lỗi yêu cầu (Ví dụ: dữ liệu không hợp lệ)
class InvalidInputFailure extends Failure {
  const InvalidInputFailure({String message = 'Dữ liệu đầu vào không hợp lệ.'})
      : super(message: message);
}
