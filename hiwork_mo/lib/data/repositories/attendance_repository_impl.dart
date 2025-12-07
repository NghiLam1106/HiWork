// lib/data/attendance/repositories/attendance_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../domain/entities/attendance_entity.dart';
import '../../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';
import '../models/attendance_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, AttendanceEntity>> getAttendanceDetail(String id) async {
    try {
      final model = await remoteDataSource.getAttendanceDetail(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> submitAttendance(AttendanceEntity data) async {
    try {
      final model = AttendanceModel(
        id: data.id,
        employeeId: '',
        workDate: data.workDate,
        shiftId: data.shiftId,
        newCheckIn: data.newCheckIn,
        newCheckOut: data.newCheckOut,
        note: data.note,
        status: data.status,
      );

      final result = await remoteDataSource.submitAttendance(model);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }  
}
