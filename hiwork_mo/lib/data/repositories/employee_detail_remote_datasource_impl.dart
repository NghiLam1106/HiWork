import 'package:dio/dio.dart';
import 'package:hiwork_mo/data/models/employee_detail_model.dart';
import '../datasources/employee_detail_remote_datasource.dart';
class EmployeeDetailRemoteDataSourceImpl
    implements EmployeeDetailRemoteDataSource {
  final Dio dio;

  EmployeeDetailRemoteDataSourceImpl(this.dio);

  @override
  Future<EmployeeDetailModel> getEmployeeById(int id) async {
    final response = await dio.get('/employees/$id');

    return EmployeeDetailModel.fromJson(response.data['data']);
  }
}
