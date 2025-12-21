import '../models/employee_detail_model.dart';

abstract class EmployeeDetailRemoteDataSource {
  Future<EmployeeDetailModel> getEmployeeById(int id);
}
