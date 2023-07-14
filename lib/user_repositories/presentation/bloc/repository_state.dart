part of 'repository_bloc.dart';

sealed class RepositoryState extends Equatable {
  const RepositoryState();

  @override
  List<Object> get props => [];
}

class RepositoryInitial extends RepositoryState {}

class RepositoryError extends RepositoryState {
  final UserRepositoryFailure failure;

  const RepositoryError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class RepositoryLoading extends RepositoryState {}

class RepositoryLoaded extends RepositoryState {
  final List<UserRepository> repositories;
  final SortOption sortOption;

  const RepositoryLoaded(
      {required this.repositories, required this.sortOption});

  @override
  List<Object> get props => [repositories, sortOption];
}

enum SortOption {
  none,
  stars,
}
