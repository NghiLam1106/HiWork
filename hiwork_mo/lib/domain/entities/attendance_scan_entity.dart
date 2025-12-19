class AttendanceScan {
  final int id;
  final int idEmployee;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? photoUrl;
  final double confidenceScore;
  final int idShift;
  final String status; // e.g. "CHECKED_IN", "CHECKED_OUT", "REJECTED"

  const AttendanceScan({
    required this.id,
    required this.idEmployee,
    required this.checkIn,
    required this.checkOut,
    required this.photoUrl,
    required this.confidenceScore,
    required this.idShift,
    required this.status,
  });
}
