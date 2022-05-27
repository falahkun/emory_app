
import 'package:emory_app/data/models/login_request.dart';
import 'package:emory_app/persentation/blocs/login_bloc.dart';
import 'package:emory_app/persentation/blocs/users_bloc.dart';
import 'package:emory_app/persentation/views/pages/home_screen.dart';
import 'package:emory_app/persentation/views/widgets/c_text_field.dart';
import 'package:emory_app/persentation/views/widgets/button.dart';
import 'package:emory_app/persentation/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormFieldState> emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordFormKey = GlobalKey<FormFieldState>();

  bool _isLoginButtonEnable = false;
  bool _invisible = true;

  bool _isFormValid() {
    return ((emailFormKey.currentState!.isValid &&
        passwordFormKey.currentState!.isValid));
  }

  void _setVisibility() {
    setState(() => _invisible = !_invisible);
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        var loading = LoadingWidget(context);
        if (state is LoginProcessing) {
          loading.show();
        } else if (state is LoginSuccess) {
          loading.close();
          context.read<UsersBloc>().add(FetchUsers());
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        } else if (state is LoginError) {
          loading.close();
          SystemChannels.textInput.invokeListMethod('TextInput.hide');
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Button(
              labelText: "Login",
              onPressed: () {
                final request = LoginRequest(emailController.text.trim(),
                    passwordController.text.trim());
                context.read<LoginBloc>().add(LoginAction(request));
              },
              enable: _isLoginButtonEnable,
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: loginForm(),
          ),
        ),
      ),
    );
  }

  Widget loginForm() => Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Welcome Back",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 16,
          ),
          CTextField(
            key: emailFormKey,
            labelText: "Email",
            hintText: "Enter your valid email",
            controller: emailController,
            onChanged: (value) {
              setState(() {
                _isLoginButtonEnable = _isFormValid();
                emailFormKey.currentState!.validate();
              });
            },
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
          CTextField(
            invisible: _invisible,
            key: passwordFormKey,
            controller: passwordController,
            onChanged: (value) {
              setState(() {
                _isLoginButtonEnable = _isFormValid();
                passwordFormKey.currentState!.validate();
              });
            },
            validator: (value) {
              bool passwordValid = value!.length >= 8;
              if (value.isEmpty) {
                return 'Password is required!';
              } else if (!passwordValid) {
                return 'Password min 8 character!';
              } else {
                return null;
              }
            },
            labelText: "Password",
            hintText: "Enter your Password",
            suffixWidget: InkWell(
              child: Icon(_invisible ? Icons.visibility : Icons.visibility_off),
              onTap: () => _setVisibility(),
            ),
          ),
        ],
      );
}
