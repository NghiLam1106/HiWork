import 'package:flutter/material.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart';


class AttendanceHistoryPage extends StatelessWidget {
  const AttendanceHistoryPage({super.key});

  // Định nghĩa các hằng số màu sắc cục bộ để dễ quản lý và đọc hơn
  static const Color primaryBlue = Color(0xFF1A73E8);
  static const Color lightBlueBackground = Color(0xFFE9EDF4);
  static const Color pageBackground = Color(0xFFF5F7FB);
  static const Color neutralGray = Color(0xFF7A7A7A);
  static const Color lightGrayTag = Color(0xFFEAEAEA);
  static const Color warningText = Color(0xFFDA8A00);
  static const Color warningBackground = Color(0xFFFFF3D6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sử dụng hằng số màu sắc
      backgroundColor: pageBackground,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          // Thao tác chuẩn để quay lại màn hình trước
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Bổ sung/ sửa chấm công",
          style: TextStyle(
            color: primaryBlue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Đặt centerTitle thành true để đảm bảo tiêu đề ở giữa (nếu cần) hoặc để mặc định là false
        centerTitle: false,
      ),

      // Sử dụng SingleChildScrollView nếu nội dung có thể tràn
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Khu vực nội dung cuộn được (có thể là ListView.builder nếu có nhiều thẻ)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 16,
              ), // Thêm padding dưới cùng
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TAG CHƯA DUYỆT TRÊN CÙNG
                  _buildStatusHeaderTag(
                    context,
                    label: "Chưa duyệt",
                    textColor: neutralGray,
                    backgroundColor: lightGrayTag,
                  ),

                  // CARD CHẤM CÔNG (tách thành widget riêng)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _AttendanceHistoryCard(
                      shiftName: "Ca trưa",
                      shiftTime: "12:00 - 17:30",
                      date: "Thứ 4, 05/11/2025",
                      status: "Chưa duyệt",
                      statusColor: warningText,
                      statusBackgroundColor: warningBackground,
                    ),
                  ),

                  // Nếu có nhiều thẻ, có thể lặp lại _AttendanceHistoryCard ở đây
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.addEditAttendance);
        },
        backgroundColor: primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Helper method để tạo tag header
  Widget _buildStatusHeaderTag(
    BuildContext context, {
    required String label,
    required Color textColor,
    required Color backgroundColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, style: TextStyle(color: textColor, fontSize: 13)),
      ),
    );
  }
}

class _AttendanceHistoryCard extends StatelessWidget {
  final String shiftName;
  final String shiftTime;
  final String date;
  final String status;
  final Color statusColor;
  final Color statusBackgroundColor;

  const _AttendanceHistoryCard({
    required this.shiftName,
    required this.shiftTime,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16), // Tăng nhẹ padding cho đẹp hơn
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // Tăng nhẹ độ mờ của shadow
            blurRadius: 8, // Tăng nhẹ blur
            offset: const Offset(0, 4), // Dịch chuyển shadow xuống dưới
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          Row(
            children: [
              Text(
                "$shiftName[$shiftTime]",
                style: const TextStyle(
                  color: AttendanceHistoryPage.primaryBlue,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),

              // STATUS TAG
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8), // Tăng khoảng cách
          // DATE
          Text(
            date,
            style: const TextStyle(
              color: AttendanceHistoryPage.neutralGray,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
