import 'package:flutter/material.dart';

class CustomCalendarDialog extends StatefulWidget {
  const CustomCalendarDialog({super.key, required DateTime initialDate});

  @override
  State<CustomCalendarDialog> createState() => _CustomCalendarDialogState();
}

class _CustomCalendarDialogState extends State<CustomCalendarDialog> {
  DateTime selectedDate = DateTime.now();
  late int year = selectedDate.year;
  late int month = selectedDate.month;

  // ---------------- kiểm tra có được chọn không (từ hôm nay trở đi) ----------------
  bool _isSelectable(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(day.year, day.month, day.day);
    return d.isAtSameMomentAs(today) || d.isAfter(today);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 350,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildWeekdays(),
            const SizedBox(height: 8),
            _buildCalendarGrid(),
            const SizedBox(height: 16),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ------------------
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Tháng $month $year",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (month == 1) {
                    month = 12;
                    year--;
                  } else {
                    month--;
                  }
                });
              },
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (month == 12) {
                    month = 1;
                    year++;
                  } else {
                    month++;
                  }
                });
              },
              child: const Icon(Icons.chevron_right, color: Colors.black),
            ),
          ],
        )
      ],
    );
  }

  // ---------------- WEEKDAYS ------------------
  Widget _buildWeekdays() {
    const days = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days
          .map(
            (d) => SizedBox(
              width: 36,
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontSize: 14,
                    color: d == "T6" ? Colors.blue : Colors.black87,
                    fontWeight: d == "T6" ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // ---------------- GRID ------------------
  Widget _buildCalendarGrid() {
    // Số ngày trong tháng
    int daysInMonth = DateTime(year, month + 1, 0).day;
    // weekday của ngày 1 (Mon = 1 ... Sun = 7)
    int firstWeekday = DateTime(year, month, 1).weekday;

    List<Widget> dayWidgets = [];

    // Thêm ô trống trước ngày 1 (số ô = firstWeekday - 1)
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox(width: 36, height: 36));
    }

    // Thêm các ngày
    for (int day = 1; day <= daysInMonth; day++) {
      dayWidgets.add(_buildDayItem(day));
    }

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 7,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1,
      children: dayWidgets,
    );
  }

  // ---------------- 1 Ô NGÀY (đã tích hợp disable ngày quá khứ) ------------------
  Widget _buildDayItem(int day) {
    DateTime date = DateTime(year, month, day);

    bool isSelected =
        date.day == selectedDate.day &&
            date.month == selectedDate.month &&
            date.year == selectedDate.year;

    bool isWeekend = date.weekday == 6 || date.weekday == 7;

    bool isEnabled = _isSelectable(date); // <-- dùng hàm ở trên

    return GestureDetector(
      onTap: isEnabled ? () => setState(() => selectedDate = date) : null,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E88E5) : const Color(0xFFE8ECF2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "$day",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: !isEnabled
                  ? Colors.grey
                  : (isSelected ? Colors.white : (isWeekend ? Colors.red : Colors.black87)),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- BUTTONS ------------------
  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Hủy", style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, selectedDate),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text("Đồng ý"),
        ),
      ],
    );
  }
}
