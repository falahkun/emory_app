import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/persentation/blocs/edit_profile_bloc.dart';
import 'package:emory_app/persentation/views/widgets/button.dart';
import 'package:emory_app/persentation/views/widgets/c_text_field.dart';
import 'package:emory_app/persentation/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/appbar.dart' as w;

class EditProfileScreen extends StatefulWidget {
  static const String route = 'edit_profile_screen';
  final UserEntity user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController? _firstNameController,
      _lastNameController,
      _emailController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (_, state) {
        var loading = LoadingWidget(context);
        if (state is EditProfileProcessing) {
          loading.show();
        } else if (state is EditProfileSuccess) {
          loading.close();
          const snackBar = SnackBar(content: Text("Profile Updated"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is EditProfileError) {
          loading.close();
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        appBar: w.appBar("Edit Profile"),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(key: _formKey, child: profileForm()),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Button(
              labelText: "Edit Profile",
              onPressed: () {
                final user = widget.user;
                user.firstName = _firstNameController!.text.trim();
                user.lastName = _lastNameController!.text.trim();
                user.email = _emailController!.text.trim();

                context.read<EditProfileBloc>().add(EditProfileAction(user));
              },
              enable: true,
            )),
      ),
    );
  }

  Widget profileForm() => Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          CTextField(
            labelText: "First Name",
            hintText: "Enter your First Name",
            controller: _firstNameController!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'First Name is required!';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CTextField(
            labelText: "Last Name",
            hintText: "Enter your last name",
            controller: _lastNameController!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'last name is required!';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CTextField(
            labelText: "Email",
            hintText: "Enter your valid email",
            controller: _emailController!,
            validator: (value) {
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (value.isEmpty) {
                return 'Email is required!';
              } else if (!emailValid) {
                return 'Email format invalid!';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
}
