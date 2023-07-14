sealed class RepositoryFailure {}

class RepositoryNotFoundFailure implements RepositoryFailure {
  final String message;

  RepositoryNotFoundFailure(this.message);
}
