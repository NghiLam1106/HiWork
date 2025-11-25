import 'package:dartz/dartz.dart';
import '../entities/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<Either<String, AttendanceEntity>> getAttendanceDetail(String id);

  /// return Right(true) nếu gửi thành công, Left(message) nếu lỗi
  Future<Either<String, bool>> submitAttendance(AttendanceEntity data);
}
