import '../repositories/employee_detail_repository.dart';

class UploadRegisterImageUseCase {
  final EmployeeDetailRepository repo;
  UploadRegisterImageUseCase(this.repo);

  Future<String> call({required int id, required String filePath}) {
    return repo.uploadRegisterImage(id: id, filePath: filePath);
  }
}
