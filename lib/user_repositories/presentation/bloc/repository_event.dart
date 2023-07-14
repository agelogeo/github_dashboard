part of 'repository_bloc.dart';

sealed class RepositoryEvent extends Equatable {
  const RepositoryEvent();

  @override
  List<Object> get props => [];
}

class GetUserRepositories extends RepositoryEvent {
  final String username;

  const GetUserRepositories({required this.username});

  @override
  List<Object> get props => [username];
}
