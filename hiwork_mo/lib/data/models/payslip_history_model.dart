import 'package:hiwork_mo/domain/entities/payslip_history_entity.dart';

// 2. Model cho MỘT HÀNG LỊCH SỬ (kế thừa Entity)
class PayslipHistoryModel extends PayslipHistoryEntity {
  const PayslipHistoryModel({
    required super.id,
    required super.periodName,
    required super.payDate,
    required super.netSalary,
    required super.status,
  });

  // Hàm chuyển đổi String (từ API) sang Enum (trong Entity)
  static PayslipStatus _statusFromString(String? status) {
    switch (status) {
      case 'paid':
        return PayslipStatus.paid;
      case 'pending':
        return PayslipStatus.pending;
      case 'confirmed':
        return PayslipStatus.confirmed;
      case 'failed':
        return PayslipStatus.failed;
      default:
        return PayslipStatus.unknown;
    }
  }

  // Hàm factory: Chuyển đổi JSON (từ API) thành Model
  factory PayslipHistoryModel.fromJson(Map<String, dynamic> json) {
    return PayslipHistoryModel(
      id: json['id'] as String,
      periodName: json['period_name'] as String,
      payDate: DateTime.parse(json['pay_date'] as String),
      netSalary: (json['net_salary'] as num).toDouble(),
      status: _statusFromString(json['status'] as String?),
    );
  }
}