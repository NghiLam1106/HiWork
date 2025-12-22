import 'package:equatable/equatable.dart';

abstract class EmployeePersonalEditEvent extends Equatable {
  const EmployeePersonalEditEvent();

  @override
  List<Object?> get props => [];
}

class EmployeePersonalEditSubmitted extends EmployeePersonalEditEvent {
  final int id;
  final String name;
  final String address;
  final int gender; // 0/1/2
  final DateTime? dob;
  final String? pickedImagePath;

  const EmployeePersonalEditSubmitted({
    required this.id,
    required this.name,
    required this.address,
    required this.gender,
    this.dob,
    this.pickedImagePath,
  });

  @override
  List<Object?> get props => [id, name, address, gender, dob, pickedImagePath];
}
