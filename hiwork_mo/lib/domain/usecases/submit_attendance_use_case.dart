// lib/domain/attendance/usecases/submit_attendance_usecase.dart
import 'package:dartz/dartz.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class SubmitAttendanceUseCase {
  final AttendanceRepository repository;

  SubmitAttendanceUseCase(this.repository);

  Future<Either<String, bool>> call({required AttendanceEntity data}) async {
    // 1. Kiểm tra logic start/end nếu có cả 2 thời gian
    if (data.newCheckIn != null &&
        data.newCheckOut != null &&
        data.newCheckIn!.isAfter(data.newCheckOut!)) {
      return const Left('Giờ bắt đầu phải trước giờ kết thúc.');
    }

    // 2. Gửi lên repository
    return repository.submitAttendance(data);
  }
}
