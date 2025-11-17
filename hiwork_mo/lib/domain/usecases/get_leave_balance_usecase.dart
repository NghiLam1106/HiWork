import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/leave_balance_entity.dart';
import 'package:hiwork_mo/domain/repositories/leave_repository.dart';

// UseCase (Trường hợp sử dụng) cho việc Lấy Số Dư Phép
class GetLeaveBalanceUseCase {
  final LeaveRepository repository;

  GetLeaveBalanceUseCase(this.repository);

  // 'execute' sẽ gọi hàm tương ứng từ repository
  // Trả về một danh sách, vì có thể có nhiều loại phép (Phép năm, Phép ốm...)
  Future<Either<Failure, List<LeaveBalanceEntity>>> execute() async {
    return await repository.getLeaveBalances();
  }
}