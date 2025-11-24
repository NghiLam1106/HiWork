// Entity đại diện cho thông tin cơ bản của một nhân viên (Domain Layer)
// KHÔNG chứa các thư viện tầng Data/Presentation như IconData hay Map functions
class EmployeeEntity {
  final String id;
  final String name;
  final String departmentId;

  const EmployeeEntity({
    required this.id,
    required this.name,
    required this.departmentId,
  });

  // Phương thức copyWith giúp thay đổi một phần Entity mà không cần khởi tạo lại
  EmployeeEntity copyWith({
    String? id,
    String? name,
    String? departmentId,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      departmentId: departmentId ?? this.departmentId,
    );
  }
}