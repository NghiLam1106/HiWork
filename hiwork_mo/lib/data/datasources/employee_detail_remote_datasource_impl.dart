import 'dart:io';
import 'package:dio/dio.dart';
import 'employee_detail_remote_datasource.dart';
import '../models/employee_detail_model.dart';

class EmployeeDetailRemoteDataSourceImpl implements EmployeeDetailRemoteDataSource {
  final Dio dio;

  EmployeeDetailRemoteDataSourceImpl(this.dio);

  @override
  Future<EmployeeDetailModel> getEmployeeById(int id) async {
    final res = await dio.get('/employees/$id');

    // tuỳ API của bạn: thường là res.data['data']
    final data = res.data['data'] ?? res.data;
    return EmployeeDetailModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<void> updatePersonalInfo({
    required int id,
    required String name,
    required String address,
    required int gender,
    DateTime? dob,
    String? imageCheckUrl,
  }) async {
    await dio.put(
      '/employees/$id',
      data: {
        "name": name,
        "address": address,
        "gender": gender,
        "dob": dob?.toIso8601String(),
        "image_check": imageCheckUrl,
      },
    );
  }

  @override
  Future<String> uploadRegisterImage({
    required int id,
    required String filePath,
  }) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        filename: File(filePath).path.split('/').last,
      ),
    });

    final res = await dio.post(
      '/employees/$id/upload-image-check',
      data: formData,
    );

    // tuỳ API: ví dụ {data: {url: "..."}}
    return res.data['data']['url'] as String;
  }
}
