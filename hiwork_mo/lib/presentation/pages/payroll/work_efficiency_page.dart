import 'package:flutter/material.dart';
import 'package:hiwork_mo/presentation/pages/payroll/daily_detail_page.dart';
import 'package:intl/intl.dart';

class WorkEfficiencyPage extends StatefulWidget {
  const WorkEfficiencyPage({super.key});

  @override
  State<WorkEfficiencyPage> createState() => _WorkEfficiencyPageState();
}

class _WorkEfficiencyPageState extends State<WorkEfficiencyPage> {
  DateTime currentMonth = DateTime(2025, 11, 1);

  /// kiểm tra có phải tháng hiện tại không
  bool isCurrentMonth() {
    final now = DateTime.now();
    return currentMonth.year == now.year && currentMonth.month == now.month;
  }

  /// ngày đầu tháng
  String getStartOfMonth() {
    return DateFormat("dd/MM/yyyy").format(currentMonth);
  }

  /// ngày cuối tháng
  String getEndOfMonth() {
    final lastDay = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    return DateFormat("dd/MM/yyyy").format(lastDay);
  }

  /// lùi tháng
  void goToPreviousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
    });
  }

  /// tới tháng sau
  void goToNextMonth() {
    if (!isCurrentMonth()) {
      setState(() {
        currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      body: SafeArea(
        child: Column(
          children: [
            // ------------------ HEADER ------------------
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: Color(0xFF1A73E8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Hiệu quả làm việc",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A73E8),
                    ),
                  ),
                ],
              ),
            ),

            // ------------------ DATE RANGE + BUTTONS ------------------
            Container(height: 0.5, color: Colors.black26),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // nút lùi tháng
                  GestureDetector(
                    onTap: goToPreviousMonth,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5E9F0),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios, size: 18),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ngày tháng
                  Text(
                    "${getStartOfMonth()} - ${getEndOfMonth()}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // nút tiến tháng — chỉ hiện nếu KHÔNG phải tháng hiện tại
                  if (!isCurrentMonth())
                    GestureDetector(
                      onTap: goToNextMonth,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5E9F0),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward_ios, size: 18),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ------------------ CARD 1 ------------------
            _InfoCard(
              children: const [
                _InfoRow("Số giờ làm việc được phân công", "39.0"),
                _InfoRow("Số ca làm việc được phân công", "7"),
                _InfoRow("Số giờ làm việc tính lương", "33.8"),
                _InfoRow("Số ca làm việc tính lương", "6"),
              ],
            ),

            const SizedBox(height: 12),

            // ------------------ CARD 2 ------------------
            _InfoCard(
              children: const [
                _InfoRow("Số lần đi muộn không phép", "0"),
                _InfoRow("Thời gian đi muộn không phép", "0 phút - 0.0 giờ"),
                _InfoRow("Số lần về sớm không phép", "3"),
                _InfoRow("Thời gian về sớm không phép", "72 phút - 1.2 giờ"),
                _InfoRow("Số ca xin nghỉ trong tháng", "0"),
              ],
            ),

            const Spacer(),

            // ------------------ BUTTON ------------------
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DailyDetailPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Xem chi tiết",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE1E6ED)),
      ),
      child: Column(
        children:
            children
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: e,
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              // fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
