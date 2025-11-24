import 'package:equatable/equatable.dart';

abstract class ShiftRegistrationEvent extends Equatable {
  const ShiftRegistrationEvent();

  @override
  List<Object> get props => [];
}

// Event yêu cầu cập nhật ngày làm việc được chọn
class ShiftDateUpdated extends ShiftRegistrationEvent {
  final DateTime newDate;

  const ShiftDateUpdated({required this.newDate});

  @override
  List<Object> get props => [newDate];
}

// Event yêu cầu cập nhật ID ca làm việc được chọn
class ShiftIdUpdated extends ShiftRegistrationEvent {
  final String newShiftId;

  const ShiftIdUpdated({required this.newShiftId});

  @override
  List<Object> get props => [newShiftId];
}

// Event yêu cầu thực hiện hành động đăng ký ca làm việc
class ShiftRegistrationRequested extends ShiftRegistrationEvent {
  const ShiftRegistrationRequested();
}