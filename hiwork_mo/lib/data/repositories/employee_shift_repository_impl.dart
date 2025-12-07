import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/data/datasources/attendance_remote_datasource.dart';
import '../models/attendance_model.dart';
abstract class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {

  final List<String> mockBackendErrors = [
    'Shift ID not found for the given date.',
    'Correction request time is invalid (out of shift bounds).',
    'Connection timed out.',
    'Success',
  ];

  @override
  Future<AttendanceModel> getAttendanceDetail(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock API response
      final mockJson = {
        'id': id,
        'employee_id': 'EMP123',
        'work_date': DateTime.now().toIso8601String().substring(0, 10),
        'shift_id': 'SHIFT1',
        'new_check_in_time': null,
        'new_check_out_time': null,
        'note': '',
        'status': 'approved',
      };

      return AttendanceModel.fromJson(mockJson);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> submitAttendance(AttendanceModel model) async {
    await Future.delayed(const Duration(seconds: 1));
    print('--- Submit API ---');
    print(model.toJson());

    if (model.note.toLowerCase().contains('invalid')) {
      throw Exception('Lý do không hợp lệ');
    }

    final index = DateTime.now().millisecond % mockBackendErrors.length;
    final response = mockBackendErrors[index];

    if (response == 'Success') {
      print('Đã gửi thành công lên server');
      return true;
    } else if (response == 'Success') {
      return true;
    } else {
      throw Exception(response);
    }
  }
}
