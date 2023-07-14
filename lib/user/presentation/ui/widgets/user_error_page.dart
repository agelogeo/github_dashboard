import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_dashboard/core/assets.dart';
import 'package:github_dashboard/user/domain/entities/user_failure.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.failure,
  });

  final UserFailure failure;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 250,
          child: SvgPicture.asset(
            Assets.illustrations.noData,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            failure is UserNotFoundFailure
                ? 'User not found'
                : 'An error occurred',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
