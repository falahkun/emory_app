import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:emory_app/commons/failure.dart';
import 'package:emory_app/commons/messages.dart';
import 'package:emory_app/commons/preferences.dart';
import 'package:emory_app/data/datasources/remote/remote_user.dart';
import 'package:emory_app/data/models/user_model.dart';
import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/domain/entities/user_pagination_entity.dart';
import 'package:emory_app/domain/repositories/user_repository.dart';

import '../models/login_request.dart';

class UserRepositoryImpl extends UserRepository {
  final RemoteUser remote;
  final Preferences preferences;

  UserRepositoryImpl(this.remote, this.preferences);

  @override
  Future<Either<Failure, UserEntity>> editUserAction(UserEntity user) async {
    try {
      final result = await remote.userEditAction(UserModel.fromEntity(user));
      return Right(result.toEntity());
    } on SocketException {
      return const Left(ConnectionFailure(connectionFailure));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(int id) async {
    try {
      final result = await remote.fetchUser(id);
      return Right(result.toEntity());
    } on SocketException {
      return const Left(ConnectionFailure(connectionFailure));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserPaginationEntity>> getUsers({int? page}) async {
    try {
      final result = await remote.fetchUsers(page: page);
      if (preferences.isLoggedIn) {
        var userModel = result.data
            .where((element) => element.email == preferences.userEmail)
            .first;
        preferences.saveUserId(userModel.id);
      }
      return Right(result.toEntity());
    } on SocketException {
      return const Left(ConnectionFailure(connectionFailure));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginAction(LoginRequest request) async {
    try {
      final result = await remote.userLoginAction(request);
      preferences.saveAccessToken(result);
      preferences.setLogin();
      preferences.saveUserEmail(request.email);

      return Right(result);
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return Left(ServerFailure(e.response!.data['error']));
      } else {
        return Left(ServerFailure(e.message));
      }
    } on SocketException {
      return const Left(ConnectionFailure(connectionFailure));
    } catch (e) {
      return const Left(ServerFailure("Failed Something error"));
    }
  }
}
