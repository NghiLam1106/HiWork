import 'package:equatable/equatable.dart';

enum CorrectionStatus { initial, loading, success, failure }

class AttendanceState extends Equatable {
  final CorrectionStatus status;
  final DateTime selectedDate;
  final String selectedShiftId;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String note;
  final String? errorMessage;

  const AttendanceState({
    this.status = CorrectionStatus.initial,
    required this.selectedDate,
    required this.selectedShiftId,
    this.checkIn,
    this.checkOut,
    this.note = '',
    this.errorMessage,
  });

  AttendanceState copyWith({
    CorrectionStatus? status,
    DateTime? selectedDate,
    String? selectedShiftId,
    DateTime? checkIn,
    DateTime? checkOut,
    String? note,
    String? errorMessage,
  }) {
    return AttendanceState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedShiftId: selectedShiftId ?? this.selectedShiftId,
      checkIn: checkIn,      // cho phép null
      checkOut: checkOut,    // cho phép null
      note: note ?? this.note,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedDate,
        selectedShiftId,
        checkIn,
        checkOut,
        note,
        errorMessage,
      ];
}
