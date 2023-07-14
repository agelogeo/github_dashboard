import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_dashboard/core/assets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 250,
          child: SvgPicture.asset(
            Assets.illustrations.welcome,
            alignment: Alignment.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Text('Welcome',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.grey[400])),
        ),
      ],
    );
  }
}
