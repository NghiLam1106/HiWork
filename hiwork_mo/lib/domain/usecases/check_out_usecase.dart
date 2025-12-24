import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/attendance_scan_entity.dart';
import 'package:hiwork_mo/domain/repositories/attendance_scan_repository.dart';

class CheckOutUsecase {
  final AttendanceScanRepository repo;
  CheckOutUsecase(this.repo);

  Future<Either<Failure, AttendanceScan>> call({
    required int attendanceId,
  }) {
    return repo.checkOut(attendanceId: attendanceId);
  }
}
