import 'package:equatable/equatable.dart';

enum ShiftRegistrationStatus {
  initial,
  loading,
  success,
  failure,
}

// Equatable: Giúp so sánh trạng thái
class ShiftRegistrationState extends Equatable {
  final ShiftRegistrationStatus status;
  final String? errorMessage;
  final DateTime selectedDate;
  final String selectedShiftId;

  const ShiftRegistrationState({
    this.status = ShiftRegistrationStatus.initial,
    this.errorMessage,
    required this.selectedDate,
    required this.selectedShiftId,
  });

  // copyWith giúp tạo trạng thái mới (bất biến)
  ShiftRegistrationState copyWith({
    ShiftRegistrationStatus? status,
    String? errorMessage,
    DateTime? selectedDate,
    String? selectedShiftId,
  }) {
    return ShiftRegistrationState(
      status: status ?? this.status,
      errorMessage: errorMessage, // Luôn reset khi không truyền vào
      selectedDate: selectedDate ?? this.selectedDate,
      selectedShiftId: selectedShiftId ?? this.selectedShiftId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        selectedDate,
        selectedShiftId,
      ];
}