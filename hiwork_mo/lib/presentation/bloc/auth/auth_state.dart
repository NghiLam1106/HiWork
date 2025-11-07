import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/data/model/user_model.dart';

class AuthState extends Equatable {
  final UserModel registerUser;     // full name, email, pass
  final String confirmPassword;

  final String loginEmail;
  final String loginPassword;

  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? errorMessage;

  const AuthState({
    required this.registerUser,
    required this.confirmPassword,
    required this.loginEmail,
    required this.loginPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.errorMessage,
  });

  factory AuthState.initial() {
    return AuthState(
      registerUser: UserModel.empty(),
      confirmPassword: '',
      loginEmail: '',
      loginPassword: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: null,
    );
  }

  AuthState copyWith({
    UserModel? registerUser,
    String? confirmPassword,
    String? loginEmail,
    String? loginPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
  }) {
    return AuthState(
      registerUser: registerUser ?? this.registerUser,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      loginEmail: loginEmail ?? this.loginEmail,
      loginPassword: loginPassword ?? this.loginPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        registerUser,
        confirmPassword,
        loginEmail,
        loginPassword,
        isSubmitting,
        isSuccess,
        isFailure,
        errorMessage,
      ];
}
