import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hiwork_mo/domain/usecases/submit_attendance_usecase.dart';

import 'attendance_event.dart';
import 'attendance_state.dart';

import 'package:hiwork_mo/domain/entities/attendance_entity.dart';

// =======================================
// MOCK SHIFT DATA (cho UI chạy được)
// =======================================
const MOCK_CURRENT_EMPLOYEE_ID = 'E001';
const List<Map<String, String>> MOCK_SHIFTS = [
  {'id': 'S001', 'name': 'Ca Sáng', 'time': '7:00 - 12:00'},
  {'id': 'S002', 'name': 'Ca Trưa', 'time': '12:00 - 17:30'},
  {'id': 'S003', 'name': 'Ca Tối', 'time': '17:30 - 23:30'},
];

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final SubmitAttendanceUseCase submitUseCase;

  AttendanceBloc({required this.submitUseCase})
      : super(
          AttendanceState(
            selectedDate: DateTime.now(),
            selectedShiftId: MOCK_SHIFTS.first['id']!,
            note: '',
          ),
        ) {
    on<DateSelected>(_onDateSelected);
    on<ShiftSelected>(_onShiftSelected);
    on<CheckInUpdated>(_onCheckInUpdated);
    on<CheckOutUpdated>(_onCheckOutUpdated);
    on<NoteChanged>(_onNoteChanged);
    on<SubmitRequested>(_onSubmitRequested);
  }

  // ============================================================
  // 1. CHỌN NGÀY
  // ============================================================
  void _onDateSelected(DateSelected event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(
      selectedDate: event.newDate,
      status: CorrectionStatus.initial,
      errorMessage: null,
    ));
  }

  // ============================================================
  // 2. CHỌN CA (Shift)
  // ============================================================
  void _onShiftSelected(ShiftSelected event, Emitter<AttendanceState> emit) {
    final newShiftId = event.newShiftId;

    final isValid =
        MOCK_SHIFTS.any((shift) => shift['id'] == newShiftId);

    if (!isValid) {
      emit(state.copyWith(
        status: CorrectionStatus.failure,
        errorMessage: "Ca làm việc không hợp lệ",
      ));
      return;
    }

    emit(state.copyWith(
      selectedShiftId: newShiftId,
      status: CorrectionStatus.initial,
      errorMessage: null,
    ));
  }

  // ============================================================
  // 3. CHECK-IN
  // ============================================================
  void _onCheckInUpdated(
      CheckInUpdated event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(
      checkIn: event.newCheckIn,
      status: CorrectionStatus.initial,
      errorMessage: null,
    ));
  }

  // ============================================================
  // 4. CHECK-OUT
  // ============================================================
  void _onCheckOutUpdated(
      CheckOutUpdated event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(
      checkOut: event.newCheckOut,
      status: CorrectionStatus.initial,
      errorMessage: null,
    ));
  }

  // ============================================================
  // 5. LÝ DO
  // ============================================================
  void _onNoteChanged(NoteChanged event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(
      note: event.note,
      status: CorrectionStatus.initial,
      errorMessage: null,
    ));
  }

  // ============================================================
  // 6. GỬI YÊU CẦU
  // ============================================================
  Future<void> _onSubmitRequested(
      SubmitRequested event, Emitter<AttendanceState> emit) async {
    // 1. Validate
    if (state.checkIn == null && state.checkOut == null) {
      emit(state.copyWith(
        status: CorrectionStatus.failure,
        errorMessage:
            "Vui lòng chọn Giờ Check-in hoặc Giờ Check-out cần sửa.",
      ));
      return;
    }

    if (state.note.trim().isEmpty) {
      emit(state.copyWith(
        status: CorrectionStatus.failure,
        errorMessage: "Vui lòng nhập lý do sửa đổi.",
      ));
      return;
    }

    // Check-in < Check-out
    if (state.checkIn != null &&
        state.checkOut != null &&
        state.checkIn!.isAfter(state.checkOut!)) {
      emit(state.copyWith(
        status: CorrectionStatus.failure,
        errorMessage: "Giờ Check-in không thể sau giờ Check-out.",
      ));
      return;
    }

    // 2. Loading
    emit(state.copyWith(
      status: CorrectionStatus.loading,
      errorMessage: null,
    ));

    // 3. Build Entity
    final entity = AttendanceEntity(
      employeeId: MOCK_CURRENT_EMPLOYEE_ID,
      workDate: state.selectedDate,
      shiftId: state.selectedShiftId,
      newCheckIn: state.checkIn,
      newCheckOut: state.checkOut,
      note: state.note,
    );

    // 4. Gọi UseCase
    final result = await submitUseCase.call(correctionData: entity);

    result.fold(
      (error) {
        emit(state.copyWith(
          status: CorrectionStatus.failure,
          errorMessage: error,
        ));
      },
      (success) {
        emit(state.copyWith(
          status: CorrectionStatus.success,
          checkIn: null,
          checkOut: null,
          note: "",
          errorMessage: null,
        ));
      },
    );
  }
}
