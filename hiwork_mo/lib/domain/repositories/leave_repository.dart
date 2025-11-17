import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/leave_balance_entity.dart';
import 'package:hiwork_mo/domain/entities/leave_request_entity.dart';

// Hợp đồng cho lớp Data sẽ thực thi
abstract class LeaveRepository {
  // Gửi yêu cầu nghỉ phép mới
  Future<Either<Failure, LeaveRequestEntity>> submitLeaveRequest({
    required DateTime fromDate,
    required DateTime toDate,
    required String leaveType,
    required String reason,
  });

  // Lấy lịch sử yêu cầu nghỉ phép
  Future<Either<Failure, List<LeaveRequestEntity>>> getLeaveHistory();

  // Lấy số dư ngày phép còn lại
  Future<Either<Failure, List<LeaveBalanceEntity>>> getLeaveBalances();
}
