import 'package:hiwork_mo/domain/entities/payroll_summary_entity.dart';

// 1. Model cho TỔNG HỢP (kế thừa Entity)
class PayrollSummaryModel extends PayrollSummaryEntity {
  const PayrollSummaryModel({
    required super.totalSalary,
    required super.advancePaid,
    required super.netSalary,
  });

  // Hàm factory: Chuyển đổi JSON (từ API) thành Model
  factory PayrollSummaryModel.fromJson(Map<String, dynamic> json) {
    return PayrollSummaryModel(
      // Chuyển đổi 'num' (có thể là int hoặc double) sang 'double'
      totalSalary: (json['total_salary'] as num).toDouble(),
      advancePaid: (json['advance_paid'] as num).toDouble(),
      netSalary: (json['net_salary'] as num).toDouble(),
    );
  }
}