import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/data/models/leave_balance_model.dart';
import 'package:hiwork_mo/data/models/leave_request_model.dart';
import 'package:hiwork_mo/domain/entities/leave_request_entity.dart';

// 3. Interface (Hợp đồng) cho DataSource
abstract class LeaveRemoteDataSource {
  Future<List<LeaveRequestModel>> getLeaveHistory();
  Future<List<LeaveBalanceModel>> getLeaveBalances();
  Future<LeaveRequestEntity> submitLeaveRequest({
    required DateTime fromDate,
    required DateTime toDate,
    required String leaveType,
    required String reason,
  });
}

// 4. Triển khai DataSource
class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  // final http.Client client;
  // LeaveRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LeaveRequestModel>> getLeaveHistory() async {
    // --- BẮT ĐẦU MÔ PHỎNG GỌI API ---
    await Future.delayed(const Duration(milliseconds: 500)); 
    final List<Map<String, dynamic>> jsonResponse = [
      {
        'id': 'lr_001',
        'from_date': '2025-10-20T00:00:00Z',
        'to_date': '2025-10-20T00:00:00Z',
        'leave_type': 'Nghỉ phép năm',
        'reason': 'Việc gia đình',
        'status': 'approved',
        'days_requested': 1.0,
      },
      {
        'id': 'lr_002',
        'from_date': '2025-11-10T00:00:00Z',
        'to_date': '2025-11-11T00:00:00Z',
        'leave_type': 'Nghỉ ốm',
        'reason': 'Khám bệnh',
        'status': 'pending',
        'days_requested': 2.0,
      }
    ];
    // --- KẾT THÚC MÔ PHỎNG ---

    try {
      return jsonResponse
          .map((item) => LeaveRequestModel.fromJson(item))
          .toList();
    } on Exception {
      throw const ServerException(message: 'Lỗi xử lý dữ liệu Lịch sử nghỉ.', statusCode: 500);
    }
  }

  @override
  Future<List<LeaveBalanceModel>> getLeaveBalances() async {
    // --- BẮT ĐẦU MÔ PHỎNG GỌI API ---
    await Future.delayed(const Duration(milliseconds: 300));
    final List<Map<String, dynamic>> jsonResponse = [
      {
        'leave_type': 'Nghỉ phép năm',
        'days_remaining': 10.5,
        'days_used': 1.5,
      },
      {
        'leave_type': 'Nghỉ ốm',
        'days_remaining': 5.0,
        'days_used': 0.0,
      }
    ];
    // --- KẾT THÚC MÔ PHỎNG ---
    
    try {
      return jsonResponse
          .map((item) => LeaveBalanceModel.fromJson(item))
          .toList();
    } on Exception {
      throw const ServerException(message: 'Lỗi xử lý dữ liệu Số dư phép.', statusCode: 500);
    }
  }

  @override
  Future<LeaveRequestEntity> submitLeaveRequest({
    required DateTime fromDate,
    required DateTime toDate,
    required String leaveType,
    required String reason,
  }) async {
    // --- BẮT ĐẦU MÔ PHỎNG GỌI API (POST) ---
    await Future.delayed(const Duration(milliseconds: 1200));
    
    // Giả lập lỗi nếu lý do là "error"
    if (reason.toLowerCase() == 'error') {
      throw const ServerException(message: 'Lỗi máy chủ, không thể gửi yêu cầu.', statusCode:  500);
    }
    
    // Giả lập thành công
    return Future.value();
  }
}