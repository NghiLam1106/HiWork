import 'package:equatable/equatable.dart';

class ShiftDetailsEntity extends Equatable {
  final int idShift;
  final String name; // Ví dụ: "Ca sáng"
  final String startTime; // Ví dụ: "07:00"
  final String endTime; // Ví dụ: "12:00"

  const ShiftDetailsEntity({
    required this.idShift,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [idShift, name, startTime, endTime];
}
