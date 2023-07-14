import 'package:equatable/equatable.dart';

sealed class UserRepositoryFailure extends Equatable {}

class UserRepositoryNotFoundFailure extends Equatable
    implements UserRepositoryFailure {
  final String message;

  const UserRepositoryNotFoundFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserUnknownRepositoryFailure extends Equatable
    implements UserRepositoryFailure {
  final String message;

  const UserUnknownRepositoryFailure(this.message);

  @override
  List<Object> get props => [message];
}
