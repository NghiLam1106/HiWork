
import '../../../domain/entities/attendance_entity.dart';

class AttendanceModel {
  final String? id;
  final String employeeId;
  final DateTime workDate;
  final String shiftId;
  final DateTime? newCheckIn;
  final DateTime? newCheckOut;
  final String note;

  AttendanceModel({
    this.id,
    required this.employeeId,
    required this.workDate,
    required this.shiftId,
    this.newCheckIn,
    this.newCheckOut,
    required this.note,
  });

  // Convert Model → JSON để gửi API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'work_date': workDate.toIso8601String(),
      'shift_id': shiftId,
      'new_check_in_time': newCheckIn?.toIso8601String(),
      'new_check_out_time': newCheckOut?.toIso8601String(),
      'note': note,
    };
  }

  // Convert JSON → Model
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      employeeId: json['employee_id'],
      workDate: DateTime.parse(json['work_date']),
      shiftId: json['shift_id'],
      newCheckIn:
          json['new_check_in_time'] != null ? DateTime.parse(json['new_check_in_time']) : null,
      newCheckOut:
          json['new_check_out_time'] != null ? DateTime.parse(json['new_check_out_time']) : null,
      note: json['note'] ?? '',
    );
  }

  // Convert Entity → Model
  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      id: entity.id,
      employeeId: entity.employeeId,
      workDate: entity.workDate,
      shiftId: entity.shiftId,
      newCheckIn: entity.newCheckIn,
      newCheckOut: entity.newCheckOut,
      note: entity.note,
    );
  }
}
