import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utility/constants.dart/sizes.dart';
import '../../../../../utility/constants.dart/text_strings.dart';
import '../../../../../utility/validators.dart';
import '../../../controllers/login_controller.dart';
import '../../signup/signup_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // correct the controller
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: TSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            /// Email Input Field
            TextFormField(
              controller: controller.email,
              expands: false,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password Input Field
            Obx(
              () => TextFormField(
                controller: controller.password,
                expands: false,
                obscureText: controller.hidePassword.value,
                validator: (value) =>
                    TValidator.validateEmptyString('Password', value),
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.updatePasswordStatus(),
                    icon: Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Remember me and forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.updateRememberStatus(),
                      ),
                    ),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                /// forgot password
                TextButton(
                  // TODO 2: complete this.
                  // onPressed: () => Get.to(() => const ForgotPasswordScreen()),
                  onPressed: () {},
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// SignIn Button
            SizedBox(
              /// sized box is used to keep the button long
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.loginWithEmailAndPassword(),
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(TTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
