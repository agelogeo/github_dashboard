import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_dashboard/followers/domain/entities/follower_entity.dart';
import 'package:github_dashboard/followers/domain/entities/follower_failure.dart';
import 'package:github_dashboard/followers/domain/repositories/follower_repository_interface.dart';

part 'followers_event.dart';
part 'followers_state.dart';

class FollowersBloc extends Bloc<FollowersEvent, FollowersState> {
  final IFollowerRepository followerRepository;
  FollowersBloc({required this.followerRepository})
      : super(FollowersInitial()) {
    on<GetUserFollowers>((event, emit) async {
      emit(FollowersLoading());
      final result = await followerRepository.getUserFollowers(event.username);
      result.fold(
        (failure) => emit(FollowersError(failure: failure)),
        (followers) => emit(FollowersLoaded(followers: followers)),
      );
    });
  }
}
