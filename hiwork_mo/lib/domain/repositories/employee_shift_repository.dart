import 'package:dartz/dartz.dart';
import '../entities/employee_shift_registration_entity.dart';

// Interface Repository cho các nghiệp vụ liên quan đến lịch làm việc nhân viên
abstract class EmployeeShiftRepository {
  Future<Either<String, bool>> registerShift({
    required EmployeeShiftRegistrationEntity registrationData,
  });
  
}