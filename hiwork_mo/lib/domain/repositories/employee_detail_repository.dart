import '../entities/employee_detail_entity.dart';

abstract class EmployeeDetailRepository {
  Future<EmployeeDetailEntity> getEmployeeById(int id);

  Future<void> updatePersonalInfo({
    required int id,
    required String name,
    required String address,
    required int gender, // 0/1/2
    DateTime? dob,
    String? imageCheckUrl,
  });

   Future<String> uploadRegisterImage({
    required int id,
    required String filePath,
  });
}
