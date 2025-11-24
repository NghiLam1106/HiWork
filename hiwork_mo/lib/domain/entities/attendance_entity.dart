import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final String? id;
  final String employeeId;
  final DateTime workDate;
  final String shiftId; 
  final DateTime? newCheckIn; // Giờ vào được yêu cầu sửa (có thể null nếu chỉ sửa giờ ra)
  final DateTime? newCheckOut; // Giờ ra được yêu cầu sửa (có thể null nếu chỉ sửa giờ vào)
  final String note; // Lý do sửa đổi
  final String? status; // Trạng thái xử lý (có thể null nếu chưa được xử lý)

  const AttendanceEntity({
    this.id = '',
    required this.employeeId,
    required this.workDate,
    required this.shiftId,
    this.newCheckIn,
    this.newCheckOut,
    required this.note,
    this.status,
  });

  @override
  List<Object?> get props => [
    id,
    employeeId,
    workDate,
    shiftId,
    newCheckIn,
    newCheckOut,
    note,
    status,
  ];
}