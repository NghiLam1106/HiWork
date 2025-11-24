import '../../domain/entities/shift_schedule_entity.dart';
import '../../domain/repositories/common_schedule_repository.dart';
import '../datasources/common_schedule_datasource.dart';
import '../models/shift_schedule_model.dart';

class CommonScheduleRepositoryImpl implements CommonScheduleRepository {
  final CommonScheduleDataSource remoteDataSource;

  CommonScheduleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ShiftScheduleEntity>> getCommonSchedule({
    required DateTime date,
    required String departmentId,
  }) async {
    final List<ShiftScheduleModel> models =
        await remoteDataSource.getCommonSchedule(
      date: date,
      departmentId: departmentId,
    );

    return models.map((m) => m.toEntity()).toList();
  }
}
