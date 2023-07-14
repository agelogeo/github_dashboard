import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_dashboard/core/assets.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_failure.dart';

class UserRepositoriesErrorPage extends StatelessWidget {
  const UserRepositoriesErrorPage({
    super.key,
    required this.failure,
  });

  final UserRepositoryFailure failure;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 250,
          child: SvgPicture.asset(errorIllustration()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            errorMessage(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  String errorIllustration() {
    switch (failure) {
      case UserUnknownRepositoryFailure():
      case UserRepositoryNotFoundFailure():
        return Assets.illustrations.noData;
      case RateLimitExceeded():
        return Assets.illustrations.wait;
    }
  }

  String errorMessage() {
    switch (failure) {
      case UserRepositoryNotFoundFailure(message: final msg):
        return msg;
      case RateLimitExceeded(message: final msg):
        return msg;
      case UserUnknownRepositoryFailure(message: final msg):
        return msg;
    }
  }
}
