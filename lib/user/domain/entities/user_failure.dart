sealed class UserFailure {}

class UserNotFoundFailure implements UserFailure {
  final String message;

  UserNotFoundFailure(this.message);
}

class UnknownUserFailure implements UserFailure {
  final String message;

  UnknownUserFailure(this.message);
}
