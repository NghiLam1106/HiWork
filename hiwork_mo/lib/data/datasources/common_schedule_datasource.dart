import '../models/employee_model.dart';
import '../models/shift_schedule_model.dart';

abstract class CommonScheduleDataSource {
  Future<List<ShiftScheduleModel>> getCommonSchedule({
    required DateTime date,
    required String departmentId,
  });
}

class MockCommonScheduleDataSource implements CommonScheduleDataSource {
  @override
  Future<List<ShiftScheduleModel>> getCommonSchedule({
    required DateTime date,
    required String departmentId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final employeesA = [
      EmployeeModel(id: 'E001', name: 'Nguyễn Văn A', departmentId: 'it'),
      EmployeeModel(id: 'E002', name: 'Trần Thị B', departmentId: 'it'),
    ];

    final employeesB = [
      EmployeeModel(id: 'E003', name: 'Lê Văn C', departmentId: 'it'),
    ];

    return [
      ShiftScheduleModel(
        shiftName: "Ca sáng",
        timeRange: "7:00 - 12:00",
        shiftIconName: "sunny",
        employees: employeesA,
      ),
      ShiftScheduleModel(
        shiftName: "Ca chiều",
        timeRange: "13:00 - 18:00",
        shiftIconName: "afternoon",
        employees: employeesB,
      ),
    ];
  }
}
