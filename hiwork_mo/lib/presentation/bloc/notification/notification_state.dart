import 'package:equatable/equatable.dart';
import 'package:hiwork_mo/domain/entities/notification_entity.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object> get props => [];
}

// Trạng thái: Khởi tạo (ban đầu)
class NotificationInitial extends NotificationState {}

// Trạng thái: Đang tải (UI sẽ hiển thị vòng xoay)
class NotificationLoading extends NotificationState {}

// Trạng thái: Tải thành công (UI sẽ hiển thị ListView)
class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  
  const NotificationLoaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

// Trạng thái: Tải thất bại (UI sẽ hiển thị thông báo lỗi)
class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object> get props => [message];
}