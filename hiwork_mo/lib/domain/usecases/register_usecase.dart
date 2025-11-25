import 'package:dartz/dartz.dart';
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, Unit>> execute({
    required String username,
    required String email,
    required String password,
    String role = 'user',
  }) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      return Left(const InvalidInputFailure(message: 'Vui lòng nhập đầy đủ thông tin.'));
    }
    return await repository.register(
      username: username,
      email: email,
      password: password,
      role: role,
    );
  }
}
