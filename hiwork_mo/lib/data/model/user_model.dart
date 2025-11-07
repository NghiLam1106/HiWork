import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String fullname;
  final String email;
  final String password;

  const UserModel({
    required this.fullname,
    required this.email,
    required this.password,
  });

  factory UserModel.empty() {
    return const UserModel(
      fullname: '',
      email: '',
      password: '',
    );
  }

  UserModel copyWith({
    String? fullname,
    String? email,
    String? password,
  }) {
    return UserModel(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [fullname, email, password];
}
