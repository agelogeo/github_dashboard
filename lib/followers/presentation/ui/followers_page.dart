import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/followers/domain/entities/follower_entity.dart';
import 'package:github_dashboard/followers/presentation/bloc/followers_bloc.dart';
import 'package:github_dashboard/followers/presentation/ui/followers_error_page.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(title: BlocBuilder<FollowersBloc, FollowersState>(
          builder: (context, state) {
            switch (state) {
              case FollowersInitial():
              case FollowersLoading():
              case FollowersError():
                return const Text("Followers");
              case FollowersLoaded(followers: final followers):
                return Text("${followers.length} Followers");
            }
          },
        )),
        body: BlocBuilder<FollowersBloc, FollowersState>(
          builder: (context, state) {
            switch (state) {
              case FollowersInitial():
                return const Center(child: CircularProgressIndicator());
              case FollowersLoading():
                return const Center(child: CircularProgressIndicator());
              case FollowersError(failure: final failure):
                return FollowersErrorPage(failure: failure);
              case FollowersLoaded(followers: final followers):
                return FollowersList(followers: followers);
            }
          },
        ),
      ),
    );
  }
}

class FollowersList extends StatelessWidget {
  const FollowersList({
    super.key,
    required this.followers,
  });

  final List<Follower> followers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: followers.length,
      itemBuilder: (context, index) {
        final follower = followers[index];
        return FollowerTile(follower: follower);
      },
    );
  }
}

class FollowerTile extends StatelessWidget {
  const FollowerTile({
    super.key,
    required this.follower,
  });

  final Follower follower;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(follower.avatarUrl),
      ),
      title: Text(follower.name ?? follower.login),
      subtitle: Text(follower.login),
    );
  }
}
