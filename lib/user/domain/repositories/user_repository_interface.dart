import 'package:dartz/dartz.dart';
import 'package:github_dashboard/user/domain/entities/user_entity.dart';
import 'package:github_dashboard/user/domain/entities/user_failure.dart';

abstract class IUserRepository {
  Future<Either<UserFailure, User>> getUserProfile(String username);
}
