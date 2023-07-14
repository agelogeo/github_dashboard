part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfile extends UserEvent {
  final String username;

  const GetUserProfile({required this.username});

  @override
  List<Object> get props => [username];
}
