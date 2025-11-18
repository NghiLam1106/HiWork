import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/data/datasources/leave_remote_datasource.dart';
import 'package:hiwork_mo/domain/entities/leave_balance_entity.dart';
import 'package:hiwork_mo/domain/entities/leave_request_entity.dart';
import 'package:hiwork_mo/domain/repositories/leave_repository.dart';

// 5. Triển khai Repository (Cầu nối Data và Domain)
class LeaveRepositoryImpl implements LeaveRepository {
  final LeaveRemoteDataSource remoteDataSource;

  LeaveRepositoryImpl({required this.remoteDataSource});

  // (Hàm helper xử lý lỗi của bạn)
  Future<Either<Failure, T>> _handleFailure<T>(
    Future<T> Function() call,
  ) async {
    try {
      final result = await call();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Lỗi máy chủ không xác định.'));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? 'Lỗi xác thực không xác định.'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: 'Lỗi không xác định: ${e.toString()}'));
    }
  }


  @override
  Future<Either<Failure, List<LeaveBalanceEntity>>> getLeaveBalances() async {
    // --- 1. SỬA LỖI Ở ĐÂY ---
    // Chúng ta gọi hàm helper, nhưng BÊN TRONG hàm gọi, chúng ta
    // ép kiểu List<Model> thành List<Entity> bằng List.from()
    return _handleFailure(() async {
      final models = await remoteDataSource.getLeaveBalances();
      // Dòng này (List.from) sẽ sửa lỗi runtime (Covariance)
      return List<LeaveBalanceEntity>.from(models); 
    });
    // --- (Kết thúc sửa lỗi) ---
  }

  @override
  Future<Either<Failure, List<LeaveRequestEntity>>> getLeaveHistory() async {
    // --- 2. SỬA LỖI Ở ĐÂY (Tương tự) ---
    return _handleFailure(() async {
      final models = await remoteDataSource.getLeaveHistory();
      // Dòng này (List.from) sẽ sửa lỗi runtime
      return List<LeaveRequestEntity>.from(models);
    });
    // --- (Kết thúc sửa lỗi) ---
  }

  @override
  Future<Either<Failure, LeaveRequestEntity >> submitLeaveRequest({
    required DateTime fromDate,
    required DateTime toDate,
    required String leaveType,
    required String reason,
  }) async {
    // (Hàm này đã đúng, không trả về List nên không bị lỗi Covariance)
    return _handleFailure(() => remoteDataSource.submitLeaveRequest(
          fromDate: fromDate,
          toDate: toDate,
          leaveType: leaveType,
          reason: reason,
        ));
  }
}