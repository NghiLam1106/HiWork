import 'package:hiwork_mo/data/local/employee_detail_storage.dart';
import 'package:hiwork_mo/data/models/employee_detail_model.dart';
import 'package:hiwork_mo/domain/entities/employee_detail_entity.dart';

import '../repositories/employee_detail_repository.dart';

class UpdatePersonalInfoUseCase {
  final EmployeeDetailRepository repository;
  UpdatePersonalInfoUseCase(this.repository);

  Future<void> call({
     int? id,
     String? name,
     String? address,
     int? gender,
    DateTime? dob,
    String? imageCheckUrl,
    String? phone,
  }) {
    return repository.updatePersonalInfo(
      id: id,
      name: name,
      address: address,
      gender: gender,
      dob: dob,
      imageCheckUrl: imageCheckUrl,
      phone: phone,
    );
  }
}
