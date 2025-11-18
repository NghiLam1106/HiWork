import 'package:hiwork_mo/domain/entities/leave_balance_entity.dart';

// 2. Model cho Số dư phép (kế thừa Entity)
class LeaveBalanceModel extends LeaveBalanceEntity {
  const LeaveBalanceModel({
    required super.leaveType,
    required super.daysRemaining,
    required super.daysUsed,
  });

  // Hàm factory: Chuyển đổi JSON (từ API) thành Model
  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceModel(
      leaveType: json['leave_type'] as String,
      daysRemaining: (json['days_remaining'] as num).toDouble(),
      daysUsed: (json['days_used'] as num).toDouble(),
    );
  }
}