import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/core/assets.dart';
import 'package:github_dashboard/followers/presentation/ui/followers_page.dart';
import 'package:github_dashboard/user/domain/entities/user_entity.dart';
import 'package:github_dashboard/user/presentation/ui/widgets/user_error_page.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_entity.dart';
import 'package:github_dashboard/user_repositories/presentation/bloc/repository_bloc.dart';
import 'package:intl/intl.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Header(user: user),
        const SizedBox(height: 20),
        Bio(user: user),
        const SizedBox(height: 30),
        const Divider(
          indent: 20,
          endIndent: 20,
          thickness: 1,
        ),
        Overview(user: user),
        const Divider(
          indent: 20,
          endIndent: 20,
          thickness: 1,
        ),
        RecentRepos(user: user),
      ],
    );
  }
}

class RecentRepos extends StatelessWidget {
  const RecentRepos({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent repositories',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                child: const Text('See all'),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<RepositoryBloc, RepositoryState>(
            builder: (context, state) {
              switch (state) {
                case RepositoryInitial():
                  return const CircularProgressIndicator();
                case RepositoryLoading():
                  return const CircularProgressIndicator();
                case RepositoryError():
                  return const Text('Error');
                case RepositoryLoaded(repositories: final repositories):
                  return RecentRepositoriesList(repositories: repositories);
              }
            },
          )
        ],
      ),
    );
  }
}

class RecentRepositoriesList extends StatelessWidget {
  const RecentRepositoriesList({
    super.key,
    required this.repositories,
  });

  final List<Follower> repositories;

  @override
  Widget build(BuildContext context) {
    final maxIndex = min(repositories.length, 15);
    return Column(
      children: repositories
          .sublist(0, maxIndex)
          .map(
            (repo) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.book_outlined, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: AutoSizeText(
                      repo.name,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class Overview extends StatelessWidget {
  const Overview({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          OverviewInfo(
            visible: user.email != null,
            text: user.email ?? '',
            icon: Icons.mail_outline,
          ),
          OverviewInfo(
            visible: user.location != null,
            text: user.location ?? '',
            icon: Icons.place_outlined,
          ),
          OverviewInfo(
            visible: user.company != null,
            text: user.company ?? '',
            icon: Icons.location_city,
          ),
          NumberOverview(
            icon: Icons.folder_copy_outlined,
            text: 'Repositories',
            quantity: user.publicRepos,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const FollowersPage();
              }));
            },
            child: NumberOverview(
              icon: Icons.people_outlined,
              text: 'Followers',
              quantity: user.followers,
            ),
          ),
          OverviewInfo(
            visible: true,
            text: 'Joined ${DateFormat('d MMM y').format(user.createdAt)}',
            icon: Icons.today_outlined,
          ),
        ],
      ),
    );
  }
}

class NumberOverview extends StatelessWidget {
  const NumberOverview({
    super.key,
    required this.quantity,
    required this.text,
    required this.icon,
  });

  final int quantity;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                AutoSizeText(
                  quantity.toString(),
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  ' $text',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewInfo extends StatelessWidget {
  const OverviewInfo({
    super.key,
    required this.visible,
    required this.text,
    required this.icon,
  });

  final bool visible;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Visibility(
        visible: visible,
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AutoSizeText(
                text,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bio extends StatelessWidget {
  const Bio({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AutoSizeText(
        "${user.bio}",
        maxLines: 4,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: FadeInImage(
                placeholder: AssetImage(Assets.icons.github),
                image: NetworkImage(user.avatarUrl),
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(Assets.icons.github),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? user.login,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 10),
              Text(
                user.login,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
