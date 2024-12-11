import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/authentication/controllers/login_controller.dart';
import '../../utility/constants.dart/colors.dart';
import '../../utility/constants.dart/images_string.dart';
import '../../utility/constants.dart/sizes.dart';

class BottomIconButton extends StatelessWidget {
  const BottomIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      //   Container(
      //     decoration: BoxDecoration(
      //       border: Border.all(color: TColors.grey),
      //       borderRadius: BorderRadius.circular(100),
      //     ),
      //     child: IconButton(
      //       icon: const Image(
      //         height: TSizes.iconMd,
      //         width: TSizes.iconMd,
      //         image: AssetImage(TImages.google),
      //       ),
      //       onPressed: () => controller.googleSignIn(),
      //     ),
      //   ),
      //   const SizedBox(width: TSizes.spaceBtwItems),
      //   Container(
      //     decoration: BoxDecoration(
      //       border: Border.all(color: TColors.grey),
      //       borderRadius: BorderRadius.circular(100),
      //     ),
      //     child: IconButton(
      //       icon: const Image(
      //         height: TSizes.iconMd,
      //         width: TSizes.iconMd,
      //         image: AssetImage(TImages.facebook),
      //       ),
      //       onPressed: () {},
      //     ),
      //   )
      ],
    );
  }
}
