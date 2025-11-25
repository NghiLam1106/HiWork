import '../entities/shift_schedule_entity.dart';
import '../repositories/common_schedule_repository.dart';

// Use Case (Ca sử dụng) định nghĩa một nghiệp vụ cụ thể: Lấy lịch làm việc chung.
class GetCommonScheduleUseCase {
  final CommonScheduleRepository repository;

  GetCommonScheduleUseCase({required this.repository});

  // Phương thức call() cho phép gọi Use Case như một hàm (e.g., usecase(params))
  Future<List<ShiftScheduleEntity>> call({
    required DateTime date,
    required String departmentId,
  }) async {
    // Logic nghiệp vụ (nếu có): kiểm tra điều kiện, xác thực, xử lý lỗi chung...
    
    // Gọi Repository để lấy dữ liệu đã được xử lý từ tầng Data
    return repository.getCommonSchedule(
      date: date,
      departmentId: departmentId,
    );
  }
}