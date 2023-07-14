import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:github_dashboard/repositories/data/models/repository_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:github_dashboard/repositories/domain/entities/repository_entity.dart';
import 'package:github_dashboard/repositories/domain/entities/repository_failure.dart';
import 'package:github_dashboard/repositories/domain/repositories/repository_repository_interface.dart';

class RepositoryRepository implements IRepositoryRepository {
  final http.Client client;

  RepositoryRepository({required this.client});

  @override
  Future<Either<RepositoryFailure, List<Repository>>> getUserRepositories(
      String username) async {
    try {
      final response = await client
          .get(Uri.parse('https://api.github.com/users/$username/repos'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<RepositoryData> repos = data
            .map(
              (repoData) => RepositoryData.fromJson(repoData),
            )
            .toList();
        return Right(
          repos.map((repo) => repo.toDomainModel()).toList(),
        );
      } else {
        return Left(RepositoryNotFoundFailure('Repositories not found'));
      }
    } catch (e) {
      return Left(UnknownRepositoryFailure(e.toString()));
    }
  }
}
