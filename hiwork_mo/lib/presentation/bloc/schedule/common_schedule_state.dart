import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/shift_schedule_entity.dart';
import 'package:flutter/material.dart'; // Cần import cho DebugPrint nếu muốn

// --- ABSTRACT BASE STATE ---
// Lớp cơ sở trừu tượng cho tất cả các trạng thái
@immutable
abstract class CommonScheduleState extends Equatable {
  // Các thuộc tính chung (Base Properties) có thể được định nghĩa ở đây
  final DateTime selectedDate;
  final String departmentName;

  const CommonScheduleState({
    required this.selectedDate,
    required this.departmentName,
  });

  @override
  List<Object> get props => [selectedDate, departmentName];
}

// --- INITIAL STATE ---
// 1. Trạng thái khởi tạo/ban đầu. Cần ngày hiện tại và tên phòng ban mặc định.
class CommonScheduleInitial extends CommonScheduleState {
  CommonScheduleInitial() : super(
    selectedDate: DateTime.now(),
    departmentName: 'Phòng ban đang tải...',
  );
}

// --- CONTENT STATE (Base for Loading, Loaded, Empty) ---
// Định nghĩa một trạng thái cơ sở chứa các dữ liệu hiển thị (ngày, tên phòng ban).
// Lớp này không thực sự cần thiết nhưng giúp cấu trúc rõ ràng hơn.
abstract class CommonScheduleContentState extends CommonScheduleState {
  const CommonScheduleContentState({
    required super.selectedDate,
    required super.departmentName,
  });
}

// --- LOADING STATE ---
// 2. Trạng thái đang tải dữ liệu
class CommonScheduleLoading extends CommonScheduleContentState {
  const CommonScheduleLoading({
    required super.selectedDate,
    required super.departmentName,
  });
}

// --- LOADED STATE ---
// 3. Trạng thái tải thành công (Có dữ liệu)
class CommonScheduleLoaded extends CommonScheduleContentState {
  final List<ShiftScheduleEntity> schedule;

  const CommonScheduleLoaded({
    required this.schedule,
    required super.selectedDate,
    required super.departmentName,
  });

  // Sử dụng copyWith để tạo trạng thái mới một cách dễ dàng
  CommonScheduleLoaded copyWith({
    List<ShiftScheduleEntity>? schedule,
    DateTime? selectedDate,
    String? departmentName,
  }) {
    return CommonScheduleLoaded(
      schedule: schedule ?? this.schedule,
      selectedDate: selectedDate ?? this.selectedDate,
      departmentName: departmentName ?? this.departmentName,
    );
  }

  @override
  List<Object> get props => [schedule, selectedDate, departmentName];
}

// --- EMPTY STATE ---
// 4. Trạng thái không có dữ liệu (Nhưng không phải lỗi)
class CommonScheduleEmpty extends CommonScheduleContentState {
  const CommonScheduleEmpty({
    required super.selectedDate,
    required super.departmentName,
  });
}

// --- ERROR STATE ---
// 5. Trạng thái lỗi
class CommonScheduleError extends CommonScheduleContentState {
  final String errorMessage;

  const CommonScheduleError({
    required this.errorMessage,
    required super.selectedDate,
    required super.departmentName,
  });

  @override
  List<Object> get props => [errorMessage, selectedDate, departmentName];
}