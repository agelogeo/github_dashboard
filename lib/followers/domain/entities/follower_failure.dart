import 'package:equatable/equatable.dart';

sealed class FollowerFailure {}

class FollowerNotFoundFailure extends Equatable implements FollowerFailure {
  final String message;

  const FollowerNotFoundFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UnknownFollowerFailure extends Equatable implements FollowerFailure {
  final String message;

  const UnknownFollowerFailure(this.message);

  @override
  List<Object> get props => [message];
}
