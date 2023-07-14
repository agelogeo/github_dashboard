import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:github_dashboard/user/data/models/user_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:github_dashboard/user/domain/entities/user_entity.dart';
import 'package:github_dashboard/user/domain/entities/user_failure.dart';
import 'package:github_dashboard/user/domain/repositories/user_repository_interface.dart';

class UserRepository implements IUserRepository {
  final http.Client client;

  UserRepository({required this.client});

  @override
  Future<Either<UserFailure, User>> getUserProfile(String username) async {
    try {
      final response =
          await client.get(Uri.parse('https://api.github.com/users/$username'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = UserData.fromJson(data);
        return Right(user.toDomainModel());
      } else if (response.statusCode == 403) {
        return const Left(RateLimitExceeded('Rate limit exceeded'));
      } else {
        return Left(UserNotFoundFailure('User not found'));
      }
    } catch (e) {
      return Left(UnknownUserFailure(e.toString()));
    }
  }
}
