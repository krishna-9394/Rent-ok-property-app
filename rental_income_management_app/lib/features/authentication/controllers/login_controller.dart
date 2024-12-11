import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../../../utility/constants.dart/images_string.dart';
import '../../../utility/helpers/network_manager.dart';
import '../../../utility/popups/full_screen_loaders.dart';
import '../../../utility/popups/loaders.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // variables
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  // Rx variables
  final hidePassword = true.obs;
  final rememberMe = false.obs;

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? "";
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? "";
    super.onInit();
  }

  // update the hidePassword
  void updatePasswordStatus() {
    hidePassword.value = !hidePassword.value;
  }

  // update the rememberMe
  void updateRememberStatus() {
    rememberMe.value = !rememberMe.value;
  }

  // TODO 3: use google login.
  // Future<void> googleSignIn() async {
  //   try {
  //     TFullScreenLoader.openLoadingDialog(
  //         'Logging you in...', TImages.docerAnimation);
  //     // Check Internet Connectivity
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }

  //     // Google Authentication
  //     final userCredentials =
  //         await AuthenticationRepository.instance.signInWithGoogle();

  //     // save User Records
  //     await UserController.instance.saveUserRecord(userCredentials);

  //     // Remove loading animation
  //     TFullScreenLoader.stopLoading();

  //     // Redirect
  //     AuthenticationRepository.instance.screenRedirect();
  //   } catch (e) {
  //     TFullScreenLoader.stopLoading();
  //     //  Show some generic error to user
  //     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //   }
  // }

  // Login with Gmail
  Future<void> logInWithGmail() async {
    try {
      // start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // RememberMe
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      // Login the user in the firebase Authentication & load user data from firestore
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Remove loading animation
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      //  Show some generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Login with Email and Password
  Future<void> loginWithEmailAndPassword() async {
    try {
      // start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.docerAnimation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!loginKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // RememberMe
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      // Login the user in the firebase Authentication & load user data from firestore
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Remove loading animation
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      //  Show some generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
