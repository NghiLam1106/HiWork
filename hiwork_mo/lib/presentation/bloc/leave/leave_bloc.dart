import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/domain/usecases/get_leave_balance_usecase.dart';
import 'package:hiwork_mo/domain/usecases/get_leave_history_usecase.dart';
import 'package:hiwork_mo/domain/usecases/submit_leave_request_usecase.dart';
import 'leave_event.dart';
import 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  // 1. Phụ thuộc vào cả 3 UseCase
  final GetLeaveBalanceUseCase getLeaveBalanceUseCase;
  final GetLeaveHistoryUseCase getLeaveHistoryUseCase;
  final SubmitLeaveUseCase submitLeaveUseCase;
  
  LeaveBloc({
    required this.getLeaveBalanceUseCase,
    required this.getLeaveHistoryUseCase,
    required this.submitLeaveUseCase,
  }) : super(LeaveInitial()) {
    // 2. Đăng ký xử lý cho các sự kiện
    on<LoadLeaveData>(_onLoadLeaveData);
    on<SubmitLeaveRequest>(_onSubmitLeaveRequest);
  }

  // 3. Hàm xử lý khi Tải dữ liệu
  void _onLoadLeaveData(LoadLeaveData event, Emitter<LeaveState> emit) async {
    emit(LeaveLoading());
    
    // Gọi cả 2 UseCase (ví dụ: dùng Future.wait)
    final balanceResult = await getLeaveBalanceUseCase.execute();
    final historyResult = await getLeaveHistoryUseCase.execute();

    // Xử lý kết quả
    balanceResult.fold(
      (failure) => emit(LeaveError(failure.props.isNotEmpty ? failure.props[0].toString() : 'Lỗi tải số dư phép.')),
      (balances) {
        historyResult.fold(
          (failure) => emit(LeaveError(failure.props.isNotEmpty ? failure.props[0].toString() : 'Lỗi tải lịch sử nghỉ.')),
          (history) {
            // Nếu cả 2 thành công
            emit(LeaveLoaded(balances: balances, history: history));
          },
        );
      },
    );
  }

  // 4. Hàm xử lý khi Gửi Form
  void _onSubmitLeaveRequest(SubmitLeaveRequest event, Emitter<LeaveState> emit) async {
    emit(LeaveSubmissionInProgress());
    
    final result = await submitLeaveUseCase.execute(
      fromDate: event.fromDate,
      toDate: event.toDate,
      leaveType: event.leaveType,
      reason: event.reason,
    );
    
    result.fold(
      (failure) => emit(LeaveError(failure.props.isNotEmpty ? failure.props[0].toString() : 'Lỗi gửi yêu cầu.')),
      (_) {
        emit(LeaveSubmissionSuccess());
        // Tùy chọn: Tải lại dữ liệu sau khi gửi thành công
        add(LoadLeaveData()); 
      },
    );
  }
}