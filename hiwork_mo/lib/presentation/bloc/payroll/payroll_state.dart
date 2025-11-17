import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/payroll_summary_entity.dart';
import 'package:hiwork_mo/domain/entities/payslip_history_entity.dart';

// Lớp cơ sở (abstract) cho tất cả các trạng thái
abstract class PayrollState extends Equatable {
  const PayrollState();
  @override
  List<Object?> get props => [];
}

// Trạng thái: Khởi tạo (ban đầu)
class PayrollInitial extends PayrollState {}

// Trạng thái: Đang tải (UI sẽ hiển thị vòng xoay)
class PayrollLoading extends PayrollState {}

// Trạng thái: Tải thành công (UI sẽ hiển thị cả 2 phần dữ liệu)
class PayrollLoaded extends PayrollState {
  // Trạng thái này chứa cả 2 loại dữ liệu mà UI cần
  final PayrollSummaryEntity summary; // Phần 1: Hiệu quả làm việc
  final List<PayslipHistoryEntity> history; // Phần 2: Lịch sử kỳ lương
  
  const PayrollLoaded({
    required this.summary,
    required this.history,
  });

  @override
  List<Object?> get props => [summary, history];
}

// Trạng thái: Tải thất bại (UI sẽ hiển thị thông báo lỗi)
class PayrollError extends PayrollState {
  final String message;

  const PayrollError(this.message);

  @override
  List<Object?> get props => [message];
}