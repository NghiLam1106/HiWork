import 'package:hiwork_mo/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  const UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      fullName: name,
      email: email,
      role: '',
      token: '',
    );
  }
}
