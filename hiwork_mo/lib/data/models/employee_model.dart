// Model đại diện cho thông tin cơ bản của một nhân viên
import 'package:hiwork_mo/domain/entities/employee_entity.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String departmentId;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.departmentId,
  });

  // Factory constructor để tạo EmployeeModel từ JSON (ví dụ: từ API/Firestore)
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      departmentId: json['departmentId'] as String,
    );
  }

  // Chuyển đổi EmployeeModel sang JSON (ví dụ: khi lưu vào database)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'departmentId': departmentId,
    };
  }
  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      name: name,
      departmentId: departmentId,
    );
  }
}