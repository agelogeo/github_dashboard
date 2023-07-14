import 'package:dartz/dartz.dart';
import 'package:github_dashboard/repositories/domain/entities/repository_entity.dart';
import 'package:github_dashboard/repositories/domain/entities/repository_failure.dart';

abstract class IRepositoryRepository {
  Future<Either<RepositoryFailure, List<Repository>>> getUserRepositories(
      String username);
}
