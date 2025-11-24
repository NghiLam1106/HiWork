import 'package:flutter/material.dart';

class CommonWorkSchedulePage extends StatefulWidget {
  const CommonWorkSchedulePage({super.key});

  @override
  State<CommonWorkSchedulePage> createState() => _CommonWorkSchedulePageState();
}

class _CommonWorkSchedulePageState extends State<CommonWorkSchedulePage> {
  final Color primaryBlue = const Color(0xFF1A73E8);
  DateTime selectedDate = DateTime(2025, 11, 3);

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  void _previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  String _formatDate(DateTime date) {
    const weekDays = [
      "Thứ 2",
      "Thứ 3",
      "Thứ 4",
      "Thứ 5",
      "Thứ 6",
      "Thứ 7",
      "Chủ nhật"
    ];
    return "${weekDays[date.weekday - 1]}, "
        "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  Widget _buildShiftBlock({
    required String title,
    required List<Map<String, String>> employees,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề ca
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryBlue,
              ),
            ),
          ),

          // Danh sách nhân viên
          ...employees.map(
            (e) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 0.4),
                ),
              ),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE0E0E0),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Tên + SDT
                  Text(
                    "${e['name']} | ${e['phone']}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Lịch làm việc chung",
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Column(
        children: [
          // Thanh chọn ngày
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.white,
            child: Row(
              children: [
                // Nút back
                IconButton(
                  onPressed: _previousDay,
                  icon: Icon(Icons.arrow_back_ios, size: 18, color: primaryBlue),
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatDate(selectedDate),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                ),

                // Nút next
                IconButton(
                  onPressed: _nextDay,
                  icon: Icon(Icons.arrow_forward_ios,
                      size: 18, color: primaryBlue),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Danh sách ca làm
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Ca sáng
                  _buildShiftBlock(
                    title: "Ca sáng [7:00 - 12:00]",
                    employees: [
                      {"name": "Nghi Lam", "phone": "0905150000"},
                      {"name": "Nghi Lam", "phone": "0905150000"},
                      {"name": "Nghi Lam", "phone": "0905150000"},
                    ],
                  ),

                  // Ca trưa
                  _buildShiftBlock(
                    title: "Ca trưa [12:00 - 17:30]",
                    employees: [
                      {"name": "Nghi Lam", "phone": "0905150000"},
                      {"name": "Nghi Lam", "phone": "0905150000"},
                    ],
                  ),

                  // Ca tối
                  _buildShiftBlock(
                    title: "Ca tối [17:30 - 23:30]",
                    employees: [
                      {"name": "Nghi Lam", "phone": "0905150000"},
                      {"name": "Nghi Lam", "phone": "0905150000"},
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
