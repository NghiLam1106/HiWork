import 'package:hiwork_mo/domain/entities/leave_request_entity.dart';

// 1. Model cho MỘT Yêu cầu nghỉ (kế thừa Entity)
class LeaveRequestModel extends LeaveRequestEntity {
  const LeaveRequestModel({
    required super.id,
    required super.fromDate,
    required super.toDate,
    required super.leaveType,
    required super.reason,
    required super.status,
    required super.daysRequested,
  });

  // Hàm chuyển đổi String (từ API) sang Enum (trong Entity)
  static LeaveStatus _statusFromString(String? status) {
    switch (status) {
      case 'pending':
        return LeaveStatus.pending;
      case 'approved':
        return LeaveStatus.approved;
      case 'rejected':
        return LeaveStatus.rejected;
      default:
        return LeaveStatus.unknown;
    }
  }

  // Hàm factory: Chuyển đổi JSON (từ API) thành Model
  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestModel(
      id: json['id'] as String,
      fromDate: DateTime.parse(json['from_date'] as String),
      toDate: DateTime.parse(json['to_date'] as String),
      leaveType: json['leave_type'] as String,
      reason: json['reason'] as String,
      status: _statusFromString(json['status'] as String?),
      daysRequested: (json['days_requested'] as num).toDouble(),
    );
  }
}