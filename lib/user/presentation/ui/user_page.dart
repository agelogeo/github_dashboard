import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/user/presentation/bloc/user_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                switch (state) {
                  case UserInitial():
                    return const Text('Initial');
                  case UserLoading():
                    return const Text('Loading');
                  case UserError():
                    return const Text('Error');
                  case UserLoaded(user: final user):
                    return Text('${user.login}');
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(GetUserProfile(username: "c9s"));
                },
                child: Text("Get User"))
          ],
        ),
      ),
    );
  }
}