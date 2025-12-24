import 'package:hiwork_mo/domain/entities/shift_details_entity.dart';
class ShiftDetailModel extends ShiftDetailsEntity {
  const ShiftDetailModel({
    required super.idShift,
    required super.name,
    required super.startTime,
    required super.endTime,
  });

  factory ShiftDetailModel.fromJson(Map<String, dynamic> json) {
    return ShiftDetailModel(
      idShift: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
      startTime: (json['startTime'] ?? '') as String,
      endTime: (json['endTime'] ?? '') as String,
    );
  }
}
