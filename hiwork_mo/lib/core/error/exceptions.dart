class ServerException implements Exception {
  final String? message;

  const ServerException({this.message, required int statusCode});

  @override
  String toString() => 'ServerException: ${message ?? 'Lỗi máy chủ không xác định'}';
}

// Ngoại lệ khi không tìm thấy dữ liệu (ví dụ: 404)
class NotFoundException implements Exception {
  final String? message;

  const NotFoundException({this.message});

  @override
  String toString() => 'NotFoundException: ${message ?? 'Không tìm thấy dữ liệu'}';
}

// Ngoại lệ liên quan đến xác thực (ví dụ: Token hết hạn, 401)
class AuthException implements Exception {
  final String message;

  const AuthException({required this.message});

  @override
  String toString() => 'AuthException: $message';
}

// Ngoại lệ xảy ra khi thiết bị không có kết nối mạng
class NoInternetException implements Exception {
  const NoInternetException();

  @override
  String toString() => 'NoInternetException: Thiết bị không có kết nối mạng';
}

// Ngoại lệ xảy ra khi Cache bị lỗi hoặc không có dữ liệu
class CacheException implements Exception {}