import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rental_income_management_app/utility/enums.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../models/user.dart';
import '../../../navigation_menu.dart';
import '../../../utility/constants.dart/images_string.dart';
import '../../../utility/helpers/network_manager.dart';
import '../../../utility/popups/full_screen_loaders.dart';
import '../../../utility/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final selectedRole = "".obs;
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  // Rx variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  // update the hidePassword
  void updatePasswordStatus() {
    hidePassword.value = !hidePassword.value;
  }

  // update the privacy policy status
  void updatePrivacyPolicyStatus(value) {
    privacyPolicy.value = value;
  }

  // Signup
  Future<void> singUp() async {
    try {
      // start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing the information...', TImages.docerAnimation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!signupKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // // Privacy Policy
      // if (!privacyPolicy.value) {
      //   TLoaders.warningSnackBar(
      //     title: 'Accept Privacy Policy',
      //     message:
      //         'In order to create account, you have to read and accept the Privacy Policy & Terms of Use',
      //   );
      //   return;
      // }

      // Register the user in the firebase Authentication & save user data in firestore
      final userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      final role = roleMap[selectedRole.value];

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        role: role ?? Role.visitor,
        totalRentMonthly: 0,
        pendingRentDuesMonthly: 0,
        properties: [],
        createdOn: DateTime.now(),
        updatedOn: DateTime.now(),
      );

      final userRepository = Get.put(UserRepository());
      // saving the user records online.
      await userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();

      // show success message
      TLoaders.successSnackBar(
          title: "Congratulations", message: "Your account has been created.");
      Get.to(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      //  Show some generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
