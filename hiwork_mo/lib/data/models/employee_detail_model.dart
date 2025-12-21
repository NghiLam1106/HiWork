import '../../domain/entities/employee_detail_entity.dart';

class EmployeeDetailModel extends EmployeeDetailEntity {
  const EmployeeDetailModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.gender,
    required super.address,
    super.avatarUrl,
    super.faceEmbedding,
    super.imageCheck,
    required super.status,
    required super.positionId,
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EmployeeDetailModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      gender: json['gender'],
      address: json['address'],
      avatarUrl: json['avatar_url'],
      faceEmbedding: json['face_embedding'],
      imageCheck: json['image_check'],
      status: json['status'],
      positionId: json['position_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'gender': gender,
      'address': address,
      'avatar_url': avatarUrl,
      'face_embedding': faceEmbedding,
      'image_check': imageCheck,
      'status': status,
      'position_id': positionId,
      'user_id': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
