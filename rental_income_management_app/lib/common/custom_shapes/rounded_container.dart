import 'package:flutter/material.dart';

import '../../utility/constants.dart/colors.dart';
import '../../utility/constants.dart/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  final Widget? child;
  final bool showBorder;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? padding, margin;
  const TRoundedContainer(
      {super.key,
      this.height,
      this.width,
      this.padding,
      this.borderRadius = TSizes.borderRadiusLg,
      this.child,
      this.showBorder = false,
      this.borderColor = TColors.borderPrimary,
      this.margin,
      this.backgroundColor = TColors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
