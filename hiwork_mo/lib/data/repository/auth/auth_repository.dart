import 'package:dio/dio.dart';
import 'package:hiwork_mo/core/api/api_client.dart';
import 'package:hiwork_mo/data/local/token_storage.dart';
import '../../model/user_model.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://localhost:3000"));

  Future<bool> register(UserModel user) async {
    final response = await _dio.post(
      "${ApiUrl.auth}/register",
      data: user.toJson(), // gửi JSON
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    final response = await _dio.post(
      "${ApiUrl.auth}/login",
      data: {"email": email, "password": password},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = response.data["user"]["firebaseToken"]; // giả sử server trả về token
      if (token != null) {
        await TokenStorage().saveToken(token);
      }
      return true;
    }
    return false;
  }
}
