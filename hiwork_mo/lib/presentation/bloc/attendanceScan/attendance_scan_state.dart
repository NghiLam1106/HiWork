import 'package:hiwork_mo/domain/entities/attendance_scan_entity.dart';
import 'package:hiwork_mo/domain/entities/shift_details_entity.dart';
import 'package:hiwork_mo/domain/entities/shifts_entity.dart';

import '../../../data/models/shift_entry_model.dart';

class AttendanceScanState {
  final bool loading;
  final String? error;
  final List<ShiftAssignmentEntity> shifts;
  final ShiftAssignmentEntity? selectedShift;
  final AttendanceScan? lastLog;
  final bool submitting;


  const AttendanceScanState({
    required this.loading,
    required this.shifts,
    required this.submitting,
    this.selectedShift,
    this.lastLog,
    this.error,
  });

  factory AttendanceScanState.initial() => const AttendanceScanState(
        loading: false,
        shifts: [],
        submitting: false,
      );

  AttendanceScanState copyWith({
    bool? loading,
    bool? submitting,
    String? error,
    List<ShiftAssignmentEntity>? shifts,
    ShiftAssignmentEntity? selectedShift,
    AttendanceScan? lastLog,
  }) {
    return AttendanceScanState(
      loading: loading ?? this.loading,
      submitting: submitting ?? this.submitting,
      error: error,
      shifts: shifts ?? this.shifts,
      selectedShift: selectedShift ?? this.selectedShift,
      lastLog: lastLog ?? this.lastLog,
    );
  }
}
