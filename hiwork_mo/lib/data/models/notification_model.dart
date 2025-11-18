import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/notification_entity.dart';
import 'package:hiwork_mo/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.idNotification,
    required super.title,
    required super.content,
    required super.sender,
    required super.recieve,
    required super.isRead,
    required super.dateSend,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    
    bool _parseBool(dynamic value) {
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) return value.toLowerCase() == 'true';
      return false; // Mặc định là false nếu không nhận dạng được
    }

    return NotificationModel(
      idNotification: json['id_notification'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      sender: json['sender'] as int,
      recieve: json['recieve'] as int, // Lưu ý: Tên trường này có thể bị sai chính tả
      isRead: _parseBool(json['is_read']),
      dateSend: DateTime.parse(json['date_send'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_notification': idNotification,
      'title': title,
      'content': content,
      'sender': sender,
      'recieve': recieve,
      'is_read': isRead,
      'date_send': dateSend.toIso8601String(), // Chuyển DateTime thành chuỗi string
    };
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      idNotification: entity.idNotification,
      title: entity.title,
      content: entity.content,
      sender: entity.sender,
      recieve: entity.recieve,
      isRead: entity.isRead,
      dateSend: entity.dateSend,
    );
  }
}