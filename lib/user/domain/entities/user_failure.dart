import 'package:equatable/equatable.dart';

sealed class UserFailure {}

class UserNotFoundFailure extends Equatable implements UserFailure {
  final String message;

  const UserNotFoundFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UnknownUserFailure extends Equatable implements UserFailure {
  final String message;

  const UnknownUserFailure(this.message);

  @override
  List<Object> get props => [message];
}
