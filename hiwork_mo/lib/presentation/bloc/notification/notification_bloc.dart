import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/domain/usecases/get_notifications_usecase.dart';
import 'notification_event.dart';
import 'notification_state.dart';

// 9. BLoC (Bộ não)
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  
  NotificationBloc({required this.getNotificationsUseCase}) : super(NotificationInitial()) {
    // Đăng ký xử lý cho sự kiện LoadNotifications
    on<LoadNotifications>(_onLoadNotifications);
  }

  // Hàm xử lý khi sự kiện LoadNotifications được gửi đến
  void _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading()); // Phát trạng thái Đang tải
    
    // Gọi UseCase để lấy dữ liệu
    final result = await getNotificationsUseCase.execute();
    
    // Xử lý kết quả trả về từ UseCase (Either<Failure, List>)
    result.fold(
      // Nếu là Left(Failure) -> Phát trạng thái Lỗi
      (failure) => emit(NotificationError(failure.props.isNotEmpty ? failure.props[0].toString() : 'Lỗi không xác định.')),
      // Nếu là Right(List<Entity>) -> Phát trạng thái Tải xong
      (notifications) => emit(NotificationLoaded(notifications)), 
    );
  }
}