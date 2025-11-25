import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hiwork_mo/domain/entities/employee_shift_registration_entity.dart';
import 'package:hiwork_mo/domain/usecases/register_shift_use_case.dart';
import 'package:intl/intl.dart';

import 'shift_registration_state.dart';
import 'shift_registration_event.dart'; 

// Giả định: Danh sách các ca làm việc có sẵn (thường được fetch từ API)
const List<Map<String, String>> MOCK_SHIFTS = [
  {'id': 'S001', 'name': 'Ca Sáng (07:00 - 12:00)'},
  {'id': 'S002', 'name': 'Ca Chiều (13:00 - 18:00)'},
  {'id': 'S003', 'name': 'Ca Tối (18:00 - 23:00)'},
];

class ShiftRegistrationBloc extends Bloc<ShiftRegistrationEvent, ShiftRegistrationState> {
  final RegisterShiftUseCase registerShiftUseCase;
  final String _currentEmployeeId = 'E001'; // Giả định ID nhân viên hiện tại

  ShiftRegistrationBloc({required this.registerShiftUseCase})
      : super(ShiftRegistrationState(
          selectedDate: DateTime.now(),
          selectedShiftId: MOCK_SHIFTS.first['id']!,
        )) {
    // Đăng ký các Event Handlers
    on<ShiftDateUpdated>(_onShiftDateUpdated);
    on<ShiftIdUpdated>(_onShiftIdUpdated);
    on<ShiftRegistrationRequested>(_onShiftRegistrationRequested);
  }

  // Handler cho Event cập nhật Ngày
  void _onShiftDateUpdated(ShiftDateUpdated event, Emitter<ShiftRegistrationState> emit) {
    emit(state.copyWith(
      selectedDate: event.newDate,
      status: ShiftRegistrationStatus.initial, // Reset trạng thái
      errorMessage: null,
    ));
  }

  // Handler cho Event cập nhật Ca
  void _onShiftIdUpdated(ShiftIdUpdated event, Emitter<ShiftRegistrationState> emit) {
    emit(state.copyWith(
      selectedShiftId: event.newShiftId,
      status: ShiftRegistrationStatus.initial, // Reset trạng thái
      errorMessage: null,
    ));
  }

  // Handler cho Event yêu cầu Đăng ký
  Future<void> _onShiftRegistrationRequested(
      ShiftRegistrationRequested event, Emitter<ShiftRegistrationState> emit) async {
    // 1. Phát ra trạng thái Loading
    emit(state.copyWith(status: ShiftRegistrationStatus.loading, errorMessage: null));

    // 2. Chuẩn bị dữ liệu Entity
    final registrationData = EmployeeShiftRegistrationEntity(
      employeeId: _currentEmployeeId,
      shiftId: state.selectedShiftId,
      workDate: state.selectedDate,
    );

    try {
      // 3. Gọi Use Case
      final result = await registerShiftUseCase.call(
        registrationData: registrationData,
      );

      // 4. Xử lý kết quả trả về từ Use Case (dùng dartz Either)
      result.fold(
        (error) {
          // Trường hợp thất bại (Left)
          emit(state.copyWith(
            status: ShiftRegistrationStatus.failure,
            errorMessage: error,
          ));
        },
        (isSuccess) {
          // Trường hợp thành công (Right)
          if (isSuccess) {
            emit(state.copyWith(
              status: ShiftRegistrationStatus.success,
              errorMessage: null,
            ));
          } else {
            // Trường hợp thành công nhưng logic trả về false
            emit(state.copyWith(
              status: ShiftRegistrationStatus.failure,
              errorMessage: 'Đăng ký thất bại không rõ nguyên nhân.',
            ));
          }
        },
      );
    } catch (e) {
      // 5. Xử lý lỗi hệ thống/Exception
      emit(state.copyWith(
        status: ShiftRegistrationStatus.failure,
        errorMessage: 'Lỗi hệ thống khi đăng ký: ${e.toString()}',
      ));
      debugPrint('Registration Error: $e');
    }
  }
}