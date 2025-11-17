import 'package:equatable/equatable.dart';

// Lớp cơ sở (abstract) cho tất cả các sự kiện
abstract class PayrollEvent extends Equatable {
  const PayrollEvent();
  @override
  List<Object?> get props => [];
}

// Sự kiện: Yêu cầu tải Dữ liệu Kỳ lương (Dashboard)
// (UI sẽ gửi sự kiện này, đính kèm tháng và năm)
class LoadPayrollData extends PayrollEvent {
  final int month;
  final int year;

  const LoadPayrollData({required this.month, required this.year});

  @override
  List<Object?> get props => [month, year];
}

// (Bạn có thể thêm các sự kiện khác ở đây, ví dụ: 'RequestSalaryAdvance')