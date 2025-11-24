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

  // ===== Model -> JSON (gửi API / lưu DB) =====
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

  // ===== JSON -> Model (nhận từ API / DB) =====
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] as String?,
      employeeId: json['employee_id'] as String,
      workDate: DateTime.parse(json['work_date'] as String),
      shiftId: json['shift_id'] as String,
      newCheckIn: json['new_check_in_time'] != null
          ? DateTime.parse(json['new_check_in_time'] as String)
          : null,
      newCheckOut: json['new_check_out_time'] != null
          ? DateTime.parse(json['new_check_out_time'] as String)
          : null,
      note: json['note'] as String? ?? '',
    );
  }

  // ===== Entity -> Model (dùng khi submit) =====
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

  // ===== Model -> Entity (dùng khi load detail) =====
  AttendanceEntity toEntity() {
    return AttendanceEntity(
      id: id,
      employeeId: employeeId,
      workDate: workDate,
      shiftId: shiftId,
      newCheckIn: newCheckIn,
      newCheckOut: newCheckOut,
      note: note,
    );
  }
}
