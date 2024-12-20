import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utility/constants.dart/colors.dart';
import '../../../utility/helpers/helper_functions.dart';

class TShimmerEffect extends StatelessWidget {
  final double width, height, radius;
  final Color? color;
  const TShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color ?? (isDark ? TColors.darkGrey : TColors.white),
        ),
      ),
    );
  }
}
