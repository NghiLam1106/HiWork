import 'package:equatable/equatable.dart';

// Lớp cơ sở (abstract) cho tất cả các sự kiện
abstract class TimesheetEvent extends Equatable {
  const TimesheetEvent();
  @override
  List<Object> get props => [];
}

// Sự kiện: Yêu cầu tải Bảng Chấm Công Tuần
// (UI sẽ gửi sự kiện này, đính kèm ngày bắt đầu của tuần)
class LoadWeeklyTimesheet extends TimesheetEvent {
  final DateTime weekStartDate;

  const LoadWeeklyTimesheet(this.weekStartDate);

  @override
  List<Object> get props => [weekStartDate];
}

// (Bạn có thể thêm các sự kiện khác ở đây, ví dụ: 'RequestAttendanceChange')