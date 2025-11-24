// lib/domain/attendance/usecases/submit_attendance_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class SubmitAttendanceUseCase {
  final AttendanceRepository repository;

  SubmitAttendanceUseCase(this.repository);

  Future<Either<String, bool>> call({
    required AttendanceEntity correctionData,
  }) async {
    // ===============================
    // 1. Validate: Check-in / Check-out
    // ===============================

    // Nếu có cả hai → phải check đúng thứ tự
    if (correctionData.newCheckIn != null &&
        correctionData.newCheckOut != null) {
      if (correctionData.newCheckIn!.isAfter(correctionData.newCheckOut!)) {
        return const Left('Giờ Check-in không thể sau giờ Check-out.');
      }
    }

    // ===============================
    // 2. Validate: Lý do sửa đổi
    // ===============================
    if (correctionData.note.trim().isEmpty) {
      return const Left('Vui lòng nhập lý do sửa đổi.');
    }

    // ===============================
    // 3. Gửi request xuống Repository
    // ===============================
    return await repository.submitAttendance(correctionData);
  }
}
