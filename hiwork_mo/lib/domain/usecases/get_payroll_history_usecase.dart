import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
// Import Entity và Repository bạn đã tạo
import 'package:hiwork_mo/domain/entities/payslip_history_entity.dart';
import 'package:hiwork_mo/domain/repositories/payroll_repository.dart';

// 6. UseCase 2: Lấy Lịch sử
class GetPayrollHistoryUseCase {
  final PayrollRepository repository;

  GetPayrollHistoryUseCase(this.repository);

  // 'execute' sẽ gọi hàm 'getPayrollHistory' từ repository
  Future<Either<Failure, List<PayslipHistoryEntity>>> execute(int year) async {
    // (Kiểm tra logic nghiệp vụ ở đây, ví dụ: năm phải hợp lệ)
    if (year < 2020) {
      return Left(const InvalidInputFailure(message: 'Năm không hợp lệ.'));
    }
    return await repository.getPayrollHistory(year);
  }
}