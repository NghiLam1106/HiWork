import 'package:equatable/equatable.dart';
import '../../../domain/entities/employee_detail_entity.dart';

abstract class EmployeeDetailState extends Equatable {
  const EmployeeDetailState();

  @override
  List<Object?> get props => [];
}

class EmployeeDetailInitial extends EmployeeDetailState {
  const EmployeeDetailInitial();
}

class EmployeeDetailLoading extends EmployeeDetailState {
  const EmployeeDetailLoading();
}

class EmployeeDetailLoaded extends EmployeeDetailState {
  final EmployeeDetailEntity employee;

  const EmployeeDetailLoaded(this.employee);

  @override
  List<Object?> get props => [employee];
}

class EmployeeDetailError extends EmployeeDetailState {
  final String message;

  const EmployeeDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
