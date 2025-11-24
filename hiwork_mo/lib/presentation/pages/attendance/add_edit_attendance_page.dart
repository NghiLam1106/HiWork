import 'package:flutter/material.dart';
// Giả sử các widget này đã được định nghĩa
import 'package:hiwork_mo/presentation/widgets/custom_calendar_dialog.dart';
import 'package:hiwork_mo/presentation/widgets/leave_option_picker.dart';

// -------------------------------------------------------------------
// 1. Constants & Styles (Nên đặt trong 1 file theme/constants riêng biệt)
// -------------------------------------------------------------------
const Color primaryBlue = Color(0xFF1A73E8);
const Color borderColor = Color(0xFF1A73E8);

// -------------------------------------------------------------------
// 2. Main Page - State Management
// -------------------------------------------------------------------
class AddEditAttendancePage extends StatefulWidget {
  const AddEditAttendancePage({super.key});

  @override
  State<AddEditAttendancePage> createState() => _AddEditAttendancePageState();
}

class _AddEditAttendancePageState extends State<AddEditAttendancePage> {
  // State variables
  DateTime selectedDate = DateTime.now();
  List<String> selectedShiftIds = []; // Dùng ID ca làm việc (Shift ID)
  TimeOfDay? selectedCheckInTime;
  TimeOfDay? selectedCheckOutTime;
  final TextEditingController noteController = TextEditingController();

  // Loading state cho nút Submit
  bool _isLoading = false;

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  // ============================================================
  // ACTION HANDLERS
  // ============================================================

  /// Xử lý chọn ngày
  Future<void> _pickDate() async {
    final result = await showDialog<DateTime>(
      context: context,
      builder: (_) => CustomCalendarDialog(initialDate: selectedDate),
    );

    if (result != null) {
      setState(() => selectedDate = result);
    }
  }

  /// Xử lý chọn giờ (Check-in/Check-out)
  Future<void> _pickTime({
    required TimeOfDay? initialTime,
    required Function(TimeOfDay) onSelected,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        // Tùy chỉnh màu sắc TimePicker
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryBlue,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onSelected(picked);
    }
  }

  /// Xử lý chọn ca làm việc
  void _openShiftPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => LeaveOptionPicker(
        initialValues: selectedShiftIds,
        onSelected: (values) {
          setState(() => selectedShiftIds = values);
          // TODO: Load lại giờ check-in/out gợi ý dựa trên ca đã chọn
        },
      ),
    );
  }

  /// Xử lý gửi yêu cầu
  void _handleSubmit() async {
    // 1. Validate dữ liệu
    if (selectedShiftIds.isEmpty ||
        selectedCheckInTime == null ||
        selectedCheckOutTime == null ||
        noteController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Vui lòng điền đầy đủ thông tin bắt buộc.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 2. Tạo đối tượng dữ liệu (sẽ dùng AttendanceCorrectionModel từ Data Layer)
      // Giả sử có một hàm submitCorrection(data) trong Logic Layer (BLoC/Cubit)
      // final correctionData = AttendanceCorrectionModel(
      //   employeeId: 'current_user_id', // Cần lấy từ auth
      //   workDate: selectedDate,
      //   shiftIds: selectedShiftIds,
      //   checkIn: selectedCheckInTime!,
      //   checkOut: selectedCheckOutTime!,
      //   notes: noteController.text.trim(),
      // );

      // 3. Gọi API (Mock delay)
      await Future.delayed(const Duration(seconds: 2));
      
      // 4. Xử lý thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Yêu cầu bổ sung đã được gửi thành công!')),
      );
      Navigator.pop(context); // Quay lại màn hình trước
    } catch (e) {
      // 5. Xử lý lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Gửi yêu cầu thất bại. Vui lòng thử lại. Lỗi: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // ============================================================
  // REUSABLE WIDGETS
  // ============================================================

  /// Khung Input chung
  Widget _buildInputContainer({
    required Widget child,
    VoidCallback? onTap,
    bool isReadOnly = false,
  }) {
    // Dùng InkWell cho phép nhấn vào toàn bộ khung
    final container = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: isReadOnly ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: container,
      );
    }
    return container;
  }

  /// Input Field cho Text, Date, Shift
  Widget _buildInputField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return _buildInputContainer(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style:
                      const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: value.contains("Chọn") || value.contains("Nhập")
                      ? Colors.black54
                      : Colors.black87,
                ),
              ),
            ],
          ),
          Icon(icon, color: Colors.black54),
        ],
      ),
    );
  }

  /// Text Input (Sử dụng cho Ghi chú)
  Widget _buildNoteInput() {
    return Container(
      height: 100, // Chiều cao cố định cho Ghi chú
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: noteController,
        maxLines: 3,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Ghi chú",
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  // ============================================================
  // UTIL
  // ============================================================

  /// Format Date
  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  /// Format Time
  String _formatTime(TimeOfDay? time) {
    if (time == null) return "Chọn giờ";
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}";
  }

  /// Convert Shift ID to readable name (Mock logic)
  String _convertShiftIdToName(List<String> ids) {
    if (ids.isEmpty) return "Chọn ca làm việc";
    // Giả sử chỉ chọn 1 ca
    final id = ids.first;
    switch (id) {
      case "S1":
        return "Ca sáng (8:00 - 12:00)";
      case "S2":
        return "Ca chiều (13:00 - 17:00)";
      default:
        return "Ca khác ($id)";
    }
  }

  // ============================================================
  // UI Build Method
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Bổ sung/ sửa chấm công",
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 1. CHỌN NGÀY
            _buildInputField(
              label: "Chọn ngày chấm công",
              value: _formatDate(selectedDate),
              icon: Icons.calendar_today,
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),

            // 2. CHỌN CA LÀM VIỆC
            _buildInputField(
              label: "Chọn ca làm việc",
              value: _convertShiftIdToName(selectedShiftIds),
              icon: Icons.arrow_drop_down,
              onTap: _openShiftPicker,
            ),
            const SizedBox(height: 16),

            // 3. GIỜ BẮT ĐẦU (Check-in)
            _buildInputField(
              label: "Giờ bắt đầu",
              value: _formatTime(selectedCheckInTime),
              icon: Icons.access_time,
              onTap: () => _pickTime(
                initialTime: selectedCheckInTime,
                onSelected: (time) =>
                    setState(() => selectedCheckInTime = time),
              ),
            ),
            const SizedBox(height: 16),

            // 4. GIỜ KẾT THÚC (Check-out)
            _buildInputField(
              label: "Giờ kết thúc",
              value: _formatTime(selectedCheckOutTime),
              icon: Icons.access_time,
              onTap: () => _pickTime(
                initialTime: selectedCheckOutTime,
                onSelected: (time) =>
                    setState(() => selectedCheckOutTime = time),
              ),
            ),
            const SizedBox(height: 16),

            // 5. GHI CHÚ
            _buildNoteInput(),
            const SizedBox(height: 40),

            // 6. SUBMIT BUTTON
            _buildSubmitButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Nút Gửi bổ sung
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _isLoading ? null : _handleSubmit, // Disable khi đang loading
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Text(
                "Gửi bổ sung",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}