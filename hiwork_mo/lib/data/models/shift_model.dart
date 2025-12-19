import 'package:hiwork_mo/domain/entities/shift_details_entity.dart';
class ShiftDetailModel extends ShiftDetailsEntity {
  const ShiftDetailModel({
    required super.idShift,
    required super.shiftName,
    required super.startTime,
    required super.endTime,
  });

  factory ShiftDetailModel.fromJson(Map<String, dynamic> json) {
    return ShiftDetailModel(
      idShift: (json['id'] ?? 0) as int,
      shiftName: (json['name'] ?? '') as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );
  }
}
