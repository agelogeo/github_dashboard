sealed class UserFailure {}

class UserNotFoundFailure implements UserFailure {
  final String message;

  UserNotFoundFailure(this.message);
}
