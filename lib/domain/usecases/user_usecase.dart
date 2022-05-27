import 'package:dartz/dartz.dart';
import 'package:emory_app/commons/failure.dart';
import 'package:emory_app/data/models/login_request.dart';
import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/domain/entities/user_pagination_entity.dart';
import 'package:emory_app/domain/repositories/user_repository.dart';

abstract class UserUseCase {
  Future<Either<Failure, UserPaginationEntity>> getUsers({int? page});

  Future<Either<Failure, UserEntity>> getUser(int id);

  Future<Either<Failure, String>> loginAction(LoginRequest request);

  Future<Either<Failure, UserEntity>> editUserAction(UserEntity user);
}

class UserUseCaseImpl extends UserUseCase {
  final UserRepository repository;

  UserUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, UserEntity>> editUserAction(UserEntity user) async =>
      await repository.editUserAction(user);

  @override
  Future<Either<Failure, UserEntity>> getUser(int id) async =>
      await repository.getUser(id);

  @override
  Future<Either<Failure, UserPaginationEntity>> getUsers({int? page}) async =>
      await repository.getUsers(page: page);

  @override
  Future<Either<Failure, String>> loginAction(LoginRequest request) async =>
      await repository.loginAction(request);
}
