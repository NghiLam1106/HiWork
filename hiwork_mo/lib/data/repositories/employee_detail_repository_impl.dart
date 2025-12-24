import '../../domain/entities/employee_detail_entity.dart';
import '../../domain/repositories/employee_detail_repository.dart';
import '../datasources/employee_detail_remote_datasource.dart';
import '../models/employee_detail_model.dart';

class EmployeeDetailRepositoryImpl implements EmployeeDetailRepository {
  final EmployeeDetailRemoteDataSource remote;

  EmployeeDetailRepositoryImpl({required this.remote});

  @override
  Future<EmployeeDetailEntity> getEmployeeBy() async {
    final EmployeeDetailModel model = await remote.getEmployeeBy();
    // model extends EmployeeDetailEntity => trả về Entity OK
    return model;
  }

  @override
  Future<void> updatePersonalInfo({
    int? id,
    String? name,
    String? address,
    int? gender,
    DateTime? dob,
    String? imageCheckUrl,
    String? phone,
  }) async {
    await remote.updatePersonalInfo(
      id: id,
      name: name,
      address: address,
      gender: gender,
      dob: dob,
      imageCheckUrl: imageCheckUrl,
      phone: phone,
    );
  }

  @override
  Future<String> uploadRegisterImage({
    required int id,
    required String filePath,
  }) async {
    final url = await remote.uploadRegisterImage(id: id, filePath: filePath);
    return url;
  }
}
