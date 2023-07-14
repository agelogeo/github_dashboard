import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_entity.dart';
import 'package:github_dashboard/user_repositories/presentation/bloc/repository_bloc.dart';
import 'package:github_dashboard/user_repositories/presentation/ui/repositories_error_page.dart';

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
    return ListView.builder(
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
    return ListTile(
      title: Text(repository.name),
      subtitle: Text(repository.description ?? ""),
      trailing: Text(repository.stargazersCount.toString()),
    );
  }
}
