import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/data/datasources/attendance_scan_remote_datasource.dart';
import 'package:hiwork_mo/domain/entities/attendance_scan_entity.dart';
import 'package:hiwork_mo/domain/repositories/attendance_scan_repository.dart';
import '../models/shift_entry_model.dart';

class AttendanceScanRepositoryImpl implements AttendanceScanRepository {
  final AttendanceScanRemoteDataSource remote;
  AttendanceScanRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<ShiftAssignmentModel>>> getShifts({
    required int idEmployee,
    required DateTime date,
  }) async {
    try {
      final res = await remote.getShifts(
        idEmployee: idEmployee,
        date: date,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? 'Lỗi máy chủ không xác định.'),
      );
    }
  }

  @override
  Future<Either<Failure, AttendanceScan>> checkInWithFace({
    required int idEmployee,
    required int idShift,
    required String imagePath,
  }) async {
    try {
      final res = await remote.faceCheckIn(
        idEmployee: idEmployee,
        idShift: idShift,
        imagePath: imagePath,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? 'Lỗi máy chủ không xác định.'),
      );
    }
  }

  @override
  Future<Either<Failure, AttendanceScan>> checkOut({
    required int idEmployee,
    required int idShift,
  }) async {
    try {
      final result = await remote.checkOut(
        idEmployee: idEmployee,
        idShift: idShift,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
