import 'package:hiwork_mo/core/error/exceptions.dart'; // Import file exceptions
import 'package:hiwork_mo/data/models/notification_model.dart'; // Import Model

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {

  @override
  Future<List<NotificationModel>> getNotifications() async {

    await Future.delayed(const Duration(milliseconds: 800)); // Giả lập độ trễ mạng

    final List<Map<String, dynamic>> jsonResponse = [
      {
        'id': '1',
        'title': 'Đã thanh toán lương',
        'content': 'Võ Thị Hương đã thanh toán kì lương 01/09/2025–30/09/2025 cho bạn...',
        'createdAt': '2025-10-05T15:01:00Z', // Chuẩn ISO 8601
        'isRead': false, // CHƯA ĐỌC
      },
      {
        'id': '2',
        'title': 'Đã xác nhận phiếu lương',
        'content': 'Hệ thống đã tự xác nhận phiếu lương của chi nhánh Boulevard...',
        'createdAt': '2025-10-04T17:30:00Z',
        'isRead': false, // CHƯA ĐỌC
      },
      {
        'id': '3',
        'title': 'Đừng quên xác nhận phiếu lương',
        'content': 'Bạn cần xác nhận phiếu lương... Nếu quá thời gian, hệ thống sẽ tự động xác nhận.',
        'createdAt': '2025-10-04T17:25:00Z',
        'isRead': true, // ĐÃ ĐỌC
      },
    ];

    try {
      return jsonResponse
          .map((item) => NotificationModel.fromJson(item))
          .toList();
    } on Exception {
      // Nếu API trả về dữ liệu sai cấu trúc
      throw const ServerException(message: 'Lỗi xử lý dữ liệu từ máy chủ.', statusCode:   500);
    }
  }
}