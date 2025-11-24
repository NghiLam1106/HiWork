import 'package:flutter/material.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart';

class WorkRegisterEntity {
  final DateTime date;
  final List<String> shifts; // ["morning", "noon"]
  final String status; // approved / pending / rejected

  WorkRegisterEntity({
    required this.date,
    required this.shifts,
    required this.status,
  });
}

// ==== TRANG LỊCH SỬ ĐĂNG KÝ LÀM VIỆC ====
class WorkHistoryRegisterPage extends StatefulWidget {
  const WorkHistoryRegisterPage({super.key});

  @override
  State<WorkHistoryRegisterPage> createState() =>
      _WorkHistoryRegisterPageState();
}

class _WorkHistoryRegisterPageState extends State<WorkHistoryRegisterPage> {
  final Color primaryBlue = const Color(0xFF1A73E8);

  final List<WorkRegisterEntity> demoHistory = [
    WorkRegisterEntity(
      date: DateTime(2025, 11, 3),
      shifts: ["morning", "noon"],
      status: "approved",
    ),
    WorkRegisterEntity(
      date: DateTime(2025, 11, 4),
      shifts: ["night"],
      status: "pending",
    ),
    WorkRegisterEntity(
      date: DateTime(2025, 11, 5),
      shifts: ["noon"],
      status: "rejected",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE6ECF4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Danh sách đăng ký làm việc",
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      body: Column(
        children: [
          Container(height: 0.5, color: Colors.black26),

          /// Header chọn tháng
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E5EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Tháng 11/2025",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),

          Expanded(
            child: demoHistory.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: demoHistory.length,
                    itemBuilder: (_, i) =>
                        _WorkHistoryCard(item: demoHistory[i]),
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.registerWorkSchedule);
        },
        backgroundColor: primaryBlue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmpty() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.format_quote, size: 36, color: Colors.grey),
            SizedBox(height: 4),
            Text(
              "Chưa có đăng ký lịch làm việc...",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// ====================== CARD LỊCH SỬ =========================
class _WorkHistoryCard extends StatelessWidget {
  final WorkRegisterEntity item;

  const _WorkHistoryCard({required this.item});

  Color _statusColor() {
    switch (item.status) {
      case "approved":
        return Colors.green;
      case "rejected":
        return Colors.red;
      case "pending":
        return Colors.orange;
    }
    return Colors.grey;
  }

  String _statusText() {
    switch (item.status) {
      case "approved":
        return "Đã duyệt";
      case "rejected":
        return "Từ chối";
      case "pending":
        return "Chờ duyệt";
    }
    return "Không rõ";
  }

  String _convertShift(String key) {
    switch (key) {
      case "morning":
        return "Ca sáng";
      case "noon":
        return "Ca trưa";
      case "night":
        return "Ca tối";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();
    final date =
        "${item.date.day}/${item.date.month}/${item.date.year}";
    final shiftLabel =
        item.shifts.map((s) => _convertShift(s)).join(", ");

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Row tiêu đề + trạng thái
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Đăng ký ca làm",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _statusText(),
                    style:
                        TextStyle(color: color, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text("Ngày: $date", style: TextStyle(color: Colors.grey[700])),

            const SizedBox(height: 4),
            Text("Ca làm: $shiftLabel",
                style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}
