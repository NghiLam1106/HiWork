import 'package:equatable/equatable.dart';

abstract class EmployeeDetailEvent extends Equatable {
  const EmployeeDetailEvent();

  @override
  List<Object?> get props => [];
}

class EmployeeDetailRequested extends EmployeeDetailEvent {
  const EmployeeDetailRequested();
}

class EmployeeDetailRefreshed extends EmployeeDetailEvent {
  const EmployeeDetailRefreshed();
}
