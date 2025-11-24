// lib/domain/attendance/usecases/get_attendance_detail_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceDetailUseCase {
  final AttendanceRepository repository;

  GetAttendanceDetailUseCase(this.repository);

  Future<Either<String, AttendanceEntity>> call({required String id}) async {
    if (id.isEmpty) {
      return const Left("ID chấm công không hợp lệ.");
    }

    return await repository.getAttendanceDetail(id);
  }
}
