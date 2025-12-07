import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = FlutterSecureStorage();
  static const _keyToken = 'access_token';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  Future<bool> isAuthenticated() async {
    // Lấy token từ Secure Storage
    final token = await _storage.read(key: _keyToken);

    // Nếu token tồn tại và không rỗng → đã xác thực
    return token != null && token.isNotEmpty;
  }
}
