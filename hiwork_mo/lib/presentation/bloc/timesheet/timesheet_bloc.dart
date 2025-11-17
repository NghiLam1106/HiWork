import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/domain/usecases/get_weekly_timesheet_usecase.dart';
import 'timesheet_event.dart';
import 'timesheet_state.dart';

// 9. BLoC (Bộ não)
class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  // 1. Phụ thuộc vào UseCase (Tầng Domain)
  final GetWeeklyTimesheetUseCase getWeeklyTimesheetUseCase;
  
  TimesheetBloc({required this.getWeeklyTimesheetUseCase}) : super(TimesheetInitial()) {
    // 2. Đăng ký xử lý cho sự kiện LoadWeeklyTimesheet
    on<LoadWeeklyTimesheet>(_onLoadWeeklyTimesheet);
  }

  // 3. Hàm xử lý khi sự kiện LoadWeeklyTimesheet được gửi đến
  void _onLoadWeeklyTimesheet(LoadWeeklyTimesheet event, Emitter<TimesheetState> emit) async {
    emit(TimesheetLoading()); // Phát trạng thái Đang tải
    
    // 4. Gọi UseCase để lấy dữ liệu
    final result = await getWeeklyTimesheetUseCase.execute(event.weekStartDate);
    
    // 5. Xử lý kết quả trả về từ UseCase (Either<Failure, List>)
    result.fold(
      // Nếu là Left(Failure) -> Phát trạng thái Lỗi
      (failure) => emit(TimesheetError(failure.props.isNotEmpty ? failure.props[0].toString() : 'Lỗi không xác định.')),
      // Nếu là Right(List<Entity>) -> Phát trạng thái Tải xong
      (timesheet) => emit(TimesheetLoaded(timesheet)), 
    );
  }
}