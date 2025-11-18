import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/shifts_entity.dart'; // Import file bạn vừa tạo

// 3. Định nghĩa cấu trúc cho MỘT NGÀY (chứa nhiều ca)
class DailyTimesheetEntity extends Equatable {
  final DateTime date; // Ngày (ví dụ: 09/09/2025)
  final List<ShiftAssignmentEntity> shifts; // Danh sách các ca trong ngày đó

  const DailyTimesheetEntity({
    required this.date,
    required this.shifts,
  });

  @override
  // Sửa lỗi Equatable: Thêm '?'
  List<Object?> get props => [date, shifts];
}