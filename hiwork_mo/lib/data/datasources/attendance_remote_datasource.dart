// lib/data/attendance/datasources/attendance_remote_datasource.dart

import '../models/attendance_model.dart';

/// Interface Data Source
abstract class AttendanceRemoteDataSource {
  /// Gửi yêu cầu sửa chấm công
  Future<bool> submitAttendance(AttendanceModel model);

  /// Lấy chi tiết chấm công theo ID
  Future<AttendanceModel> getAttendanceDetail(String id);

  Future<void> submitCorrection(AttendanceModel model) async {}
}

/// Implementation: mock server
abstract class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final List<String> mockBackendErrors = [
    'Shift ID not found for the given date.',
    'Correction request time is invalid (out of shift bounds).',
    'Connection timed out.',
    'Success',
  ];

  @override
  Future<bool> submitAttendance(AttendanceModel model) async {
    await Future.delayed(const Duration(seconds: 1));

    print('--- Gửi Yêu Cầu Sửa Đổi Dữ Liệu Lên Server ---');
    print('Payload: ${model.toJson()}');

    // Validate đơn giản
    if (model.note.toLowerCase().contains('invalid')) {
      throw Exception('Lý do không hợp lệ, vui lòng cung cấp thêm chi tiết.');
    }

    final randomErrorIndex =
        DateTime.now().millisecond % mockBackendErrors.length;
    final mockResponse = mockBackendErrors[randomErrorIndex];

    if (mockResponse == 'Success') {
      print('Server Response: Yêu cầu sửa đổi đã được ghi nhận.');
      return true;
    } else {
      print('Server Response: Lỗi - $mockResponse');
      throw Exception('Server Error: $mockResponse');
    }
  }

  @override
  Future<AttendanceModel> getAttendanceDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));

    print('--- Lấy chi tiết chấm công từ server (mock) --- ID = $id');

    // mock cứng 1 record
    return AttendanceModel(
      id: id,
      employeeId: 'E001',
      workDate: DateTime.now(),
      shiftId: 'S001',
      newCheckIn: DateTime.now().copyWith(hour: 7, minute: 30),
      newCheckOut: DateTime.now().copyWith(hour: 12, minute: 0),
      note: 'Dữ liệu mock',
    );
  }
}
