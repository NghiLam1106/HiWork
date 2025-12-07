import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/domain/entities/notification_entity.dart'; // Vẫn cần để BLoC hoạt động
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/bloc/notification/notification_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/notification/notification_event.dart';
import 'package:hiwork_mo/presentation/bloc/notification/notification_state.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notifications = [
    {
      'title': 'Đã thanh toán lương',
      'content':
          'Võ Thị Hương đã thanh toán kì lương 01/09/2025–30/09/2025 cho bạn\nSố tiền thanh toán: 2,103,000 VND\nNgày thanh toán: 05/10/2025',
      'time': '05/10/2025 15:01',
      'image': AppAssets.notiCheck, // <-- Đã đọc
    },
    {
      'title': 'Đã xác nhận phiếu lương',
      'content':
          'Hệ thống đã tự xác nhận phiếu lương của chi nhánh Boulevard Gelato & Coffee – Đà Nẵng kỳ lương 01/09/2025–30/09/2025',
      'time': '04/10/2025 15:01',
      'image': AppAssets.notiCheck, // <-- Đã đọc
    },
    {
      'title': 'Đừng quên xác nhận phiếu lương',
      'content':
          'Bạn cần xác nhận phiếu lương của chi nhánh Boulevard Gelato & Coffee – Đà Nẵng kỳ lương 01/09/2025–30/09/2025. Nếu quá thời gian, hệ thống sẽ tự động xác nhận và không thể chỉnh sửa.',
      'time': '04/10/2025 15:02',
      'image': AppAssets.noti, // <-- Chưa đọc
    },
    {
      'title': 'Cần xác nhận phiếu lương',
      'content':
          'Vui lòng kiểm tra lại thông tin lương của chi nhánh Boulevard Gelato & Coffee – Đà Nẵng, kỳ lương 01/09/2025–30/09/2025 và xác nhận trước 17:30 04/10/2025, sau thời gian này hệ thống sẽ tự động xác nhận.',
      'time': '04/10/2025 17:00',
      'image': AppAssets.noti, // <-- Chưa đọc
    },
  ];
  // --- KẾT THÚC DỮ LIỆU DEMO ---

  @override
  void initState() {
    super.initState();
    // Tạm thời TẮT
    // context.read<NotificationBloc>().add(LoadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.notificationTitle, // Dùng l10n
          style: const TextStyle(
            color: Color.fromRGBO(22, 98, 179, 1.0),
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.title_20,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF4F6FA),

      // --- CODE DEMO (DÙNG DỮ LIỆU MAP) ---
      body:
          notifications.isEmpty
              ? Center(child: Text(l10n.noNotifications))
              : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: notifications.length,
                separatorBuilder: (context, i) => const SizedBox(height: 15),
                itemBuilder: (context, i) {
                  return SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: _NotificationItem(item: notifications[i]),
                  );
                },
              ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final Map<String, dynamic> item;
  const _NotificationItem({required this.item});

  @override
  Widget build(BuildContext context) {
    // ---- 3. LOGIC ĐỌC TỪ MAP ----

    final String title = item['title'] as String;
    final String content = item['content'] as String;
    final String time = item['time'] as String;
    final String iconPath = item['image'] as String;
    final bool isRead = (iconPath == AppAssets.notiCheck);

    final Color backgroundColor =
        !isRead ? Colors.white : const Color(0xFFF0F8FF); // Xanh nhạt
    final FontWeight titleWeight =
        !isRead ? FontWeight.normal : FontWeight.bold;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // <-- Dùng logic
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
            // Icon
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFCDE8FF),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                iconPath, // <-- Lấy từ Map
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 14),

            // Nội dung
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppFontSize.title_18,
                      fontWeight: titleWeight,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Flexible(
                    child: Text(
                      content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: AppFontSize.content_16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
