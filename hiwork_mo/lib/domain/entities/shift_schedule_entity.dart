import 'employee_entity.dart';

// Entity đại diện cho một ca làm việc và danh sách nhân viên trong ca đó (Domain Layer)
class ShiftScheduleEntity {
  final String shiftName;
  final String timeRange;
  // final String shiftIconName; // Dùng chuỗi để giữ Entity độc lập
  final List<EmployeeEntity> employees;

  const ShiftScheduleEntity({
    required this.shiftName,
    required this.timeRange,
    // required this.shiftIconName,
    required this.employees,
  });

  // Thuộc tính tiện ích: lấy số lượng nhân viên
  int get employeeCount => employees.length;

  ShiftScheduleEntity copyWith({
    String? shiftName,
    String? timeRange,
    // String? shiftIconName,
    List<EmployeeEntity>? employees,
  }) {
    return ShiftScheduleEntity(
      shiftName: shiftName ?? this.shiftName,
      timeRange: timeRange ?? this.timeRange,
      // shiftIconName: shiftIconName ?? this.shiftIconName,
      employees: employees ?? this.employees,
    );
  }
}