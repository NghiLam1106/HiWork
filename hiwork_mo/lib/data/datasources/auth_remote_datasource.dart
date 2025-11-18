import 'package:hiwork_mo/core/error/exceptions.dart'; // Từ Bước 1
import 'package:hiwork_mo/data/models/user_model.dart'; // Từ file trên

const String BASE_URL = 'https://api.hiwork.com/v1/auth/';

// Interface cho DataSource
abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<void> signOut();
  Future<bool> isAuthenticated();
}

// Triển khai DataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  String? _cachedToken; // Giả lập cache token

  @override
  Future<UserModel> signIn({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 700)); // Giả lập độ trễ mạng

   
    if (email == 'test@hiwork.com' && password == '123456') { // Giả lập đăng nhập thành công
      final jsonResponse = {
        'id': 'user-001',
        'full_name': 'Lâm Nghi',
        'email': email,
        'department': 'Kế toán',
        'position': 'Nhân viên',
        'token': 'super_secure_jwt_token_12345',
      };
      _cachedToken = jsonResponse['token'] as String;
      return UserModel.fromJson(jsonResponse);
    } else {
      throw const AuthException(message: 'Tên đăng nhập hoặc mật khẩu không chính xác.');
    }
  }

  @override
  Future<void> signOut() async {
    _cachedToken = null;
    await Future.delayed(const Duration(milliseconds: 300));
    return Future.value();
  }

  @override
  Future<bool> isAuthenticated() async {
    return Future.value(_cachedToken != null && _cachedToken!.isNotEmpty);
  }
}