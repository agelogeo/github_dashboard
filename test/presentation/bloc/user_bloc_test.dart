import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:github_dashboard/user/data/models/user_data_model.dart';
import 'package:github_dashboard/user/domain/entities/user_entity.dart';
import 'package:github_dashboard/user/domain/entities/user_failure.dart';
import 'package:github_dashboard/user/domain/repositories/user_repository_interface.dart';
import 'package:github_dashboard/user/presentation/bloc/user_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late MockUserRepository userRepository;
  late User user;

  setUp(() async {
    userRepository = MockUserRepository();
    final file = File('test/json/user_response.json');
    final json = await file.readAsString();
    final data = jsonDecode(json) as Map<String, dynamic>;
    final userData = UserData.fromJson(data);
    user = userData.toDomainModel();
    registerFallbackValue(const GetUserProfile(username: ''));
  });

  blocTest<UserBloc, UserState>(
    'emits [UserLoading, UserLoaded] when GetUserProfile successful',
    build: () {
      when(() => userRepository.getUserProfile(any()))
          .thenAnswer((_) async => Right(user));
      return UserBloc(userRepository: userRepository);
    },
    act: (bloc) => bloc.add(const GetUserProfile(username: 'testUser')),
    expect: () => [
      UserLoading(),
      UserLoaded(user: user),
    ],
  );

  blocTest<UserBloc, UserState>(
    'emits [UserLoading, UserError] when GetUserProfile fails',
    build: () {
      when(() => userRepository.getUserProfile(any())).thenAnswer(
          (_) async => const Left(UnknownUserFailure('Some error occurred')));
      return UserBloc(userRepository: userRepository);
    },
    act: (bloc) => bloc.add(const GetUserProfile(username: 'testUser')),
    expect: () => [
      UserLoading(),
      const UserError(failure: UnknownUserFailure('Some error occurred')),
    ],
  );
}
