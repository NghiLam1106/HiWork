import 'package:equatable/equatable.dart';

// Equatable: giúp so sánh các object event
abstract class CommonScheduleEvent extends Equatable {
  const CommonScheduleEvent();

  @override
  List<Object> get props => [];
}

// Event 1: Sự kiện tải lịch làm việc, có thể do người dùng thay đổi ngày
class LoadScheduleRequested extends CommonScheduleEvent {
  final DateTime date;
  
  const LoadScheduleRequested({required this.date});

  @override
  List<Object> get props => [date];
}

// Event 2: Sự kiện khởi tạo ban đầu (Nếu cần)
class CommonScheduleInitialized extends CommonScheduleEvent {}