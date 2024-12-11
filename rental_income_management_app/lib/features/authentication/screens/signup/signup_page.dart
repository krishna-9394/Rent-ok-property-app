import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/bottom_icon_button.dart';
import '../../../../common/widgets/divider.dart';
import '../../../../utility/constants.dart/sizes.dart';
import '../../../../utility/constants.dart/text_strings.dart';
import '../../../../utility/helpers/helper_functions.dart';
import 'signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Form
              SignupForm(isDark: isDark),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Divider
              TDivider(isDark: isDark, title: TTexts.orSignUpWith),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Social Media Button
              // const BottomIconButton()
            ],
          ),
        ),
      ),
    );
  }
}
