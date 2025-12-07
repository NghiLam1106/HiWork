import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:hiwork_mo/core/error/failures.dart';
import 'package:hiwork_mo/data/datasources/auth_remote_datasource.dart';
import 'package:hiwork_mo/domain/entities/user_entity.dart';
import 'package:hiwork_mo/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signIn(email: email, password: password);
      
      final userEntity = userModel.toEntity(); 
      
      return Right(userEntity); 
    } on AuthFailure catch (e) {
      // Bắt AuthFailure và trả về đối tượng lỗi
      return Left(e);
    } on Exception {
      // Bắt các lỗi chung khác (ví dụ: Network, Timeout)
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(unit); 
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<bool> isAuthenticated() {
    return remoteDataSource.isAuthenticated();
  }
}