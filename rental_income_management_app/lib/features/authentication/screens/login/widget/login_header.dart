import 'package:flutter/material.dart';

import '../../../../../utility/constants.dart/sizes.dart';

class AuthenticationHeaders extends StatelessWidget {
  const AuthenticationHeaders({
    super.key,
    required this.isDark,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final bool isDark;
  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(image),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.defaultSpace),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
