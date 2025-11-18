import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/daily_timesheet_entity.dart';

// Lớp cơ sở (abstract) cho tất cả các trạng thái
abstract class TimesheetState extends Equatable {
  const TimesheetState();
  @override
  List<Object> get props => [];
}

// Trạng thái: Khởi tạo (ban đầu)
class TimesheetInitial extends TimesheetState {}

// Trạng thái: Đang tải (UI sẽ hiển thị vòng xoay)
class TimesheetLoading extends TimesheetState {}

// Trạng thái: Tải thành công (UI sẽ hiển thị ListView)
class TimesheetLoaded extends TimesheetState {
  // Trạng thái này chứa dữ liệu (Bảng chấm công) mà UI cần
  final List<DailyTimesheetEntity> timesheet;
  
  const TimesheetLoaded(this.timesheet);

  @override
  List<Object> get props => [timesheet];
}

// Trạng thái: Tải thất bại (UI sẽ hiển thị thông báo lỗi)
class TimesheetError extends TimesheetState {
  final String message;

  const TimesheetError(this.message);

  @override
  List<Object> get props => [message];
}