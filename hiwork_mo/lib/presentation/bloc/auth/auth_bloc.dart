import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/domain/entities/user_entity.dart';
import 'package:hiwork_mo/domain/repositories/auth_repository.dart'; 
import 'package:hiwork_mo/domain/usecases/login_usecase.dart'; 
import 'auth_event.dart'; 
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // 2. SỬA TÊN LỚP: Dùng SignInUseCase
  final LogInUseCase logInUseCase;
  final AuthRepository authRepository; 

  AuthBloc({required this.logInUseCase, required this.authRepository})
      : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LogInRequested>(_onLogInRequested);
    on<LogOutRequested>(_onLogOutRequested); 
  }

  // Khởi động: Kiểm tra token/tình trạng xác thực
  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final isAuthenticated = await authRepository.isAuthenticated();
    if (isAuthenticated) {
      emit(const Authenticated(user: UserEntity(
        id: '1', 
        fullName: 'Lâm Nghi', 
        email: 'test@hiwork.com', 
        role: 'Nhân viên', 
        token: 'token'
      )));
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