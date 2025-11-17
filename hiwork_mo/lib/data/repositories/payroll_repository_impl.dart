import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/exceptions.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/data/datasources/payroll_remote_datasource.dart';
import 'package:hiwork_mo/domain/entities/payroll_summary_entity.dart';
import 'package:hiwork_mo/domain/entities/payslip_history_entity.dart';
import 'package:hiwork_mo/domain/repositories/payroll_repository.dart';

// 5. Triển khai Repository (Cầu nối Data và Domain)
class PayrollRepositoryImpl implements PayrollRepository {
  final PayrollRemoteDataSource remoteDataSource;

  PayrollRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PayrollSummaryEntity>> getPayrollSummary(int month, int year) async {
    try {
      final summaryModel = await remoteDataSource.getPayrollSummary(month, year);
      return Right(summaryModel); // Trả về Entity (vì Model kế thừa Entity)
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown server error'));
    } on AuthException catch (e) { 
      return Left(AuthFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PayslipHistoryEntity>>> getPayrollHistory(int year) async {
    try {
      final historyModels = await remoteDataSource.getPayrollHistory(year);
      return Right(historyModels); // Trả về List<Entity>
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown server error'));
    } on AuthException catch (e) { 
      return Left(AuthFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}