import 'package:dartz/dartz.dart'; // Giả sử sử dụng dartz (Either) cho kết quả
import '../entities/employee_shift_registration_entity.dart';
import '../repositories/employee_shift_repository.dart';

// Use Case: Đăng ký ca làm việc của nhân viên
class RegisterShiftUseCase {
  final EmployeeShiftRepository repository;

  RegisterShiftUseCase({required this.repository});

  // Chữ ký hàm Call: Trả về Future<Either<Failure, bool>>
  // Giả định: Either<String (Lỗi), bool (Thành công/thất bại)>
  Future<Either<String, bool>> call({
    required EmployeeShiftRegistrationEntity registrationData,
  }) async {
    // Thực thi nghiệp vụ (ví dụ: kiểm tra trùng lịch, kiểm tra quyền...)
    
    // Gọi Repository để thực hiện lưu trữ dữ liệu
    return repository.registerShift(registrationData: registrationData);
  }
}