import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hiwork_mo/core/api/api_client.dart';
import 'package:hiwork_mo/core/error/exceptions.dart'; // Từ Bước 1
import 'package:hiwork_mo/data/local/employee_storage.dart';
import 'package:hiwork_mo/data/local/token_storage.dart';
import 'package:hiwork_mo/data/models/user_model.dart'; // Từ file trên

final Dio _dio = Dio();

// Interface cho DataSource
abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<void> register({required String username, required String email, required String password, required String role});
  Future<void> signOut();
  Future<bool> isAuthenticated();
}

// Triển khai DataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    // await Future.delayed(const Duration(milliseconds: 700)); // Giả lập độ trễ mạng

    final response = await _dio.post(
      "${ApiUrl.auth}/login",
      data: {'email': email, 'password': password},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = response.data["user"]["firebaseToken"];
      final employeeId = response.data["user"]["employee"]["id"];
      await TokenStorage().saveToken(token);
      await EmployeeStorage().saveEmployeeId(employeeId);
      return UserModel.fromJson(response.data["user"]["user"]);
    } else if (response.statusCode == 401) {
      throw const AuthException(message: 'Sai email hoặc mật khẩu.');
    } else {
      throw const ServerException(
        message: 'Lỗi máy chủ. Vui lòng thử lại sau.',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await _dio.post(
      "${ApiUrl.auth}/register",
      data: {'username': username, 'email': email, 'password': password, 'role': role},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Future.value();
    } else {
      throw const ServerException(
        message: 'Lỗi máy chủ. Vui lòng thử lại sau.',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> signOut() async {
    await TokenStorage().deleteToken();
    return Future.value();
  }

  @override
  Future<bool> isAuthenticated() async {
    return Future.value(await TokenStorage().isAuthenticated());
  }

  Future fetchEmployeeIdByUserId(userId) async {
    final response = await _dio.get(
      "${ApiUrl.employees}/by_user/$userId",
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final employeeData = response.data["data"];
      return employeeData["id"];
    } else {
      throw const ServerException(
        message: 'Lỗi máy chủ. Vui lòng thử lại sau.',
        statusCode: 500,
      );
    }
  }
}
