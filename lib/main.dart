import 'package:flutter/material.dart';
import 'package:github_dashboard/followers/data/repositories/follower_repository.dart';
import 'package:github_dashboard/followers/presentation/bloc/followers_bloc.dart';
import 'package:github_dashboard/search/presentation/cubit/search_cubit.dart';
import 'package:github_dashboard/search/presentation/ui/search_page.dart';
import 'package:github_dashboard/user_repositories/data/repositories/user_repository_repository.dart';
import 'package:github_dashboard/user_repositories/presentation/bloc/repository_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/user/data/repositories/user_repository.dart';
import 'package:github_dashboard/user/presentation/bloc/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

const primaryColor = Color(0xFF1DA1F2);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserBloc(userRepository: UserRepository(client: http.Client())),
        ),
        BlocProvider(
          create: (context) => FollowersBloc(
              followerRepository: FollowerRepository(client: http.Client())),
        ),
        BlocProvider(
          create: (context) => RepositoryBloc(
              repositoryRepository:
                  UserRepositoryRepository(client: http.Client())),
        ),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: MaterialApp(
        title: 'Github Dashboard',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF181b22),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          primaryColor: primaryColor,
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: primaryColor),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: primaryColor),
        ),
        home: const SearchPage(),
      ),
    );
  }
}
