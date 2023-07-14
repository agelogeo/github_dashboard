part of 'followers_bloc.dart';

sealed class FollowersState extends Equatable {
  const FollowersState();

  @override
  List<Object> get props => [];
}

class FollowersInitial extends FollowersState {}

class FollowersError extends FollowersState {
  final FollowerFailure failure;

  const FollowersError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class FollowersLoading extends FollowersState {}

class FollowersLoaded extends FollowersState {
  final List<Follower> followers;

  const FollowersLoaded({required this.followers});

  @override
  List<Object> get props => [followers];
}
