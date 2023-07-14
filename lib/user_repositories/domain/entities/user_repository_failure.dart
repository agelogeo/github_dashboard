sealed class UserRepositoryFailure {}

class UserRepositoryNotFoundFailure implements UserRepositoryFailure {
  final String message;

  UserRepositoryNotFoundFailure(this.message);
}

class UserUnknownRepositoryFailure implements UserRepositoryFailure {
  final String message;

  UserUnknownRepositoryFailure(this.message);
}
