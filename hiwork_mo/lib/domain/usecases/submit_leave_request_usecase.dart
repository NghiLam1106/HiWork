import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/repositories/leave_repository.dart';

// 4. UseCase (Trường hợp sử dụng)
class SubmitLeaveUseCase {
  final LeaveRepository repository;

  SubmitLeaveUseCase(this.repository);

  // 'execute' sẽ gọi hàm tương ứng từ repository
  Future<Either<Failure, void>> execute({
    required DateTime fromDate,
    required DateTime toDate,
    required String leaveType,
    required String reason,
  }) async {
    // (Kiểm tra logic nghiệp vụ ở đây, ví dụ:)
    if (toDate.isBefore(fromDate)) {
      return Left(const InvalidInputFailure(message: 'Ngày kết thúc không thể trước ngày bắt đầu.'));
    }
    if (reason.isEmpty) {
      return Left(const InvalidInputFailure(message: 'Vui lòng nhập lý do.'));
    }
    
    return await repository.submitLeaveRequest(
      fromDate: fromDate,
      toDate: toDate,
      leaveType: leaveType,
      reason: reason,
    );
  }
}