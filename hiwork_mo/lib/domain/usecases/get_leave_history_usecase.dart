import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/leave_request_entity.dart';
import 'package:hiwork_mo/domain/repositories/leave_repository.dart';

// UseCase (Trường hợp sử dụng) cho việc Lấy Lịch sử Nghỉ phép
class GetLeaveHistoryUseCase {
  final LeaveRepository repository;

  GetLeaveHistoryUseCase(this.repository);

  // 'execute' sẽ gọi hàm tương ứng từ repository
  Future<Either<Failure, List<LeaveRequestEntity>>> execute() async {
    return await repository.getLeaveHistory();
  }
}