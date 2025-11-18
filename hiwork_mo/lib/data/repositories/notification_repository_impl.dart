import 'package:dartz/dartz.dart'; // Thư viện xử lý Lỗi/Thành công
import 'package:hiwork_mo/core/error/exceptions.dart'; // Import Exceptions
import 'package:hiwork_mo/core/error/failures.dart'; // Import Failures
import 'package:hiwork_mo/data/datasources/notification_remote_datasource.dart'; // Import DataSource
import 'package:hiwork_mo/domain/entities/notification_entity.dart'; // Import Entity (cho kiểu trả về)
import 'package:hiwork_mo/domain/repositories/notification_repository.dart'; // Import Interface

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      final notificationModels = await remoteDataSource.getNotifications();

      return Right(notificationModels);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown server error'));
    } on AuthException {
      // (Nếu API yêu cầu xác thực)
      return Left(const AuthFailure(message: 'Phiên đăng nhập hết hạn.'));
    } on Exception catch (e) {
      // 4. Bắt tất cả các lỗi còn lại
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
