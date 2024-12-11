import 'package:flutter/material.dart';

import '../../utility/constants.dart/colors.dart';

class TDivider extends StatelessWidget {
  const TDivider({
    super.key,
    required this.isDark,
    required this.title,
  });

  final bool isDark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Divider(
            color: isDark ? TColors.darkGrey : TColors.grey,
            thickness: 0.9,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Flexible(
          child: Divider(
            color: isDark ? TColors.darkGrey : TColors.grey,
            thickness: 0.9,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
