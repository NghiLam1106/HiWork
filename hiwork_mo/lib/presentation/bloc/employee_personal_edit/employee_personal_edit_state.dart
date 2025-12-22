import 'package:equatable/equatable.dart';

class EmployeePersonalEditState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const EmployeePersonalEditState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  EmployeePersonalEditState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return EmployeePersonalEditState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}
