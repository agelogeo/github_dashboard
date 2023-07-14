import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_dashboard/core/assets.dart';
import 'package:github_dashboard/followers/domain/entities/follower_failure.dart';

class FollowersErrorPage extends StatelessWidget {
  const FollowersErrorPage({
    super.key,
    required this.failure,
  });

  final FollowerFailure failure;

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
      case UnknownFollowerFailure():
      case FollowerNotFoundFailure():
        return Assets.illustrations.noData;
      case RateLimitExceeded():
        return Assets.illustrations.wait;
    }
  }

  String errorMessage() {
    switch (failure) {
      case FollowerNotFoundFailure(message: final msg):
        return msg;
      case RateLimitExceeded(message: final msg):
        return msg;
      case UnknownFollowerFailure(message: final msg):
        return msg;
    }
  }
}
