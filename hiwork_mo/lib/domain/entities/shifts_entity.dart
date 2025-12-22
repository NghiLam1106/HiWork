import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/shift_details_entity.dart';

// ignore: must_be_immutable
class ShiftAssignmentEntity extends Equatable {
  final int idShiftAssignments;
  final int idEmployee;
  final int idShift;
  final DateTime workDate;
  final int status;

  final ShiftDetailsEntity? shift;

  const ShiftAssignmentEntity({
    required this.idShiftAssignments,
    required this.idEmployee,
    required this.idShift,
    required this.workDate,
    required this.status,
    this.shift,
  });

  ShiftAssignmentEntity copyWith({
    int? idShiftAssignments,
    int? idEmployee,
    int? idShift,
    DateTime? workDate,
    int? status,
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
        shift,
      ];
}
