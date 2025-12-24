import '../entities/employee_detail_entity.dart';
import '../repositories/employee_detail_repository.dart';

class GetEmployeeDetailUseCase {
  final EmployeeDetailRepository repository;

  GetEmployeeDetailUseCase(this.repository);

  Future<EmployeeDetailEntity> call() {
    return repository.getEmployeeBy();
  }
}
