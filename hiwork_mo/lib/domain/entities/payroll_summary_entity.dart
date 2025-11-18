import 'package:equatable/equatable.dart';

// 1. Định nghĩa cấu trúc cho phần TỔNG HỢP (Summary)
class PayrollSummaryEntity extends Equatable {
  final double totalSalary; // Tổng lương
  final double advancePaid; // Tạm ứng
  final double netSalary; // Thực nhận

  const PayrollSummaryEntity({
    required this.totalSalary,
    required this.advancePaid,
    required this.netSalary,
  });

  @override
  List<Object?> get props => [totalSalary, advancePaid, netSalary];
}