import 'package:equatable/equatable.dart';

class ShiftDetailsEntity extends Equatable {
  final int idShift;
  final String shiftName; // Ví dụ: "Ca sáng"
  final String startTime; // Ví dụ: "07:00"
  final String endTime; // Ví dụ: "12:00"

  const ShiftDetailsEntity({
    required this.idShift,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [idShift, shiftName, startTime, endTime];
}