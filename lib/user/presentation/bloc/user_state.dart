part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserError extends UserState {
  final UserFailure failure;

  const UserError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}
