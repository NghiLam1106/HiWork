import '../entities/employee_detail_entity.dart';

abstract class EmployeeDetailRepository {
  Future<EmployeeDetailEntity> getEmployeeById(int id);
}
