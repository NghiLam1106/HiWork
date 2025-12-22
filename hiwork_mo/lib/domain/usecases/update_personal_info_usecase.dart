import '../repositories/employee_detail_repository.dart';

class UpdatePersonalInfoUseCase {
  final EmployeeDetailRepository repository;
  UpdatePersonalInfoUseCase(this.repository);

  Future<void> call({
    required int id,
    required String name,
    required String address,
    required int gender,
    DateTime? dob,
    String? imageCheckUrl,
  }) {
    return repository.updatePersonalInfo(
      id: id,
      name: name,
      address: address,
      gender: gender,
      dob: dob,
      imageCheckUrl: imageCheckUrl,
    );
  }
}
