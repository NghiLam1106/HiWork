import 'package:dio/dio.dart';
import 'package:hiwork_mo/core/api/api_client.dart';
import 'package:hiwork_mo/core/constants/api_endpoints.dart';
import 'package:hiwork_mo/core/dio/dioClient.dart';
import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/data/models/attendance_scan_model.dart';
import 'package:hiwork_mo/data/models/shift_model.dart';
import 'package:hiwork_mo/data/uploadToCloudinary/cloudinary_remote_datasource.dart';
import 'package:intl/intl.dart';
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

  Future<AttendanceScanModel> checkOut({required int attendanceId});
}

class AttendanceScanRemoteDataSourceImpl
    implements AttendanceScanRemoteDataSource {
  final dio = DioClient();
  AttendanceScanRemoteDataSourceImpl(dio);
  final cloudinary = CloudinaryRemoteDataSource(Dio());

  @override
  Future<List<ShiftAssignmentModel>> getShifts({
    required int idEmployee,
    required DateTime date,
  }) async {
    try {
      final dateStr =
          "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      final res = await dio.dio.get(
        "${ApiUrl.lichLamViec}/list_by_employee",
        queryParameters: {"id_employee": idEmployee, "date": dateStr},
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
      final imageUrl = await cloudinary.uploadFaceImage(imagePath);

      final checkInAt = DateFormat(
        'yyyy-MM-dd HH:mm:ss.SSS',
      ).format(DateTime.now());

      // final form = FormData.fromMap({
      //   "id_EmployeeShift": idShift,
      //   "photoUrl": imageUrl,
      //   "checkIn": checkInAt,
      //   "status": 3,
      // });

      final response = await dio.dio.post(
        "${ApiUrl.attendance}/",
        data: {
          "id_EmployeeShift": idShift,
          "photoUrl": imageUrl,
          "checkIn": checkInAt,
          "status": 3,
        },
      );

      final raw = response.data as Map<String, dynamic>;
      final data = (raw["data"] ?? raw) as Map<String, dynamic>;

      return AttendanceScanModel.fromJson(
        data,
      );
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
  Future<AttendanceScanModel> checkOut({required int attendanceId}) async {
    try {
      String _formatNow() {
        final now = DateTime.now();
        String two(int n) => n.toString().padLeft(2, '0');

        return "${now.year}-${two(now.month)}-${two(now.day)} "
            "${two(now.hour)}:${two(now.minute)}:${two(now.second)}.000";
      }

      final checkOutAt = _formatNow();

      final response = await dio.dio.put(
        "${ApiUrl.attendance}/$attendanceId",
        data: {"checkOut": checkOutAt},
      );

      final raw = response.data as Map<String, dynamic>;
      final data = (raw["data"] ?? raw) as Map<String, dynamic>;

      return AttendanceScanModel.fromJson(
        data,
      );
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?.toString() ?? e.message ?? "Server error",
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
