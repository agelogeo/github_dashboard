import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:github_dashboard/followers/data/models/follower_data_model.dart';
import 'package:github_dashboard/followers/domain/entities/follower_entity.dart';
import 'package:github_dashboard/followers/domain/entities/follower_failure.dart';
import 'package:github_dashboard/followers/domain/repositories/follower_repository_interface.dart';
import 'package:github_dashboard/followers/presentation/bloc/followers_bloc.dart';
import 'package:github_dashboard/user_repositories/presentation/bloc/repository_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFollowersRepository extends Mock implements IFollowerRepository {}

void main() {
  late MockFollowersRepository followersRepository;
  late List<Follower> followers;

  setUp(() async {
    followersRepository = MockFollowersRepository();
    final file = File('test/json/followers_response.json');
    final json = await file.readAsString();
    final data = jsonDecode(json) as List;
    final followersList =
        data.map((item) => FollowerData.fromJson(item)).toList();
    followers = followersList.map((e) => e.toDomainModel()).toList();
    registerFallbackValue(const GetUserRepositories(username: ''));
  });

  blocTest<FollowersBloc, FollowersState>(
    'emits [FollowersLoading, FollowersError] when GetUserFollowers successful',
    build: () {
      when(() => followersRepository.getUserFollowers(any()))
          .thenAnswer((_) async => Right(followers));
      return FollowersBloc(followerRepository: followersRepository);
    },
    act: (bloc) => bloc.add(const GetUserFollowers(username: 'testUser')),
    expect: () => [
      FollowersLoading(),
      FollowersLoaded(followers: followers),
    ],
  );

  blocTest<FollowersBloc, FollowersState>(
    'emits [FollowersLoading, FollowersError] when GetUserFollowers fails',
    build: () {
      when(() => followersRepository.getUserFollowers(any())).thenAnswer(
          (_) async =>
              const Left(UnknownFollowerFailure('Some error occurred')));
      return FollowersBloc(followerRepository: followersRepository);
    },
    act: (bloc) => bloc.add(const GetUserFollowers(username: 'testUser')),
    expect: () => [
      FollowersLoading(),
      const FollowersError(
          failure: UnknownFollowerFailure('Some error occurred')),
    ],
  );
}
