import 'package:equatable/equatable.dart';

// 2. Định nghĩa cấu trúc Số dư phép
class LeaveBalanceEntity extends Equatable {
  final String leaveType; // Ví dụ: "Nghỉ phép năm"
  final double daysRemaining; // Số ngày còn lại (ví dụ: 10.5)
  final double daysUsed; // Số ngày đã dùng

  const LeaveBalanceEntity({
    required this.leaveType,
    required this.daysRemaining,
    required this.daysUsed,
  });

  @override
  List<Object?> get props => [leaveType, daysRemaining, daysUsed];
}