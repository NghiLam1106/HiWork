import 'package:hiwork_mo/data/local/employee_detail_storage.dart';
import 'package:hiwork_mo/data/models/employee_detail_model.dart';

import '../entities/employee_detail_entity.dart';

abstract class EmployeeDetailRepository {
  Future<EmployeeDetailEntity> getEmployeeBy();

  Future<void> updatePersonalInfo({
    int? id,
    String? name,
    String? address,
    int? gender, // 0/1/2
    DateTime? dob,
    String? imageCheckUrl,
    String? phone,
  });

  Future<String> uploadRegisterImage({
    required int id,
    required String filePath,
  });
}
