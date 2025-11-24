import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

// ----- Chọn ngày -----
class DateSelected extends AttendanceEvent {
  final DateTime newDate;
  const DateSelected(this.newDate);

  @override
  List<Object> get props => [newDate];
}

// ----- Chọn ca -----
class ShiftSelected extends AttendanceEvent {
  final String newShiftId;
  const ShiftSelected(this.newShiftId);

  @override
  List<Object> get props => [newShiftId];
}

// ----- Cập nhật Check-in -----
class CheckInUpdated extends AttendanceEvent {
  final DateTime newCheckIn;
  const CheckInUpdated(this.newCheckIn);

  @override
  List<Object> get props => [newCheckIn];
}

// ----- Cập nhật Check-out -----
class CheckOutUpdated extends AttendanceEvent {
  final DateTime newCheckOut;
  const CheckOutUpdated(this.newCheckOut);

  @override
  List<Object> get props => [newCheckOut];
}

// ----- Cập nhật lý do -----
class NoteChanged extends AttendanceEvent {
  final String note;
  const NoteChanged(this.note);

  @override
  List<Object> get props => [note];
}

// ----- Gửi yêu cầu sửa -----
class SubmitRequested extends AttendanceEvent {
  const SubmitRequested();
}
