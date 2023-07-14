part of 'followers_bloc.dart';

abstract class FollowersEvent extends Equatable {
  const FollowersEvent();

  @override
  List<Object> get props => [];
}

class GetUserFollowers extends FollowersEvent {
  final String username;

  const GetUserFollowers({required this.username});

  @override
  List<Object> get props => [username];
}
