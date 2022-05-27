import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/persentation/views/pages/employee_detail.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final UserEntity user;
  final Widget? trailing;

  const UserTile({Key? key, required this.user, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: trailing,
      onTap: () => Navigator.pushNamed(context, EmployeeDetailScreen.route,
          arguments: user),
      title: Text("${user.firstName} ${user.lastName}"),
      subtitle: Text(user.email),
      leading: ClipPath.shape(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.network(
            user.avatar,
            height: 45,
            width: 45,
            fit: BoxFit.cover,
          )),
    );
  }
}
