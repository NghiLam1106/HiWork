import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/shifts_entity.dart';

class ShiftAssignmentModel extends ShiftAssignmentEntity {
  const ShiftAssignmentModel({
    required super.idShiftAssignments,
    required super.idEmployee,
    required super.idShift,
    required super.workDate,
    required super.status,
  });

  /// Factory constructor để tạo một instance [ShiftAssignmentModel] từ JSON.
  factory ShiftAssignmentModel.fromJson(Map<String, dynamic> json) {
    return ShiftAssignmentModel(
      idShiftAssignments: json['idShiftAssignments'] as int,
      idEmployee: json['idEmployee'] as int,
      idShift: json['idShift'] as int,
      workDate: DateTime.parse(json['workDate'] as String),
      status: json['status'] as int,
    );
  }

  /// Phương thức để chuyển đổi instance [ShiftAssignmentModel] thành một Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'idShiftAssignments': idShiftAssignments,
      'idEmployee': idEmployee,
      'idShift': idShift,
      'workDate': workDate.toIso8601String(), // Chuyển DateTime thành chuỗi ISO
      'status': status,
    };
  }
}

class DailyTimesheetModel extends Equatable {
  final DateTime date;
  final List<ShiftAssignmentModel> assignments;

  const DailyTimesheetModel({
    required this.date,
    this.assignments = const [], // Mặc định là danh sách rỗng
  });

  @override
  List<Object?> get props => [date, assignments];

  factory DailyTimesheetModel.fromJson(Map<String, dynamic> json) {
    // Parse danh sách các ca làm từ JSON
    final List<dynamic> assignmentList = json['assignments'] as List;
    final List<ShiftAssignmentModel> parsedAssignments = assignmentList
        .map((item) => ShiftAssignmentModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return DailyTimesheetModel(
      date: DateTime.parse(json['date'] as String),
      assignments: parsedAssignments,
    );
  }

  /// Phương thức để chuyển đổi instance [DailyTimesheetModel] thành JSON.
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      // Chuyển đổi từng item trong list assignments thành JSON
      'assignments': assignments.map((assignment) => assignment.toJson()).toList(),
    };
  }

  DailyTimesheetModel copyWith({
    DateTime? date,
    List<ShiftAssignmentModel>? assignments,
  }) {
    return DailyTimesheetModel(
      date: date ?? this.date,
      assignments: assignments ?? this.assignments,
    );
  }
}
