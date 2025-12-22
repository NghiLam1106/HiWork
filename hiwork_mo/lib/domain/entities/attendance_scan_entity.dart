class AttendanceScan {
  final int id;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? photoUrl;
  final double confidenceScore;
  final int idEmployeeShift;
  final int status; // e.g. "CHECKED_IN", "CHECKED_OUT", "REJECTED"

  const AttendanceScan({
    required this.id,
    required this.checkIn,
    required this.checkOut,
    required this.photoUrl,
    required this.confidenceScore,
    required this.idEmployeeShift,
    required this.status,
  });
}
