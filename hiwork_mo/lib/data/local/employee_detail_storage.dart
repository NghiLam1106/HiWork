import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EmployeeDetailStorage {
  static const _kEmployeeJson = "employee_json";

  // ✅ cấu hình tuỳ chọn (Android encrypted shared prefs)
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveEmployeeJson(Map<String, dynamic> json) async {
    await _storage.write(
      key: _kEmployeeJson,
      value: jsonEncode(json),
    );
  }

  Future<Map<String, dynamic>?> getEmployeeJson() async {
    final str = await _storage.read(key: _kEmployeeJson);
    if (str == null || str.trim().isEmpty) return null;

    final decoded = jsonDecode(str);
    if (decoded is Map<String, dynamic>) return decoded;

    // phòng trường hợp decode ra Map<dynamic, dynamic>
    return Map<String, dynamic>.from(decoded as Map);
  }

  Future<void> clearEmployee() async {
    await _storage.delete(key: _kEmployeeJson);
  }
}
