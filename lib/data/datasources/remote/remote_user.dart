import 'package:dio/dio.dart';
import 'package:emory_app/commons/config.dart';
import 'package:emory_app/data/models/login_request.dart';
import 'package:emory_app/data/models/user_model.dart';
import 'package:emory_app/data/models/user_pagination_model.dart';

abstract class RemoteUser {
  Future<UserPaginationModel> fetchUsers({int? page = 1});

  Future<UserModel> fetchUser(int id);

  Future<String> userLoginAction(LoginRequest request);

  Future<UserModel> userEditAction(UserModel user);
}

class RemoteUserImpl extends RemoteUser {
  final String url = '/users';

  final Dio dio;

  RemoteUserImpl(this.dio);

  @override
  Future<UserModel> fetchUser(int id) async {
    dio.options.baseUrl = Config.apiUrl;

    final response = await dio.get('$url/$id');
    return UserModel.fromJson(response.data['data']);
  }

  @override
  Future<UserPaginationModel> fetchUsers({int? page = 1}) async {
    dio.options.baseUrl = Config.apiUrl;
    final response = await dio.get('$url?page=$page&per_page=20');
    return UserPaginationModel.fromJson(response.data);
  }

  @override
  Future<UserModel> userEditAction(UserModel user) async {
    dio.options.baseUrl = Config.apiUrl;
    final response = await dio.put('$url/${user.id}', data: user.toJson());
    return UserModel.fromJson(response.data);
  }

  @override
  Future<String> userLoginAction(LoginRequest request) async {
    dio.options.baseUrl = Config.apiUrl;
    final response = await dio.post('/login', data: request.toJson());
    return response.data['token'];
  }
}
