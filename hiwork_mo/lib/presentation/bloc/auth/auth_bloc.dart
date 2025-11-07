import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/core/api/api_client.dart';
import 'package:hiwork_mo/data/repository/auth/auth_repository.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final AppLocalizations l10n;

  AuthBloc(this._authRepository, this.l10n) : super(AuthState.initial()) {
    // ==== REGISTER INPUT ==== //
    on<RegisterFullnameChanged>((event, emit) {
      emit(
        state.copyWith(
          registerUser: state.registerUser.copyWith(fullname: event.fullname),
        ),
      );
    });

    on<RegisterEmailChanged>((event, emit) {
      emit(
        state.copyWith(
          registerUser: state.registerUser.copyWith(email: event.email),
        ),
      );
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          registerUser: state.registerUser.copyWith(password: event.password),
        ),
      );
    });

    on<RegisterConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    // ==== LOGIN INPUT ==== //
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(loginEmail: event.email));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(loginPassword: event.password));
    });

    // ==== REGISTER SUBMIT ==== //
    on<RegisterSubmitted>((event, emit) async {
      emit(
        state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false),
      );

      final user = state.registerUser;

      if (user.email.isEmpty || !user.email.contains('@')) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isFailure: true,
            errorMessage: l10n.emailError,
          ),
        );
        return;
      }

      if (user.password.length < 6) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isFailure: true,
            errorMessage: l10n.passwordLength,
          ),
        );
        return;
      }

      if (user.password != state.confirmPassword) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isFailure: true,
            errorMessage: l10n.passwordConfirm,
          ),
        );
        return;
      }

      try {
        bool result = await _authRepository.register(user);
        if (result) {
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
        } else {
          emit(
            state.copyWith(
              isSubmitting: false,
              isFailure: true,
              errorMessage: 'Đăng ký thất bại!',
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isFailure: true,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    // ==== LOGIN SUBMIT ==== //
    on<LoginSubmitted>((event, emit) async {
      emit(
        state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false),
      );

      final email = state.loginEmail;
      final password = state.loginPassword;

      try {
        bool result = await _authRepository.login(email, password);
        if (result) {
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
        } else {
          emit(
            state.copyWith(
              isSubmitting: false,
              isFailure: true,
              errorMessage: 'Đăng nhập thất bại!',
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isFailure: true,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
