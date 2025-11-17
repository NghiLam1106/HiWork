import 'package:equatable/equatable.dart';

// Lớp cơ sở (abstract) cho tất cả các sự kiện
abstract class LeaveEvent extends Equatable {
  const LeaveEvent();
  @override
  List<Object?> get props => [];
}

// Sự kiện: Yêu cầu tải dữ liệu ban đầu cho trang (Số dư + Lịch sử)
class LoadLeaveData extends LeaveEvent {}

// Sự kiện: Người dùng nhấn nút Gửi Yêu cầu nghỉ
class SubmitLeaveRequest extends LeaveEvent {
  final DateTime fromDate;
  final DateTime toDate;
  final String leaveType;
  final String reason;

  const SubmitLeaveRequest({
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
    required this.reason,
  });

  @override
  List<Object?> get props => [fromDate, toDate, leaveType, reason];
}