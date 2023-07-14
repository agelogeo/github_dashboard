sealed class RepositoryFailure {}

class RepositoryNotFoundFailure implements RepositoryFailure {
  final String message;

  RepositoryNotFoundFailure(this.message);
}

class UnknownRepositoryFailure implements RepositoryFailure {
  final String message;

  UnknownRepositoryFailure(this.message);
}
