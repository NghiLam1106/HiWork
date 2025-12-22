import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/attendance_scan_entity.dart';
import 'package:hiwork_mo/domain/entities/shift_details_entity.dart';
import '../../data/models/shift_entry_model.dart';

abstract class AttendanceScanRepository {
  Future<Either<Failure, List<ShiftAssignmentModel>>> getShifts({
    required int idEmployee,
    required DateTime date,
  });

  Future<Either<Failure, AttendanceScan>> checkInWithFace({
    required int idEmployee,
    required int idShift,
    required String imagePath,
  });

  Future<Either<Failure, AttendanceScan>> checkOut({
    required int idEmployee,
    required int idShift,
  });
}
