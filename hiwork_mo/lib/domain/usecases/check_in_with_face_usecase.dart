import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/attendance_scan_entity.dart';
import 'package:hiwork_mo/domain/repositories/attendance_scan_repository.dart';

class CheckInWithFaceUsecase {
  final AttendanceScanRepository repo;
  CheckInWithFaceUsecase(this.repo);

  Future<Either<Failure, AttendanceScan>> call({
    required int idEmployee,
    required int idShift,
    required String imagePath,
  }) {
    return repo.checkInWithFace(
      idEmployee: idEmployee,
      idShift: idShift,
      imagePath: imagePath,
    );
  }
}
