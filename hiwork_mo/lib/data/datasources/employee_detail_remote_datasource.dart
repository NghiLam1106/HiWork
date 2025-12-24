import '../models/employee_detail_model.dart';

abstract class EmployeeDetailRemoteDataSource {
  Future<EmployeeDetailModel> getEmployeeBy();

  Future<void> updatePersonalInfo({
    int? id,
    String? name,
    String? address,
    int? gender,
    DateTime? dob,
    String? imageCheckUrl,
    String? phone,
  });

  Future<String> uploadRegisterImage({
    required int id,
    required String filePath,
  });
}
