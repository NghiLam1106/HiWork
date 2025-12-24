import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hiwork_mo/core/api/api_client.dart';
import 'package:hiwork_mo/core/dio/dioClient.dart';
import 'package:hiwork_mo/data/local/employee_detail_storage.dart';
import 'package:hiwork_mo/data/uploadToCloudinary/cloudinary_remote_datasource.dart';
import 'employee_detail_remote_datasource.dart';
import '../models/employee_detail_model.dart';

class EmployeeDetailRemoteDataSourceImpl
    implements EmployeeDetailRemoteDataSource {
  final DioClient dio;
  final EmployeeDetailStorage storage;
  // final EmployeeDetailModel employeeDetailModel;
  EmployeeDetailRemoteDataSourceImpl(this.storage, this.dio);
  final cloudinary = CloudinaryRemoteDataSource(Dio());

  @override
  Future<EmployeeDetailModel> getEmployeeBy() async {
    final json = await storage.getEmployeeJson();
    if (json == null) {
      throw Exception("Chưa có dữ liệu employee trong storage");
    }

    return EmployeeDetailModel.fromJson(json);
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
    final dobStr =
        (dob != null)
            ? "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}"
            : null;

    final imageUrl = await cloudinary.uploadFaceImage(imageCheckUrl ?? "");

    final res = await dio.dio.put(
      "${ApiUrl.profileEdit}/$id",
      data: {
        "id": id,
        "name": name,
        "address": address,
        "gender": gender,
        "dob": dobStr,
        "image_check": imageUrl,
        "phone": phone,
      },
    );
    final resData = res.data as Map<String, dynamic>;
    final data =
        (resData["user"] ??
                resData["data"]?["user"]["employee"] ??
                resData["data"])
            as Map<String, dynamic>;
    await storage.saveEmployeeJson(data);
    EmployeeDetailModel.fromJson(data);
  }

  @override
  Future<String> uploadRegisterImage({
    required int id,
    required String filePath,
  }) async {
    // final formData = FormData.fromMap({
    //   "file": await MultipartFile.fromFile(
    //     filePath,
    //     filename: File(filePath).path.split('/').last,
    //   ),
    // });

    // final res = await dioClient.dio.post(
    //   '/employees/$id/upload-image-check',
    //   data: formData,
    // );

    // tuỳ API: ví dụ {data: {url: "..."}}
    return throw UnimplementedError("uploadRegisterImage chưa được implement");
  }
}
