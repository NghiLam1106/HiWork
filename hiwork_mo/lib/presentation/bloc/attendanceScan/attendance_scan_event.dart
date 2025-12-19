import 'package:hiwork_mo/domain/entities/shift_details_entity.dart';

abstract class AttendanceScanEvent {
  const AttendanceScanEvent();
}

class AttendanceLoadShifts extends AttendanceScanEvent {
  const AttendanceLoadShifts();
}

class AttendanceSelectShift extends AttendanceScanEvent {
  final ShiftDetailsEntity shift;
  const AttendanceSelectShift(this.shift);
}

class AttendanceCheckInSubmit extends AttendanceScanEvent {
  final int idEmployee;
  final String imagePath;

  const AttendanceCheckInSubmit({
    required this.idEmployee,
    required this.imagePath,
  });
}

class AttendanceCheckOutSubmit extends AttendanceScanEvent {
  final int idEmployee;

  const AttendanceCheckOutSubmit({required this.idEmployee});
}

class AttendanceClearError extends AttendanceScanEvent {
  const AttendanceClearError();
}
