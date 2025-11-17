import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/payroll_summary_entity.dart';
import 'package:hiwork_mo/domain/repositories/payroll_repository.dart';

// 5. UseCase 1: Lấy Dữ liệu Tổng hợp
class GetPayrollSummaryUseCase {
  final PayrollRepository repository;

  GetPayrollSummaryUseCase(this.repository);

  Future<Either<Failure, PayrollSummaryEntity>> execute(int month, int year) async {
    return await repository.getPayrollSummary(month, year);
  }
}