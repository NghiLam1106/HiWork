import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Đã thanh toán lương',
        'content':
            'Võ Thị Hương đã thanh toán kì lương 01/09/2025–30/09/2025 cho bạn\nSố tiền thanh toán: 2,103,000 VND\nNgày thanh toán: 05/10/2025',
        'time': '05/10/2025 15:01',
        'image': AppAssets.notiCheck, 
      },
      {
        'title': 'Đã xác nhận phiếu lương',
        'content':
            'Hệ thống đã tự xác nhận phiếu lương của chi nhánh Boulevard Gelato & Coffee – Đà Nẵng kỳ lương 01/09/2025–30/09/2025',
        'time': '04/10/2025 15:01',
        'image': AppAssets.notiCheck,
      },
      {
        'title': 'Đừng quên xác nhận phiếu lương',
        'content':
            'Bạn cần xác nhận phiếu lương của chi nhánh Boulevard Gelato & Coffee – Đà Nẵng kỳ lương 01/09/2025–30/09/2025. Nếu quá thời gian, hệ thống sẽ tự động xác nhận và không thể chỉnh sửa.',
        'time': '04/10/2025 15:02',
        'image': AppAssets.noti,
      },
      {
        'title': 'Cần xác nhận phiếu lương',
        'content':
            'Vui lòng kiểm tra lại thông tin lương của chi nhánh Boulevard Gelato & Coffee – Đà Nẵng, kỳ lương 01/09/2025–30/09/2025 và xác nhận trước 17:30 04/10/2025, sau thời gian này hệ thống sẽ tự động xác nhận.',
        'time': '04/10/2025 17:00',
        'image': AppAssets.noti,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Color.fromRGBO(22, 98, 179, 1.0),
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.title_24,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        // elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 51, 51, 42).withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDE8FF),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      item['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 14),
                  

                  // Nội dung thông báo
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: AppFontSize.title_18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['content']!,
                          style: const TextStyle(
                            fontSize: AppFontSize.content_16,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['time']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
