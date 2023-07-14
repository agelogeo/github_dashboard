import 'package:dartz/dartz.dart';
import 'package:github_dashboard/followers/domain/entities/follower_entity.dart';
import 'package:github_dashboard/followers/domain/entities/follower_failure.dart';

abstract class IFollowerRepository {
  Future<Either<FollowerFailure, List<Follower>>> getUserFollowers(
      String username);
}
