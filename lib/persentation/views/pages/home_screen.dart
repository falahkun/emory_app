import 'package:emory_app/commons/preferences.dart';
import 'package:emory_app/injection.dart' show i;
import 'package:emory_app/persentation/blocs/user_bloc.dart';
import 'package:emory_app/persentation/blocs/users_bloc.dart';
import 'package:emory_app/persentation/views/pages/setting_screen.dart';
import 'package:emory_app/persentation/views/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final preferences = i.get<Preferences>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<UsersBloc>().add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (_, state) {
        if (state is UsersLoaded) {
          context.read<UserBloc>().add(FetchUser(preferences.userId!));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                currentProfile(),
                const SizedBox(
                  height: 16,
                ),
                const ListTile(
                  title:
                      Text("List of Employee", style: TextStyle(fontSize: 18)),
                ),
                listOfEmployee(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget currentProfile() =>
      BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is! UserLoaded) return Container();
        return UserTile(
          user: state.user,
          trailing: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, SettingScreen.route,
                arguments: state.user),
          ),
        );
      });

  Widget listOfEmployee() =>
      BlocBuilder<UsersBloc, UsersState>(builder: (_, state) {
        if (state is! UsersLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              ...state.data.data
                  .where((element) => element.id != preferences.userId)
                  .map((e) => UserTile(user: e))
                  .toList(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: state.isReached!
                        ? const Text("No more data")
                        : const CircularProgressIndicator()),
              ),
            ],
          );
        }
      });
}
