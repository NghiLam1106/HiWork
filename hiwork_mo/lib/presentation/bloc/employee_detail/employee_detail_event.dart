import 'package:equatable/equatable.dart';

abstract class EmployeeDetailEvent extends Equatable {
  const EmployeeDetailEvent();

  @override
  List<Object?> get props => [];
}

class EmployeeDetailRequested extends EmployeeDetailEvent {
  final int employeeId;

  const EmployeeDetailRequested(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}

class EmployeeDetailRefreshed extends EmployeeDetailEvent {
  final int employeeId;

  const EmployeeDetailRefreshed(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}
