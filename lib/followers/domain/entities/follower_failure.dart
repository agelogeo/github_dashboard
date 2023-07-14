sealed class FollowerFailure {}

class FollowerNotFoundFailure implements FollowerFailure {
  final String message;

  FollowerNotFoundFailure(this.message);
}
