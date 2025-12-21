import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/shift_details_entity.dart';
import 'package:hiwork_mo/domain/repositories/attendance_scan_repository.dart';

class GetShiftsDetailUsecase {
  final AttendanceScanRepository repo;
  GetShiftsDetailUsecase(this.repo);

  Future<Either<Failure, List<ShiftDetailsEntity>>> call() => repo.getShifts();
}
