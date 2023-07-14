import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:github_dashboard/user_repositories/data/models/user_repository_data_model.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_entity.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_failure.dart';
import 'package:github_dashboard/user_repositories/domain/repositories/user_repository_repository_interface.dart';
import 'package:http/http.dart' as http;

class UserRepositoryRepository implements IUserRepositoryRepository {
  final http.Client client;

  UserRepositoryRepository({required this.client});

  @override
  Future<Either<UserRepositoryFailure, List<UserRepository>>>
      getUserRepositories(String username) async {
    try {
      final response = await client
          .get(Uri.parse('https://api.github.com/users/$username/repos'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<UserRepositoryData> repos = data
            .map(
              (repoData) => UserRepositoryData.fromJson(repoData),
            )
            .toList();
        return Right(
          repos.map((repo) => repo.toDomainModel()).toList(),
        );
      } else {
        return Left(UserRepositoryNotFoundFailure('Repositories not found'));
      }
    } catch (e) {
      return Left(UserUnknownRepositoryFailure((e.toString())));
    }
  }
}
