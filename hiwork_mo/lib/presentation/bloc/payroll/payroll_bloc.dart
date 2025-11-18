import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart'; // Import dartz
import 'package:hiwork_mo/core/error/failures.dart'; // Import Failures
import 'package:hiwork_mo/domain/entities/payroll_summary_entity.dart';
import 'package:hiwork_mo/domain/entities/payslip_history_entity.dart';
import 'package:hiwork_mo/domain/usecases/get_payroll_history_usecase.dart';
import 'package:hiwork_mo/domain/usecases/get_payroll_summary_usecase.dart';
import 'package:hiwork_mo/presentation/bloc/payroll/payroll_event.dart'; // Import Event
import 'package:hiwork_mo/presentation/bloc/payroll/payroll_state.dart'; // Import State

// 9. BLoC (Bộ não)
class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  // 1. Phụ thuộc vào cả 2 UseCase (Tầng Domain)
  final GetPayrollSummaryUseCase getPayrollSummaryUseCase;
  final GetPayrollHistoryUseCase getPayrollHistoryUseCase;
  
  PayrollBloc({
    required this.getPayrollSummaryUseCase,
    required this.getPayrollHistoryUseCase
  }) : super(PayrollInitial()) {
    // 2. Đăng ký xử lý cho sự kiện LoadPayrollData
    on<LoadPayrollData>(_onLoadPayrollData);
  }

  // 3. Hàm xử lý khi sự kiện LoadPayrollData được gửi đến
  void _onLoadPayrollData(LoadPayrollData event, Emitter<PayrollState> emit) async {
    emit(PayrollLoading()); // Phát trạng thái Đang tải
    
    // 4. Gọi cả 2 UseCase song song (dùng Future.wait)
    final results = await Future.wait([
      getPayrollSummaryUseCase.execute(event.month, event.year),
      getPayrollHistoryUseCase.execute(event.year),
    ]);

    // Lấy kết quả
    final summaryResult = results[0] as Either<Failure, PayrollSummaryEntity>;
    final historyResult = results[1] as Either<Failure, List<PayslipHistoryEntity>>;
    
    // 5. Xử lý kết quả (dùng nested fold)
    summaryResult.fold(
      (summaryFailure) {
        // Nếu Tải Summary thất bại -> Báo lỗi
        emit(PayrollError(summaryFailure.props.isNotEmpty ? summaryFailure.props[0].toString() : 'Lỗi tải Tổng hợp Lương.'));
      },
      (summary) {
        // Nếu Tải Summary thành công -> Kiểm tra History
        historyResult.fold(
          (historyFailure) {
            // Nếu Tải History thất bại -> Báo lỗi
            emit(PayrollError(historyFailure.props.isNotEmpty ? historyFailure.props[0].toString() : 'Lỗi tải Lịch sử Lương.'));
          },
          (history) {
            // Nếu CẢ HAI thành công -> Phát trạng thái Tải xong
            emit(PayrollLoaded(summary: summary, history: history));
          },
        );
      },
    );
  }
}