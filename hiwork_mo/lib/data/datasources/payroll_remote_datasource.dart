import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/data/models/payroll_summary_model.dart';
import 'package:hiwork_mo/data/models/payslip_history_model.dart';

// 3. Interface (Hợp đồng) cho DataSource
abstract class PayrollRemoteDataSource {
  Future<PayrollSummaryModel> getPayrollSummary(int month, int year);
  Future<List<PayslipHistoryModel>> getPayrollHistory(int year);
}

// 4. Triển khai DataSource
class PayrollRemoteDataSourceImpl implements PayrollRemoteDataSource {
  // final http.Client client;
  // PayrollRemoteDataSourceImpl({required this.client});

  @override
  Future<PayrollSummaryModel> getPayrollSummary(int month, int year) async {
    // --- BẮT ĐẦU MÔ PHỎNG GỌI API (Summary) ---
    await Future.delayed(const Duration(milliseconds: 500)); 

    // Giả lập dữ liệu JSON (dựa trên image_392d02.png)
    final jsonResponse = {
      "total_salary": 12000000.0,
      "advance_paid": 800000.0,
      "net_salary": 11200000.0,
    };
    // --- KẾT THÚC MÔ PHỎNG ---

    try {
      return PayrollSummaryModel.fromJson(jsonResponse);
    } on Exception {
      throw const ServerException(message: 'Lỗi xử lý dữ liệu Tổng hợp Lương.', statusCode:   500);
    }
  }

  @override
  Future<List<PayslipHistoryModel>> getPayrollHistory(int year) async {
    // --- BẮT ĐẦU MÔ PHỎNG GỌI API (History) ---
    await Future.delayed(const Duration(milliseconds: 800));

    // Giả lập dữ liệu JSON (dựa trên image_392d02.png và image_37d6a5.png)
    final List<Map<String, dynamic>> jsonResponse = [
      {
        'id': 'p_001',
        'period_name': 'Phiếu lương 09/2025',
        'pay_date': '2025-09-30T00:00:00Z',
        'net_salary': 1500000.0,
        'status': 'paid', // Đã thanh toán
      },
      {
        'id': 'p_002',
        'period_name': 'Phiếu lương 08/2025',
        'pay_date': '2025-08-31T00:00:00Z',
        'net_salary': 1450000.0,
        'status': 'pending', // Chờ xử lý
      },
      {
        'id': 'p_003',
        'period_name': 'Phiếu lương 07/2025',
        'pay_date': '2025-07-31T00:00:00Z',
        'net_salary': 1510000.0,
        'status': 'confirmed', // Đã xác nhận
      },
    ];
    // --- KẾT THÚC MÔ PHỎNG ---

    try {
      return jsonResponse
          .map((item) => PayslipHistoryModel.fromJson(item))
          .toList();
    } on Exception {
      throw const ServerException(message: 'Lỗi xử lý dữ liệu Lịch sử lương.', statusCode:  500);
    }
  }
}