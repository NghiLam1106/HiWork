import 'package:hiwork_mo/domain/entities/shifts_entity.dart';
import 'package:hiwork_mo/data/models/shift_model.dart';

// Model này kế thừa Entity của bạn
class ShiftAssignmentModel extends ShiftAssignmentEntity {
  const ShiftAssignmentModel({
    required super.idShiftAssignments,
    required super.idEmployee,
    required super.idShift,
    required super.workDate,
    required super.status,
    super.shift,
  });

  // Hàm factory: Chuyển đổi JSON (từ API) thành Model
  factory ShiftAssignmentModel.fromJson(Map<String, dynamic> json) {
    final shiftJson = json['shift'];

    return ShiftAssignmentModel(
      idShiftAssignments: json['id'] as int,
      idEmployee: json['id_employee'] as int,
      idShift: json['id_shift'] as int,
      workDate: DateTime.parse(json['work_date'] as String), // Chuyển String (ISO) sang DateTime
      status: json['status'] as int, // Ví dụ: "on_time", "early_leave"

      shift: (shiftJson is Map<String, dynamic>)
          ? ShiftDetailModel.fromJson(shiftJson)
          : null,
    );
  }

  // Hàm: Chuyển đổi Model thành JSON (để gửi đi, ví dụ: khi đăng ký ca)
  Map<String, dynamic> toJson() {
    return {
      'id_shift_assignments': idShiftAssignments,
      'id_employee': idEmployee,
      'id_shift': idShift,
      'work_date': workDate.toIso8601String(), // Chuyển DateTime sang String (ISO)
      'status': status,
    };
  }
}
