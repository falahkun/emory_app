import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/persentation/views/pages/edit_profile_screen.dart';
import 'package:emory_app/persentation/views/pages/employee_detail.dart';
import 'package:emory_app/persentation/views/pages/home_screen.dart';
import 'package:emory_app/persentation/views/pages/login_screen.dart';
import 'package:emory_app/persentation/views/pages/setting_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? routeSetting(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.route:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case LoginScreen.route:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case SettingScreen.route:
      final user = settings.arguments as UserEntity;
      return MaterialPageRoute(
          builder: (_) => SettingScreen(
                user: user,
              ));
    case EditProfileScreen.route:
      final user = settings.arguments as UserEntity;
      return MaterialPageRoute(builder: (_) => EditProfileScreen(user: user));
    case EmployeeDetailScreen.route:
      final user = settings.arguments as UserEntity;
      return MaterialPageRoute(builder: (_) => EmployeeDetailScreen(user: user));

    default:
      return MaterialPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text('Page not found :('),
          ),
        );
      });
  }
}
