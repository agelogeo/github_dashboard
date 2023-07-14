import 'package:flutter/material.dart';
import 'package:github_dashboard/user/domain/entities/user_entity.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${user.login}'),
        Text('${user.publicRepos}'),
      ],
    );
  }
}
