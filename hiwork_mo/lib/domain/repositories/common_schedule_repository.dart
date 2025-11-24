import '../entities/shift_schedule_entity.dart';

abstract class CommonScheduleRepository {

  Future<List<ShiftScheduleEntity>> getCommonSchedule({
    required DateTime date,
    required String departmentId,
  });
}