import 'package:flutter/material.dart';
import 'package:hiwork_mo/presentation/widgets/custom_calendar_dialog.dart';
import 'package:hiwork_mo/presentation/widgets/leave_option_picker.dart';

class RegisterWorkSchedulePage extends StatefulWidget {
  const RegisterWorkSchedulePage({super.key});

  @override
  State<RegisterWorkSchedulePage> createState() =>
      _RegisterWorkSchedulePageState();
}

class _RegisterWorkSchedulePageState extends State<RegisterWorkSchedulePage> {
  final Color primaryBlue = const Color(0xFF1A73E8);

  DateTime? selectedDate;
  List<String> selectedShift = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: _buildAppBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 20),

            _buildDatePicker(
              label: "Ngày làm việc",
              date: selectedDate,
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),

            _buildShiftSelector(
              label: "Ca làm",
              values: selectedShift,
              onTap: _openShiftPicker,
            ),
            const SizedBox(height: 40),

            _buildSubmitButton(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: primaryBlue),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Đăng ký lịch làm việc",
        style: TextStyle(
          color: primaryBlue,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }

  // ---------------- DATE PICKER ----------------
  Widget _buildDatePicker({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryBlue, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                  date != null ? _formatDate(date) : "Chọn ngày",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(Icons.calendar_today, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  // ---------------- SHIFT PICKER ----------------
  Widget _buildShiftSelector({
    required String label,
    required List<String> values,
    required VoidCallback onTap,
  }) {
    final isPlaceholder = values.isEmpty;
    final displayText = values.isEmpty
        ? "Chọn ca làm"
        : values.map(_convertShift).join(", ");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryBlue, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isPlaceholder ? Colors.black54 : Colors.black87,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  // ---------------- SUBMIT BUTTON ----------------
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
        onPressed: () {},
        child: const Text(
          "Gửi đăng ký",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ---------------- ACTIONS ----------------
  Future<void> _pickDate() async {
  final result = await showDialog<DateTime>(
    context: context,
    builder: (_) => CustomCalendarDialog(
initialDate: selectedDate ?? DateTime.now(),
    ),
  );

  if (result != null) {
    setState(() => selectedDate = result);
  }
}

  void _openShiftPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => LeaveOptionPicker(
        initialValues: selectedShift,
        onSelected: (values) {
          setState(() => selectedShift = values);
        },
      ),
    );
  }

  // ---------------- UTIL ----------------
  String _convertShift(String v) {
    switch (v) {
      case "morning":
        return "Ca sáng";
      case "noon":
        return "Ca trưa";
      case "night":
        return "Ca tối";
    }
    return "";
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
