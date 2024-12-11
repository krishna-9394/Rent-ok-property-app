import 'package:flutter/material.dart';

import '../../utility/constants.dart/colors.dart';
import '../../utility/constants.dart/sizes.dart';
import '../../utility/helpers/helper_functions.dart';

class TRoundedButton extends StatelessWidget {
  final double? height, width;
  final Icon icon;
  final bool applyImageRadius;
  final Color? backgroundColor;
  final BoxFit? fit;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding, margin;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;

  const TRoundedButton({
    super.key,
    this.height,
    this.width,
    required this.icon,
    this.applyImageRadius = true,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onTap,
    this.border,
    this.borderRadius = TSizes.md,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
      
          border: border,
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: icon,
        ),
      ),
    );
  }
}
