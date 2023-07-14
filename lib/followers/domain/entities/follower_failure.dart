sealed class FollowerFailure {}

class FollowerNotFoundFailure implements FollowerFailure {
  final String message;

  FollowerNotFoundFailure(this.message);
}

class UnknownFollowerFailure implements FollowerFailure {
  final String message;

  UnknownFollowerFailure(this.message);
}
