import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/daily_timesheet_entity.dart';

abstract class TimesheetRepository {
  Future<Either<Failure, List<DailyTimesheetEntity>>> getWeeklyTimesheet(DateTime weekStartDate);
  
}