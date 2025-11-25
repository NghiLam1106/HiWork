import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hiwork_mo/domain/entities/shift_schedule_entity.dart';
import 'package:hiwork_mo/domain/usecases/get_common_schedule_use_case.dart';
import 'package:hiwork_mo/presentation/bloc/schedule/common_schedule_event.dart';
import 'package:hiwork_mo/presentation/bloc/schedule/common_schedule_state.dart';


// Bloc quản lý State và Event cho trang Lịch làm việc chung
class CommonScheduleBloc extends Bloc<CommonScheduleEvent, CommonScheduleState> {
  final GetCommonScheduleUseCase getScheduleUseCase;
  
  // Thông tin cố định của phòng ban đang xem
  final String _currentDepartmentId = 'it01';
  final String _currentDepartmentName = 'Phòng Công nghệ Thông tin';

  CommonScheduleBloc({required this.getScheduleUseCase})
      : super(CommonScheduleInitial()) {
    
    // Đăng ký Event Handler cho LoadScheduleRequested
    on<LoadScheduleRequested>(_onLoadScheduleRequested);
    
    // Đăng ký Event Handler cho CommonScheduleInitialized (tùy chọn)
    on<CommonScheduleInitialized>((event, emit) {
      // Logic khởi tạo nếu cần
    });
  }

  // Hàm xử lý khi nhận được Event LoadScheduleRequested
  Future<void> _onLoadScheduleRequested(
    LoadScheduleRequested event, 
    Emitter<CommonScheduleState> emit
  ) async {
    final date = event.date;
    
    // 1. Phát ra trạng thái Loading
    emit(CommonScheduleLoading(
      selectedDate: date,
      departmentName: _currentDepartmentName,
    ));
      

    try {
      // 2. Gọi Use Case để thực thi nghiệp vụ
      final List<ShiftScheduleEntity> schedule = await getScheduleUseCase.call(
        date: date,
        departmentId: _currentDepartmentId,
      );

      // 3. Phân tích kết quả và phát ra trạng thái phù hợp
      if (schedule.isEmpty) {
        emit(CommonScheduleEmpty(
          selectedDate: date,
          departmentName: _currentDepartmentName,
        ));
      } else {
        emit(CommonScheduleLoaded(
          schedule: schedule,
          selectedDate: date,
          departmentName: _currentDepartmentName,
        ));
      }
    } catch (e) {
      // 4. Xử lý lỗi và phát ra trạng thái Error
      debugPrint('Error loading schedule: $e');
      emit(CommonScheduleError(
        errorMessage: 'Không thể tải lịch làm việc. Vui lòng thử lại.',
        selectedDate: date,
        departmentName: _currentDepartmentName
      ));
    }
  }
}