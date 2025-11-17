import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/entities/user_entity.dart';

abstract class AuthRepository {

  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  // 2. Đăng xuất
  // Trả về Either: Failure khi lỗi, Unit khi thành công (không có dữ liệu trả về)
  Future<Either<Failure, Unit>> signOut();

  // 3. Kiểm tra trạng thái xác thực
  // Giữ nguyên bool, hoặc có thể chuyển thành Future<Either<Failure, bool>> để nhất quán
  Future<bool> isAuthenticated();
}