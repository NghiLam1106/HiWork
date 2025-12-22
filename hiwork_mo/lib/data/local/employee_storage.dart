import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EmployeeStorage {
  final _storage = FlutterSecureStorage();
  static const String _keyEmployeeId = 'employee_id';

  Future<void> saveEmployeeId(int employeeId) async {
    await _storage.write(key: _keyEmployeeId, value: employeeId.toString());
  }

  Future<int?> getEmployeeId() async {
    final v = await _storage.read(key: _keyEmployeeId);
    if (v == null || v.isEmpty) return null;
    return int.tryParse(v);
  }

  Future<void> deleteEmployeeId() async {
    await _storage.delete(key: _keyEmployeeId);
  }
}
