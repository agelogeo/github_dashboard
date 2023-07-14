import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:github_dashboard/followers/data/models/follower_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:github_dashboard/followers/domain/entities/follower_entity.dart';
import 'package:github_dashboard/followers/domain/entities/follower_failure.dart';
import 'package:github_dashboard/followers/domain/repositories/follower_repository_interface.dart';

class FollowerRepository implements IFollowerRepository {
  final http.Client client;

  FollowerRepository({required this.client});

  @override
  Future<Either<FollowerFailure, List<Follower>>> getUserFollowers(
      String username) async {
    try {
      final response = await client.get(Uri.parse(
          'https://api.github.com/users/$username/followers?per_page=100'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<FollowerData> followers = (data as List)
            .map((followerData) => FollowerData.fromJson(followerData))
            .toList();
        return Right(
          followers.map((follower) => follower.toDomainModel()).toList(),
        );
      } else if (response.statusCode == 403) {
        return const Left(RateLimitExceeded('Rate limit exceeded'));
      } else {
        return const Left(FollowerNotFoundFailure('Followers not found'));
      }
    } catch (e) {
      return Left(UnknownFollowerFailure(e.toString()));
    }
  }
}
