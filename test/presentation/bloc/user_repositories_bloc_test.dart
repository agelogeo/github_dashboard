import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:github_dashboard/user_repositories/data/models/user_repository_data_model.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_entity.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_failure.dart';
import 'package:github_dashboard/user_repositories/domain/repositories/user_repository_repository_interface.dart';
import 'package:github_dashboard/user_repositories/presentation/bloc/repository_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserRepositoryRepository extends Mock
    implements IUserRepositoryRepository {}

void main() {
  late MockUserRepositoryRepository repositoryRepository;
  late List<UserRepository> repositories;

  setUp(() async {
    repositoryRepository = MockUserRepositoryRepository();
    final file = File('test/json/repositories_response.json');
    final json = await file.readAsString();
    final data = jsonDecode(json) as List;
    final repoDataList =
        data.map((item) => UserRepositoryData.fromJson(item)).toList();
    repositories = repoDataList.map((e) => e.toDomainModel()).toList();
    registerFallbackValue(const GetUserRepositories(username: ''));
  });

  blocTest<RepositoryBloc, RepositoryState>(
    'emits [RepositoryLoading, RepositoryLoaded] when GetUserRepositories successful',
    build: () {
      when(() => repositoryRepository.getUserRepositories(any()))
          .thenAnswer((_) async => Right(repositories));
      return RepositoryBloc(repositoryRepository: repositoryRepository);
    },
    act: (bloc) => bloc.add(const GetUserRepositories(username: 'testUser')),
    expect: () => [
      RepositoryLoading(),
      RepositoryLoaded(repositories: repositories, sortOption: SortOption.none),
    ],
  );

  blocTest<RepositoryBloc, RepositoryState>(
    'emits [RepositoryLoading, RepositoryError] when GetUserRepositories fails',
    build: () {
      when(() => repositoryRepository.getUserRepositories(any())).thenAnswer(
          (_) async =>
              Left(UserUnknownRepositoryFailure('Some error occurred')));
      return RepositoryBloc(repositoryRepository: repositoryRepository);
    },
    act: (bloc) => bloc.add(const GetUserRepositories(username: 'testUser')),
    expect: () => [
      RepositoryLoading(),
      RepositoryError(
          failure: UserUnknownRepositoryFailure('Some error occurred')),
    ],
  );
}
