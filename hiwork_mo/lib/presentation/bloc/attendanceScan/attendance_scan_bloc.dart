import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/domain/usecases/check_in_with_face_usecase.dart';
import 'package:hiwork_mo/domain/usecases/check_out_usecase.dart';
import 'package:hiwork_mo/domain/usecases/get_shifts_detail_usecase.dart';

import 'attendance_scan_event.dart';
import 'attendance_scan_state.dart';

class AttendanceScanBloc extends Bloc<AttendanceScanEvent, AttendanceScanState> {
  final GetShiftsDetailUsecase getShiftsUsecase;
  final CheckInWithFaceUsecase checkInWithFaceUsecase;
  final CheckOutUsecase checkOutUsecase;

  AttendanceScanBloc({
    required this.getShiftsUsecase,
    required this.checkInWithFaceUsecase,
    required this.checkOutUsecase,
  }) : super(AttendanceScanState.initial()) {
    on<AttendanceLoadShifts>(_onLoadShifts);
    on<AttendanceSelectShift>(_onSelectShift);
    on<AttendanceCheckInSubmit>(_onCheckInSubmit);
    on<AttendanceCheckOutSubmit>(_onCheckOutSubmit);
    on<AttendanceClearError>(_onClearError);
  }

  Future<void> _onLoadShifts(
    AttendanceLoadShifts event,
    Emitter<AttendanceScanState> emit,
  ) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await getShiftsUsecase();

    result.fold(
      (failure) => emit(state.copyWith(loading: false, error: failure.message)),
      (shifts) {
        emit(state.copyWith(
          loading: false,
          shifts: shifts,
          selectedShift: shifts.isNotEmpty ? shifts.first : null,
          error: null,
        ));
      },
    );
  }

  void _onSelectShift(
    AttendanceSelectShift event,
    Emitter<AttendanceScanState> emit,
  ) {
    emit(state.copyWith(selectedShift: event.shift, error: null));
  }

  Future<void> _onCheckInSubmit(
    AttendanceCheckInSubmit event,
    Emitter<AttendanceScanState> emit,
  ) async {
    final shift = state.selectedShift;
    if (shift == null) {
      emit(state.copyWith(error: "Vui lòng chọn ca"));
      return;
    }

    emit(state.copyWith(submitting: true, error: null, lastLog: null));

    final result = await checkInWithFaceUsecase(
      idEmployee: event.idEmployee,
      idShift: shift.idShift,
      imagePath: event.imagePath,
    );

    result.fold(
      (failure) => emit(state.copyWith(submitting: false, error: failure.message)),
      (data) => emit(state.copyWith(submitting: false, lastLog: data, error: null)),
    );
  }

  Future<void> _onCheckOutSubmit(
    AttendanceCheckOutSubmit event,
    Emitter<AttendanceScanState> emit,
  ) async {
    final shift = state.selectedShift;
    if (shift == null) {
      emit(state.copyWith(error: "Vui lòng chọn ca"));
      return;
    }

    emit(state.copyWith(submitting: true, error: null, lastLog: null));

    final result = await checkOutUsecase(
      idEmployee: event.idEmployee,
      idShift: shift.idShift,
    );

    result.fold(
      (failure) => emit(state.copyWith(submitting: false, error: failure.message)),
      (data) => emit(state.copyWith(submitting: false, lastLog: data, error: null)),
    );
  }

  void _onClearError(
    AttendanceClearError event,
    Emitter<AttendanceScanState> emit,
  ) {
    emit(state.copyWith(error: null));
  }
}
