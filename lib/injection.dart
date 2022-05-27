import 'package:dio/dio.dart';
import 'package:emory_app/commons/config.dart';
import 'package:emory_app/commons/dio.dart';
import 'package:emory_app/commons/preferences.dart';
import 'package:emory_app/data/datasources/remote/remote_user.dart';
import 'package:emory_app/data/repositories/user_repository_impl.dart';
import 'package:emory_app/domain/repositories/user_repository.dart';
import 'package:emory_app/domain/usecases/user_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final i = GetIt.instance;

void init() {
  i.registerFactory(() => Preferences(i.get<SharedPreferences>()));
  i.registerFactory<Dio>(() => DioClient(apiBaseUrl: Config.apiUrl).dio);

  // datasources
  i.registerLazySingleton<RemoteUser>(() => RemoteUserImpl(i.get<Dio>()));

  // repositories
  i.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(i.get<RemoteUser>(), i.get<Preferences>()));

  // usecases
  i.registerLazySingleton<UserUseCase>(
      () => UserUseCaseImpl(i.get<UserRepository>()));
}
