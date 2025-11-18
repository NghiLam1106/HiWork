import 'package:dartz/dartz.dart'; 
import 'package:hiwork_mo/core/error/failures.dart'; 
import 'package:hiwork_mo/domain/entities/user_entity.dart'; 
import 'package:hiwork_mo/domain/repositories/auth_repository.dart'; 

class LogInUseCase {
  final AuthRepository repository;

  LogInUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute({
    required String email,
    required String password,
  }) async {

    if (email.isEmpty || password.isEmpty) {
      return Left(const InvalidInputFailure(message: 'Vui lòng nhập đầy đủ thông tin.'));
    }
    return await repository.signIn(email: email, password: password);
  }
}