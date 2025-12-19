
import 'package:hiwork_mo/domain/entities/attendance_scan_entity.dart';

class AttendanceScanModel extends AttendanceScan {
  const AttendanceScanModel({
    required super.id,
    required super.idEmployee,
    required super.checkIn,
    required super.checkOut,
    required super.photoUrl,
    required super.confidenceScore,
    required super.idShift,
    required super.status,
  });

  factory AttendanceScanModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(dynamic v) => v == null ? null : DateTime.tryParse(v.toString());

    return AttendanceScanModel(
      id: (json['id'] ?? 0) as int,
      idEmployee: (json['id_employee'] ?? 0) as int,
      checkIn: parseDt(json['check_in']),
      checkOut: parseDt(json['check_out']),
      photoUrl: json['photo_url'] as String?,
      confidenceScore: (json['confidence_score'] is num)
          ? (json['confidence_score'] as num).toDouble()
          : double.tryParse(json['confidence_score']?.toString() ?? '0') ?? 0,
      idShift: (json['id_shift'] ?? 0) as int,
      status: (json['status'] ?? '') as String,
    );
  }
}
