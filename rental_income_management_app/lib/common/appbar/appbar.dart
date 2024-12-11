import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utility/constants.dart/colors.dart';
import '../../utility/constants.dart/sizes.dart';
import '../../utility/device_utility.dart';
import '../../utility/helpers/helper_functions.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar(
      {super.key,
      this.title,
      required this.showBackArrow,
      this.iconData,
      this.actions,
      this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? iconData;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        actions: actions,
        title: title,
        automaticallyImplyLeading: showBackArrow,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Iconsax.arrow_left),
                color: THelperFunctions.isDarkMode(context)
                    ? TColors.light
                    : TColors.dark,
              )
            : iconData != null
                ? IconButton(
                    icon: Icon(iconData),
                    onPressed: leadingOnPressed,
                  )
                : null,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
