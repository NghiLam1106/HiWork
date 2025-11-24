import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../domain/repositories/employee_shift_repository.dart';
import '../../domain/entities/employee_shift_registration_entity.dart';
import '../models/employee_shift_registration_model.dart';

// Giả lập cơ chế giao tiếp với API hoặc Database
class EmployeeShiftRepositoryImpl implements EmployeeShiftRepository {
  // Giả định có một DataSource tương ứng
  // final EmployeeShiftDataSource dataSource; 
  // EmployeeShiftRepositoryImpl({required this.dataSource});

  @override
  Future<Either<String, bool>> registerShift({
    required EmployeeShiftRegistrationEntity registrationData,
  }) async {
    // 1. Chuyển Entity sang Model (DTO)
    final model = EmployeeShiftRegistrationModel.fromEntity(registrationData);
    final jsonPayload = model.toJson();

    // 2. Giả lập gọi API (Network delay)
    await Future.delayed(const Duration(milliseconds: 700));

    debugPrint('--- Gửi Đăng ký Lịch Làm Việc ---');
    debugPrint('Payload: $jsonPayload');

    // 3. Giả lập kết quả API
    if (model.shiftId == 'invalid_shift_id') {
      // Trường hợp lỗi nghiệp vụ (ví dụ: ID ca không tồn tại)
      return const Left('ID ca làm việc không hợp lệ.');
    } else if (model.workDate.day % 2 == 0) {
      // Giả lập thành công (Ngày chẵn)
      return const Right(true);
    } else {
      // Giả lập lỗi server (Ngày lẻ)
      return const Left('Lỗi mạng hoặc server không phản hồi.');
    }
  }
}