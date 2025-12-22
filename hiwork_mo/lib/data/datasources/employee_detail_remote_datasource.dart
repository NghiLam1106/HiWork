import '../models/employee_detail_model.dart';

abstract class EmployeeDetailRemoteDataSource {
  Future<EmployeeDetailModel> getEmployeeById(int id);

  Future<void> updatePersonalInfo({
    required int id,
    required String name,
    required String address,
    required int gender,
    DateTime? dob,
    String? imageCheckUrl,
  });
  
  Future<String> uploadRegisterImage({
    required int id,
    required String filePath,
  });
}
