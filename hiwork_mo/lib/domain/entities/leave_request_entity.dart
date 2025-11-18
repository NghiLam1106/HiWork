import 'package:equatable/equatable.dart';

// Định nghĩa các trạng thái của yêu cầu
enum LeaveStatus {
  pending, // Chờ duyệt
  approved, // Đã duyệt
  rejected, // Bị từ chối
  unknown
}

// 1. Định nghĩa cấu trúc Yêu cầu nghỉ phép
class LeaveRequestEntity extends Equatable {
  final String id;
  final DateTime fromDate;
  final DateTime toDate;
  final String leaveType; // Ví dụ: "Nghỉ phép năm", "Nghỉ ốm"
  final String reason;
  final LeaveStatus status;
  final double daysRequested; // Số ngày nghỉ (ví dụ: 1.5)

  const LeaveRequestEntity({
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
    required this.reason,
    required this.status,
    required this.daysRequested,
  });

  @override
  List<Object?> get props => [id, fromDate, toDate, leaveType, reason, status, daysRequested];
}