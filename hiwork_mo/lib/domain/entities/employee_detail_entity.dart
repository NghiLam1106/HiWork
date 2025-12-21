import 'package:equatable/equatable.dart';

class EmployeeDetailEntity extends Equatable {
  final int id;
  final String name;
  final String phone;
  final int gender;           // 0: Nữ, 1: Nam (hoặc theo quy ước hệ thống)
  final String address;
  final String? avatarUrl;
  final String? faceEmbedding;
  final String? imageCheck;
  final int status;           // 0: inactive, 1: active
  final int positionId;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EmployeeDetailEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.gender,
    required this.address,
    this.avatarUrl,
    this.faceEmbedding,
    this.imageCheck,
    required this.status,
    required this.positionId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        gender,
        address,
        avatarUrl,
        faceEmbedding,
        imageCheck,
        status,
        positionId,
        userId,
        createdAt,
        updatedAt,
      ];
}
