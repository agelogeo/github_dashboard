import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_entity.dart';
import 'package:github_dashboard/user_repositories/presentation/bloc/repository_bloc.dart';
import 'package:github_dashboard/user_repositories/presentation/ui/repositories_error_page.dart';
import 'package:intl/intl.dart';

class UserRepositoriesPage extends StatelessWidget {
  const UserRepositoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BlocBuilder<RepositoryBloc, RepositoryState>(
        builder: (context, state) {
          switch (state) {
            case RepositoryInitial():
            case RepositoryLoading():
            case RepositoryError():
              return const Text("Repositories");
            case RepositoryLoaded(repositories: final repos):
              return Text("${repos.length} Repositories");
          }
        },
      )),
      body: BlocBuilder<RepositoryBloc, RepositoryState>(
        builder: (context, state) {
          switch (state) {
            case RepositoryInitial():
              return const Center(child: CircularProgressIndicator());
            case RepositoryLoading():
              return const Center(child: CircularProgressIndicator());
            case RepositoryError(failure: final failure):
              return UserRepositoriesErrorPage(failure: failure);
            case RepositoryLoaded(repositories: final repos):
              return RepositoriesList(repositories: repos);
          }
        },
      ),
    );
  }
}

class RepositoriesList extends StatelessWidget {
  const RepositoriesList({
    super.key,
    required this.repositories,
  });

  final List<UserRepository> repositories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        indent: 20,
        endIndent: 20,
        thickness: 1,
      ),
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        final repo = repositories[index];
        return RepositoryTile(repository: repo);
      },
    );
  }
}

class RepositoryTile extends StatelessWidget {
  const RepositoryTile({
    super.key,
    required this.repository,
  });

  final UserRepository repository;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RepositoryTitle(name: repository.name),
          RepositoryDescription(description: repository.description ?? ''),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RepositoryStargazers(
                    stargazersCount: repository.stargazersCount),
                RepositoryUpdatedAt(updatedAt: repository.updatedAt),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RepositoryTitle extends StatelessWidget {
  const RepositoryTitle({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
    );
  }
}

class RepositoryDescription extends StatelessWidget {
  const RepositoryDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

class RepositoryStargazers extends StatelessWidget {
  const RepositoryStargazers({
    super.key,
    required this.stargazersCount,
  });

  final int stargazersCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          const Icon(Icons.star, size: 16),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              stargazersCount.toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}

class RepositoryUpdatedAt extends StatelessWidget {
  const RepositoryUpdatedAt({
    super.key,
    required this.updatedAt,
  });

  final DateTime updatedAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Text(
        'Updated on ${DateFormat('MMM d, yyyy').format(updatedAt)}',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
