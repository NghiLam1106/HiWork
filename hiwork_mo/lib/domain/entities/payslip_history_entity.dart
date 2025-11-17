import 'package:equatable/equatable.dart';

// 2. Định nghĩa các trạng thái của Phiếu Lương
enum PayslipStatus {
  paid, // Đã thanh toán
  pending, // Chờ xử lý
  confirmed, // Đã xác nhận
  failed, // Thất bại
  unknown
}

// 3. Định nghĩa cấu trúc cho MỘT HÀNG LỊCH SỬ
class PayslipHistoryEntity extends Equatable {
  final String id;
  final String periodName; // Ví dụ: "Phiếu lương 09/2025"
  final DateTime payDate; // Ngày thanh toán
  final double netSalary; // Số tiền
  final PayslipStatus status; // Trạng thái (enum)

  const PayslipHistoryEntity({
    required this.id,
    required this.periodName,
    required this.payDate,
    required this.netSalary,
    required this.status,
  });

  @override
  List<Object?> get props => [id, periodName, payDate, netSalary, status];
}