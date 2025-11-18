import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ShiftAssignmentEntity extends Equatable {
  final int idShiftAssignments;
  final int idEmployee;
  final int idShift;
  final DateTime workDate;
  final String status;

  const ShiftAssignmentEntity({
    required this.idShiftAssignments,
    required this.idEmployee,
    required this.idShift,
    required this.workDate,
    required this.status,
  });

  ShiftAssignmentEntity copyWith({
    int? idShiftAssignments,
    int? idEmployee,
    int? idShift,
    DateTime? workDate,
    String? status,
  }) {
    return ShiftAssignmentEntity(
      idShiftAssignments: idShiftAssignments ?? this.idShiftAssignments,
      idEmployee: idEmployee ?? this.idEmployee,
      idShift: idShift ?? this.idShift,
      workDate: workDate ?? this.workDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        idShiftAssignments,
        idEmployee,
        idShift,
        workDate,
        status,
      ];
}