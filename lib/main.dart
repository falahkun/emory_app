import 'package:emory_app/commons/config.dart';
import 'package:emory_app/commons/route_setting.dart';
import 'package:emory_app/domain/usecases/user_usecase.dart';
import 'package:emory_app/persentation/blocs/edit_profile_bloc.dart';
import 'package:emory_app/persentation/blocs/login_bloc.dart';
import 'package:emory_app/persentation/blocs/user_bloc.dart';
import 'package:emory_app/persentation/blocs/users_bloc.dart';
import 'package:emory_app/persentation/views/pages/home_screen.dart';
import 'package:emory_app/persentation/views/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'commons/preferences.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  i.registerFactory<SharedPreferences>(() => preferences);

  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(i.get<UserUseCase>())),
        BlocProvider(create: (_) => UsersBloc(i.get<UserUseCase>())),
        BlocProvider(create: (_) => UserBloc(i.get<UserUseCase>())),
        BlocProvider(create: (_) => EditProfileBloc(i.get<UserUseCase>())),
      ],
      child: MaterialApp(
        title: Config.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        initialRoute: i.get<Preferences>().isLoggedIn
            ? HomeScreen.route
            : LoginScreen.route,
        onGenerateRoute: routeSetting,
      ),
    );
  }
}
