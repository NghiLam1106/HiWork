import '../../../domain/entities/attendance_entity.dart';

class AttendanceModel {
  final String? id;
  final String employeeId;
  final DateTime workDate;
  final String shiftId;
  final DateTime? newCheckIn;
  final DateTime? newCheckOut;
  final String note;
  final String? status; 
  final String? errorMessage; 

  AttendanceModel({
    this.id,
    required this.employeeId,
    required this.workDate,
    required this.shiftId,
    this.newCheckIn,
    this.newCheckOut,
    required this.note,
    this.status,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'work_date': workDate.toIso8601String().substring(0, 10),
      'shift_id': shiftId,
      'new_check_in_time': newCheckIn?.toIso8601String(),
      'new_check_out_time': newCheckOut?.toIso8601String(),
      'note': note,
      'status': status ?? 'pending',
    };
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      employeeId: json['employee_id'],
      workDate: DateTime.parse(json['work_date']),
      shiftId: json['shift_id'],
      newCheckIn: json['new_check_in_time'] != null
          ? DateTime.parse(json['new_check_in_time'])
          : null,
      newCheckOut: json['new_check_out_time'] != null
          ? DateTime.parse(json['new_check_out_time'])
          : null,
      note: json['note'] ?? '',
      status: json['status'],
    );
  }

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      id: entity.id,
      employeeId: entity.employeeId,
      workDate: entity.workDate,
      shiftId: entity.shiftId,
      newCheckIn: entity.newCheckIn,
      newCheckOut: entity.newCheckOut,
      note: entity.note,
      status: entity.status,
    );
  }

  AttendanceEntity toEntity() => AttendanceEntity(
        id: id,
        employeeId: employeeId,
        workDate: workDate,
        shiftId: shiftId,
        newCheckIn: newCheckIn,
        newCheckOut: newCheckOut,
        note: note,
        status: status,
      );
}
