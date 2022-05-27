
import 'package:dartz/dartz.dart';
import 'package:emory_app/commons/failure.dart';
import 'package:emory_app/data/models/login_request.dart';
import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/domain/entities/user_pagination_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserPaginationEntity>> getUsers({int? page = 1});

  Future<Either<Failure, UserEntity>> getUser(int id);

  Future<Either<Failure, String>> loginAction(LoginRequest request);

  Future<Either<Failure, UserEntity>> editUserAction(UserEntity user);
}


