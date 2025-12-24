import 'package:flutter/widgets.dart';

import '../../domain/entities/employee_detail_entity.dart';

class EmployeeDetailModel extends EmployeeDetailEntity {
  const EmployeeDetailModel({
    required super.id,
    super.name,
    super.phone,
    super.gender,
    super.address,
    super.avatarUrl,
    super.faceEmbedding,
    super.imageCheck,
    super.status,
    super.positionId,
    super.userId,
    super.dayOfBirth,
  });

  static int? _toInt(dynamic v) =>
      v == null ? null : int.tryParse(v.toString());

  factory EmployeeDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['employee'] ?? json;
    return EmployeeDetailModel(
      id: _toInt(data['id']) ?? 0,
      name: data['name'],
      phone: data['phone'],
      gender: _toInt(data['gender']),
      address: data['address'],
      avatarUrl: data['avatar_url'],
      faceEmbedding: data['face_embedding'],
      imageCheck: data['image_check'],
      status: _toInt(data['status']),
      positionId: data['position_id'],
      userId: _toInt(data['user_id']),
      dayOfBirth:
          data['date_of_birth'] != null
              ? DateTime.tryParse(data['date_of_birth'].toString())
              : null,
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
      'date_of_birth': dayOfBirth?.toIso8601String(),
    };
  }
}
