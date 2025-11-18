import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/data/datasources/timesheet_remote_datasource.dart';
import 'package:hiwork_mo/domain/entities/daily_timesheet_entity.dart';
import 'package:hiwork_mo/domain/repositories/timesheet_repository.dart';

// 5. Triển khai Repository (Cầu nối Data và Domain)
class TimesheetRepositoryImpl implements TimesheetRepository {
  final TimesheetRemoteDataSource remoteDataSource;

  TimesheetRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DailyTimesheetEntity>>> getWeeklyTimesheet(DateTime weekStartDate) async {
    
    // (Trong dự án thực tế, bạn sẽ kiểm tra kết nối mạng ở đây trước)

    try {
      // 1. Gọi DataSource để lấy List<DailyTimesheetModel>
      final dailyModels = await remoteDataSource.getWeeklyTimesheet(weekStartDate);
      
      // 2. Nếu thành công, trả về Right(List<Entity>)
      // (Vì DailyTimesheetModel kế thừa DailyTimesheetEntity, nên chúng tương thích)
      return Right(dailyModels.cast<DailyTimesheetEntity>()); 

    } on ServerException catch (e) {
      // 3. Bắt lỗi ServerException
      return Left(ServerFailure(message: e.message ?? 'Lỗi máy chủ không xác định.'));
    } on AuthException catch (e) { 
      // 4. Bắt lỗi xác thực (Dùng AuthException như file exceptions.dart của bạn)
      return Left(AuthFailure(message: e.message));
    } on Exception catch (e) {
      // 5. Bắt tất cả các lỗi còn lại
      return Left(ServerFailure(message: e.toString()));
    }
  }
}