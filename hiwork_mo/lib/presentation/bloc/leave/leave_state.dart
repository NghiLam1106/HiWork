import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/leave_balance_entity.dart';
import 'package:hiwork_mo/domain/entities/leave_request_entity.dart';

// Lớp cơ sở (abstract) cho tất cả các trạng thái
abstract class LeaveState extends Equatable {
  const LeaveState();
  @override
  List<Object?> get props => [];
}

// Trạng thái: Khởi tạo (ban đầu)
class LeaveInitial extends LeaveState {}

// Trạng thái: Đang tải dữ liệu ban đầu (Số dư, Lịch sử)
class LeaveLoading extends LeaveState {}

// Trạng thái: Đang gửi Form
class LeaveSubmissionInProgress extends LeaveState {}

// Trạng thái: Gửi Form thành công
class LeaveSubmissionSuccess extends LeaveState {}

// Trạng thái: Tải dữ liệu thành công (chứa cả Số dư và Lịch sử)
class LeaveLoaded extends LeaveState {
  final List<LeaveBalanceEntity> balances;
  final List<LeaveRequestEntity> history;
  
  const LeaveLoaded({
    required this.balances,
    required this.history,
  });

  @override
  List<Object?> get props => [balances, history];
}

// Trạng thái: Bị lỗi (chung cho cả Tải dữ liệu và Gửi Form)
class LeaveError extends LeaveState {
  final String message;

  const LeaveError(this.message);

  @override
  List<Object?> get props => [message];
}