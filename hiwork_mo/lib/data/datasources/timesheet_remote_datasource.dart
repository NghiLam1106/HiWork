import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/data/models/daily_timesheet_model.dart';

abstract class TimesheetRemoteDataSource {
  Future<List<DailyTimesheetModel>> getWeeklyTimesheet(DateTime weekStartDate);
}

class TimesheetRemoteDataSourceImpl implements TimesheetRemoteDataSource {
  // final http.Client client;
  // TimesheetRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DailyTimesheetModel>> getWeeklyTimesheet(DateTime weekStartDate) async {
    // --- BẮT ĐẦU MÔ PHỎNG GỌI API ---
    await Future.delayed(const Duration(milliseconds: 900)); // Giả lập độ trễ mạng

    // Giả lập dữ liệu JSON trả về từ API (Dựa trên UI: image_7b71e1.png)
    final List<Map<String, dynamic>> jsonResponse = [
      // Ngày 1: Thứ 2 (Nghỉ)
      {
        'date': '2025-11-03T00:00:00Z',
        'shifts': [] // Ngày nghỉ là ngày không có ca
      },
      // Ngày 2: Thứ 3
      {
        'date': '2025-11-04T00:00:00Z',
        'shifts': [
          {'id': 's1', 'shift_name': 'Ca sáng', 'status': 'on_time', 'check_in': '06:59', 'check_out': '12:00'},
          {'id': 's2', 'shift_name': 'Ca trưa', 'status': 'on_time', 'check_in': '12:59', 'check_out': '17:30'}
        ]
      },
      // Ngày 3: Thứ 4
      {
        'date': '2025-11-05T00:00:00Z',
        'shifts': [
          {'id': 's3', 'shift_name': 'Ca trưa', 'status': 'on_time', 'check_in': '13:00', 'check_out': '17:31'},
          {'id': 's4', 'shift_name': 'Ca tối', 'status': 'early_leave', 'check_in': '17:30', 'check_out': '23:00'}
        ]
      },
      // Ngày 4: Thứ 5
      {
        'date': '2025-11-06T00:00:00Z',
        'shifts': [
          {'id': 's5', 'shift_name': 'Ca tối', 'status': 'forgot_clock_in', 'check_in': null, 'check_out': '23:30'}
        ]
      },
      // Ngày 5: Thứ 6 (Hôm nay)
      {
        'date': '2025-11-07T00:00:00Z',
        'shifts': [
          {'id': 's6', 'shift_name': 'Ca tối', 'status': 'on_time', 'check_in': '17:29', 'check_out': '23:31'}
        ]
      },
      // Ngày 6: Thứ 7 (Nghỉ)
      {
        'date': '2025-11-08T00:00:00Z',
        'shifts': []
      },
      // Ngày 7: Chủ Nhật
      {
        'date': '2025-11-09T00:00:00Z',
        'shifts': [
          {'id': 's7', 'shift_name': 'Ca tối', 'status': 'not_yet', 'check_in': null, 'check_out': null}
        ]
      }
    ];
    // --- KẾT THÚC MÔ PHỎNG ---

    // Chuyển đổi JSON thành List<DailyTimesheetModel>
    try {
      return jsonResponse
          .map((item) => DailyTimesheetModel.fromJson(item))
          .toList();
    } on Exception {
      // Nếu API trả về dữ liệu sai cấu trúc
      throw const ServerException(message: 'Lỗi xử lý dữ liệu chấm công.', statusCode:  500);
    }
  }
}