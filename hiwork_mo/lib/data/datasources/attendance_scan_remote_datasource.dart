import 'package:dio/dio.dart';
import 'package:hiwork_mo/core/api/api_client.dart';
import 'package:hiwork_mo/core/constants/api_endpoints.dart';
import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/data/models/attendance_scan_model.dart';
import 'package:hiwork_mo/data/models/shift_model.dart';
import '../models/shift_entry_model.dart';

abstract class AttendanceScanRemoteDataSource {
  Future<List<ShiftAssignmentModel>> getShifts({
    required int idEmployee,
    required DateTime date,
  });

  Future<AttendanceScanModel> faceCheckIn({
    required int idEmployee,
    required int idShift,
    required String imagePath,
  });

  Future<AttendanceScanModel> checkOut({
    required int idEmployee,
    required int idShift,
  });
}

class AttendanceScanRemoteDataSourceImpl
    implements AttendanceScanRemoteDataSource {
  final Dio dio;
  AttendanceScanRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ShiftAssignmentModel>> getShifts({
    required int idEmployee,
    required DateTime date,
  }) async {
    try {
      final dateStr =
          "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      final res = await dio.get(
        "${ApiUrl.lichLamViec}/list_by_employee", // ✅ endpoint phân ca
        queryParameters: {
          "id_employee": idEmployee, // nếu BE cần
          "date": dateStr, // lọc theo ngày
        },
      );

      // hỗ trợ 2 kiểu response
      final raw = res.data;
      final list =
          (raw is Map<String, dynamic>)
              ? (raw['data'] as List? ?? [])
              : (raw as List? ?? []);

      return list
          .map((e) => ShiftAssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?.toString() ?? e.message ?? "Server error",
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<AttendanceScanModel> _postFace({
    required String path,
    required int idEmployee,
    required int idShift,
    required String imagePath,
  }) async {
    try {
      final form = FormData.fromMap({
        "id_employee": idEmployee,
        "id_shift": idShift,
        "photo": await MultipartFile.fromFile(imagePath, filename: "face.jpg"),
      });

      final res = await dio.post(path, data: form);
      return AttendanceScanModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?.toString() ?? e.message ?? "Server error",
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<AttendanceScanModel> faceCheckIn({
    required int idEmployee,
    required int idShift,
    required String imagePath,
  }) => _postFace(
    path: ApiEndpoints.faceCheckIn,
    idEmployee: idEmployee,
    idShift: idShift,
    imagePath: imagePath,
  );

  @override
  Future<AttendanceScanModel> checkOut({
    required int idEmployee,
    required int idShift,
  }) async {
    try {
      final res = await dio.post(
        ApiEndpoints.checkOut,
        data: {"id_employee": idEmployee, "id_shift": idShift},
      );
      return AttendanceScanModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?.toString() ?? e.message ?? "Server error",
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
