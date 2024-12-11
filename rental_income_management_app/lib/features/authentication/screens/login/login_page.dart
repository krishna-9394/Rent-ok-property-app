import 'package:flutter/material.dart';
import 'package:rental_income_management_app/features/authentication/screens/login/widget/login_form.dart';
import 'package:rental_income_management_app/features/authentication/screens/login/widget/login_header.dart';

import '../../../../common/widgets/bottom_icon_button.dart';
import '../../../../common/widgets/divider.dart';
import '../../../../utility/constants.dart/images_string.dart';
import '../../../../utility/constants.dart/sizes.dart';
import '../../../../utility/constants.dart/text_strings.dart';
import '../../../../utility/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TSizes.appBarHeight,
            bottom: TSizes.defaultSpace,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              /// Logo, title, and subtitle
              AuthenticationHeaders(
                isDark: isDark,
                title: TTexts.loginTitle,
                subtitle: TTexts.loginSubTitle,
                image: isDark ? TImages.lightAppLogo : TImages.darkAppLogo,
              ),

              /// Login Form
              const LoginForm(),

              /// Divider
              TDivider(
                isDark: isDark,
                title: TTexts.orSignInWith,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Footer
              // const BottomIconButton()
            ],
          ),
        ),
      ),
    );
  }
}
