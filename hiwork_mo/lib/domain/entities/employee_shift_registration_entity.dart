import 'package:equatable/equatable.dart';

// Entity đại diện cho dữ liệu cần thiết để đăng ký một ca làm việc
class EmployeeShiftRegistrationEntity extends Equatable {
  final String employeeId;
  final String shiftId; // ID của ca làm việc muốn đăng ký
  final DateTime workDate; // Ngày làm việc
  final String status; // Trạng thái ban đầu, ví dụ: 'Pending'

  const EmployeeShiftRegistrationEntity({
    required this.employeeId,
    required this.shiftId,
    required this.workDate,
    this.status = 'Pending', // Mặc định là 'Đang chờ duyệt'
  });

  @override
  List<Object> get props => [employeeId, shiftId, workDate, status];
}