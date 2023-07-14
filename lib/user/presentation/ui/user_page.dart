import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/user/presentation/bloc/user_bloc.dart';
import 'package:github_dashboard/user/presentation/ui/widgets/user_error_page.dart';
import 'package:github_dashboard/user/presentation/ui/widgets/user_profile_page.dart';
import 'package:github_dashboard/user/presentation/ui/widgets/welcome_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              switch (state) {
                case UserInitial():
                  return const WelcomePage();
                case UserLoading():
                  return const CircularProgressIndicator();
                case UserError(failure: final failure):
                  return ErrorPage(failure: failure);
                case UserLoaded(user: final user):
                  return UserProfilePage(user: user);
              }
            },
          ),
        ],
      ),
    );
  }
}
