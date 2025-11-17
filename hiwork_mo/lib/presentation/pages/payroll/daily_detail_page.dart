import 'package:flutter/material.dart';

class DailyDetailPage extends StatelessWidget {
  const DailyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A73E8)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Chi tiết theo ngày",
          style: TextStyle(
            color: Color(0xFF1A73E8),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildDayCard(
            date: "01/11/2025",
            data: {
              "Số ca": "1",
              "Giờ thực tế": "5.7",
              "Giờ thường": "5.7",
              "Giờ tăng ca": "0.0",
              "Giờ tính lương": "5.7",
              "Lương hệ số": "0.0",
              "Lương ngày": "150,000",
              "Phụ cấp": "0",
              "Tổng phiếu cộng tiền": "0",
              "Phạt": "0",
              "Tổng phiếu trừ tiền": "0",
              "Lương thực nhận": "150,000",
            },
          ),
          const SizedBox(height: 16),
          _buildDayCard(
            date: "02/11/2025",
            data: {
              "Số ca": "1",
              "Giờ thực tế": "5.7",
              "Giờ thường": "5.7",
              "Giờ tăng ca": "0.0",
              "Giờ tính lương": "5.7",
              "Lương hệ số": "0.0",
              "Lương ngày": "150,000",
              "Phụ cấp": "0",
              "Tổng phiếu cộng tiền": "0",
              "Phạt": "0",
              "Tổng phiếu trừ tiền": "0",
              "Lương thực nhận": "150,000",
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard({
    required String date,
    required Map<String, String> data,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD5E1F2), width: 2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            date,
            style: const TextStyle(
              color: Color(0xFF3A78F2),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Danh sách dữ liệu
          Column(
            children:
                data.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.key,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          e.value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
