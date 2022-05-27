import 'package:emory_app/commons/preferences.dart';
import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/persentation/views/pages/edit_profile_screen.dart';
import 'package:emory_app/persentation/views/widgets/button.dart';
import 'package:emory_app/persentation/views/widgets/c_text_field.dart';
import 'package:flutter/material.dart';
import '../../../injection.dart';
import '../widgets/appbar.dart' as w;

class EmployeeDetailScreen extends StatelessWidget {
  static const String route = 'employee_detail_screen';

  final UserEntity user;

  const EmployeeDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: w.appBar(user.firstName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipPath.shape(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Image.network(
                user.avatar,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            profileDetail(),
          ],
        ),
      ),
      bottomNavigationBar: isMatchedWithCurrentProfile
          ? Padding(
              padding: const EdgeInsets.all(24.0),
              child: Button(
                labelText: "Edit Profile",
                onPressed: () => Navigator.pushNamed(
                    context, EditProfileScreen.route,
                    arguments: user),
                enable: true,
              ))
          : const SizedBox(),
    );
  }

  Widget profileDetail() => Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          CTextField(
            enable: false,
            labelText: "First Name",
            controller: TextEditingController(text: user.firstName),
            hintText: "-",
          ),
          const SizedBox(
            height: 16,
          ),
          CTextField(
            enable: false,
            labelText: "Last Name",
            controller: TextEditingController(text: user.lastName),
            hintText: "-",
          ),
          const SizedBox(
            height: 16,
          ),
          CTextField(
            enable: false,
            labelText: "Email",
            controller: TextEditingController(text: user.email),
            hintText: "-",
          ),
        ],
      );

  bool get isMatchedWithCurrentProfile =>
      user.id == i.get<Preferences>().userId;
}
