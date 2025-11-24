import '../../domain/entities/employee_shift_registration_entity.dart';

// Data Transfer Object (DTO) để gửi dữ liệu đăng ký qua API
class EmployeeShiftRegistrationModel {
  final String employeeId;
  final String shiftId; 
  final DateTime workDate;
  final String status;

  EmployeeShiftRegistrationModel({
    required this.employeeId,
    required this.shiftId,
    required this.workDate,
    required this.status,
  });

  // Chuyển từ Entity sang Model
  factory EmployeeShiftRegistrationModel.fromEntity(
      EmployeeShiftRegistrationEntity entity) {
    return EmployeeShiftRegistrationModel(
      employeeId: entity.employeeId,
      shiftId: entity.shiftId,
      workDate: entity.workDate,
      status: entity.status,
    );
  }

  // Chuyển Model thành Map (JSON) để gửi lên API
  Map<String, dynamic> toJson() {
    return {
      'id_employee': employeeId,
      'id_shift': shiftId,
      'work_date': workDate.toIso8601String().substring(0, 10), // Chỉ lấy ngày
      'status': status,
    };
  }
}