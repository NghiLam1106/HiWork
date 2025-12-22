import 'package:hiwork_mo/domain/entities/shift_details_entity.dart';
import 'package:hiwork_mo/domain/entities/shifts_entity.dart';

import '../../../data/models/shift_entry_model.dart';

abstract class AttendanceScanEvent {
  const AttendanceScanEvent();
}

class AttendanceLoadShifts extends AttendanceScanEvent {
  final int idEmployee;
  final DateTime date;
  const AttendanceLoadShifts({
    required this.idEmployee,
    required this.date,
  });
}

class AttendanceSelectShift extends AttendanceScanEvent {
  final ShiftAssignmentEntity shift;
  const AttendanceSelectShift(this.shift);
}

class AttendanceCheckInSubmit extends AttendanceScanEvent {
  final int idEmployee;
  final String imagePath;

  const AttendanceCheckInSubmit({
    required this.idEmployee,
    required this.imagePath, required idShift,
  });
}

class AttendanceCheckOutSubmit extends AttendanceScanEvent {
  final int idEmployee;

  const AttendanceCheckOutSubmit({required this.idEmployee, required idShift});
}

class AttendanceClearError extends AttendanceScanEvent {
  const AttendanceClearError();
}
