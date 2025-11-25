import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/domain/entities/user_entity.dart';
import 'package:hiwork_mo/domain/repositories/auth_repository.dart';
import 'package:hiwork_mo/domain/usecases/login_usecase.dart';
import 'package:hiwork_mo/domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogInUseCase logInUseCase;
  final RegisterUsecase registerUseCase;
  final AuthRepository authRepository;

  AuthBloc({required this.logInUseCase, required this.registerUseCase, required this.authRepository})
      : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LogInRequested>(_onLogInRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogOutRequested>(_onLogOutRequested);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final isAuthenticated = await authRepository.isAuthenticated();
    if (isAuthenticated) {
      emit(const Authenticated(user: UserEntity(id: 0, fullName: '', email: '', role: '', token: '')));
    } else {
      emit(Unauthenticated());
    }
  }

  void _onLogInRequested(LogInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logInUseCase.execute(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.props.isNotEmpty ? failure.props[0].toString() : 'Lỗi đăng nhập không xác định.')),
      (user) => emit(Authenticated(user: user)),
    );
  }

  // 6. XỬ LÝ SỰ KIỆN ĐĂNG KÝ (ĐÃ THÊM HÀM MỚI)
  void _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUseCase.execute(
      username: event.username,
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.props.isNotEmpty ? failure.props[0].toString() : 'Lỗi đăng ký không xác định.')),
      (_) => emit((Unauthenticated()))
    );
  }

  // 7. SỬA TÊN HÀM VÀ EVENT: Dùng SignOutRequested
  void _onLogOutRequested(LogOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.signOut();
    result.fold(
      (failure) => emit(const AuthError(message: 'Lỗi đăng xuất')),
      (_) => emit(Unauthenticated()),
    );
  }
}
