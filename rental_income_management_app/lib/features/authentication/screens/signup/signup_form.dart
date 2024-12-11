import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rental_income_management_app/utility/enums.dart';

import '../../../../utility/constants.dart/sizes.dart';
import '../../../../utility/constants.dart/text_strings.dart';
import '../../../../utility/validators.dart';
import '../../controllers/signup_controller.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupKey,
      child: Column(
        children: [
          /// First name and Last name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  expands: false,
                  validator: (value) =>
                      TValidator.validateEmptyString('First Name', value),
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              // last name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  expands: false,
                  validator: (value) =>
                      TValidator.validateEmptyString('Last Name', value),
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // /// UserName
          // TextFormField(
          //   controller: controller.userName,
          //   expands: false,
          //   validator: (value) =>
          //       TValidator.validateEmptyString('Username', value),
          //   decoration: const InputDecoration(
          //     labelText: TTexts.username,
          //     prefixIcon: Icon(Iconsax.user_edit),
          //   ),
          // ),
          // const SizedBox(height: TSizes.spaceBtwInputFields),

          /// email
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

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            expands: false,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              expands: false,
              obscureText: controller.hidePassword.value,
              validator: (value) => TValidator.validatePassword(value),
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

          /// Confirm Password
          Obx(
            () => TextFormField(
              controller: controller.confirmPassword,
              expands: false,
              obscureText: controller.hidePassword.value,
              validator: (value) => TValidator.validateConfirmPassword(
                  value, controller.password.text.trim()),
              decoration: InputDecoration(
                labelText: TTexts.confirmPassword,
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

          // Select the Brands to load
          DropdownButtonFormField<String>(
            value: controller.selectedRole.value.isEmpty
                ? null
                : controller.selectedRole.value,
            items: roleMap.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.key),
              );
            }).toList(),
            onChanged: (newValue) {
              controller.selectedRole.value = newValue ?? "";
            },
            decoration: const InputDecoration(
              labelText: 'Select a Brand',
              prefixIcon: Icon(Iconsax.category),
            ),
            validator: (value) =>
                value == null ? 'Please select a Role' : null,
          ),

          // TODO 2: complete this.
          /// Terms and Conditions
          // TermsAndConditions(isDark: isDark),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Create Account Button
          SizedBox(
            /// sized box is used to keep the button long
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.singUp(),
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
