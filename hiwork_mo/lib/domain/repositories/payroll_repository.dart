import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
// Import 2 file Entity chúng ta đã định nghĩa
import 'package:hiwork_mo/domain/entities/payroll_summary_entity.dart';
import 'package:hiwork_mo/domain/entities/payslip_history_entity.dart';

// 4. Interface (Hợp đồng) cho Repository
abstract class PayrollRepository {
  // Hợp đồng 1: Lấy dữ liệu Tổng hợp (Summary)
  Future<Either<Failure, PayrollSummaryEntity>> getPayrollSummary(int month, int year);
  
  // Hợp đồng 2: Lấy Lịch sử kỳ lương (History)
  Future<Either<Failure, List<PayslipHistoryEntity>>> getPayrollHistory(int year);
}