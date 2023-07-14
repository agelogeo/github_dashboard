import 'package:dartz/dartz.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_entity.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_failure.dart';

abstract class IUserRepositoryRepository {
  Future<Either<UserRepositoryFailure, List<UserRepository>>>
      getUserRepositories(String username);
}
