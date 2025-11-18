import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/daily_timesheet_entity.dart';
import 'package:hiwork_mo/domain/repositories/timesheet_repository.dart'; // Import file bạn vừa tạo

class GetWeeklyTimesheetUseCase {
  final TimesheetRepository repository;

  GetWeeklyTimesheetUseCase(this.repository);

  Future<Either<Failure, List<DailyTimesheetEntity>>> execute(DateTime weekStartDate) async {
    // (Bạn có thể thêm logic nghiệp vụ ở đây, ví dụ: kiểm tra weekStartDate phải là Thứ 2)
    return await repository.getWeeklyTimesheet(weekStartDate);
  }
}