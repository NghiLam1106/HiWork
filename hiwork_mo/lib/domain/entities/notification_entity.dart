import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int idNotification;
  final String title;
  final String content;
  final int sender; // Giả định đây là ID của người gửi (vd: id_user)
  final int recieve; // Giả định đây là ID của người nhận (vd: id_user)
  final bool isRead;
  final DateTime dateSend;

  const NotificationEntity({
    required this.idNotification,
    required this.title,
    required this.content,
    required this.sender,
    required this.recieve,
    required this.isRead,
    required this.dateSend,
  });

  NotificationEntity copyWith({
    int? idNotification,
    String? title,
    String? content,
    int? sender,
    int? recieve,
    bool? isRead,
    DateTime? dateSend,
  }) {
    return NotificationEntity(
      idNotification: idNotification ?? this.idNotification,
      title: title ?? this.title,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      recieve: recieve ?? this.recieve,
      isRead: isRead ?? this.isRead,
      dateSend: dateSend ?? this.dateSend,
    );
  }

  @override
  List<Object?> get props => [
    idNotification,
    title,
    content,
    sender,
    recieve,
    isRead,
    dateSend,
  ];
}
