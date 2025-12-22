class ApiUrl {
  // --------------------- PATHS --------------------- //
  // static const String baseUrl = "http://10.0.2.2:3001/api/user"; // Dùng cho Android Emulator
  static const String baseUrl = "http://192.168.1.4:3001/api/user";
  // static const String baseUrl = "http://localhost:3001/api/user";

  // --------------------- AUTH --------------------- //
  static const String auth = "$baseUrl/auth";

  // --------------------- SHIFTS --------------------- //
  static const String lichLamViec = "$baseUrl/lich-lam-viec";

  // --------------------- EMPLOYEES --------------------- //
  static const String employees = "$baseUrl/employees";

  // --------------------- ATTENDANCE --------------------- //
  static const String attendance = "$baseUrl/cham-cong";
}
