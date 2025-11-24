import '../../domain/entities/shift_schedule_entity.dart';
import 'employee_model.dart';

class ShiftScheduleModel {
  final String shiftName;
  final String timeRange;
  final String shiftIconName; 
  final List<EmployeeModel> employees;

  ShiftScheduleModel({
    required this.shiftName,
    required this.timeRange,
    required this.shiftIconName,
    required this.employees,
  });

  factory ShiftScheduleModel.fromJson(Map<String, dynamic> json) {
    return ShiftScheduleModel(
      shiftName: json['shiftName'] ?? '',
      timeRange: json['timeRange'] ?? '',
      shiftIconName: json['shiftIconName'] ?? '',
      employees: (json['employees'] as List<dynamic>)
          .map((e) => EmployeeModel.fromJson(e))
          .toList(),
    );
  }

  ShiftScheduleEntity toEntity() {
    return ShiftScheduleEntity(
      shiftName: shiftName,
      timeRange: timeRange,
      // shiftIconName: shiftIconName,
      employees: employees.map((e) => e.toEntity()).toList(),
    );
  }
}
