import 'package:emory_app/commons/preferences.dart';
import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/injection.dart';
import 'package:emory_app/persentation/views/pages/edit_profile_screen.dart';
import 'package:emory_app/persentation/views/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/appbar.dart' as w;

class SettingScreen extends StatefulWidget {
  static const String route = "setting_screen";
  final UserEntity user;

  const SettingScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: w.appBar("Setting"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text("Edit Profile"),
              onTap: () => Navigator.pushNamed(context, EditProfileScreen.route,
                  arguments: widget.user),
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
                i.get<Preferences>().logout();
                Navigator.pushReplacementNamed(context, LoginScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
