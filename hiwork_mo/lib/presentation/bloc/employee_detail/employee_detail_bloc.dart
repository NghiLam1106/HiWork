import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_employee_detail_usecase.dart';
import 'employee_detail_event.dart';
import 'employee_detail_state.dart';

class EmployeeDetailBloc extends Bloc<EmployeeDetailEvent, EmployeeDetailState> {
  final GetEmployeeDetailUseCase getEmployeeDetailUseCase;

  EmployeeDetailBloc({required this.getEmployeeDetailUseCase})
      : super(const EmployeeDetailInitial()) {
    on<EmployeeDetailRequested>(_onRequested);
    on<EmployeeDetailRefreshed>(_onRefreshed);
  }

  Future<void> _fetch(Emitter<EmployeeDetailState> emit) async {
    emit(const EmployeeDetailLoading());
    try {
      final employee = await getEmployeeDetailUseCase(); // ✅ lấy từ storage
      emit(EmployeeDetailLoaded(employee));
    } catch (e) {
      emit(EmployeeDetailError(e.toString()));
    }
  }

  Future<void> _onRequested(
    EmployeeDetailRequested event,
    Emitter<EmployeeDetailState> emit,
  ) async {
    await _fetch(emit);
  }

  Future<void> _onRefreshed(
    EmployeeDetailRefreshed event,
    Emitter<EmployeeDetailState> emit,
  ) async {
    await _fetch(emit);
  }
}
