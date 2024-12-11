import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repository.dart';
import '../../../models/user.dart';
import '../../../utility/constants.dart/sizes.dart';
import '../../../utility/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  // Rx Variable
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    fetchUserRecords();
  }

  // fetch user records
  Future<void> fetchUserRecords() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // save user records
  Future<UserModel> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First update the Rx-User and then check if user data is already stored. if not store new data
      await fetchUserRecords();

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          final userCredentials = userCredential.user;
          // convert Name to first and last name
          final nameParts =
              UserModel.nameParts(userCredentials!.displayName ?? "");

          final newUser = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts[1] : "",
            email: userCredential.user!.email ?? "",
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            role: user.value.role,
            totalRentMonthly: 0,
            pendingRentDuesMonthly: 0,
            properties: [],
            createdOn: DateTime.now(),
            updatedOn: DateTime.now(),
          );

          // save user data remotely
          await userRepository.saveUserRecord(newUser);

          return newUser;
        }
      }
      return UserModel.empty();
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your profile.');
      return UserModel.empty();
    }
  }

  // Delete account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all the data will be removed permanently.',
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text("Cancel"),
        ),
        const Spacer(),
        ElevatedButton(
          // TODO 2: deleteUserAccount()
          // onPressed: () async => deleteUserAccount(),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete'),
          ),
        ),
      ],
    );
  }

  // //  Delete User account
  // void deleteUserAccount() async {
  //   try {
  //     TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

  //     // first reauthenticate the user
  //     final auth = AuthenticationRepository.instance;
  //     final provider =
  //         auth.authUser!.providerData.map((e) => e.providerId).first;
  //     if (provider.isNotEmpty) {
  //       // Re-verify Auth Email and Password
  //       if (provider == 'google.com') {
  //         await auth.signInWithGoogle();
  //         await auth.deleteAccount();
  //         TFullScreenLoader.stopLoading();
  //         Get.to(() => const LoginScreen());
  //       } else if (provider == 'password') {
  //         TFullScreenLoader.stopLoading();
  //         Get.to(() => const ReAuthLoginForm());
  //       }
  //     }
  //   } catch (e) {
  //     TFullScreenLoader.stopLoading();
  //     TLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
  //   }
  // }

  // // Reauthenticate before deleting
  // Future<void> reauthenticateEmailAndPasswordUser() async {
  //   try {
  //     TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

  //     // Checking connectivity
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }

  //     // validating the form
  //     if (!reAuthFormKey.currentState!.validate()) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }

  //     await AuthenticationRepository.instance
  //         .reAuthenticateWithEmailAndPassword(
  //       verifyEmail.text.trim(),
  //       verifyPassword.text.trim(),
  //     );
  //     await AuthenticationRepository.instance.deleteAccount();
  //     TFullScreenLoader.stopLoading();
  //     Get.offAll(() => const LoginScreen());
  //   } catch (e) {
  //     TFullScreenLoader.stopLoading();
  //     TLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
  //   }
  // }

  // // upload profile picture
  // Future<void> uploadProfilePicture() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 70,
  //       maxHeight: 512,
  //       maxWidth: 512,
  //     );
  //     // TODO: #1 make a image cropper to crop image
  //     if (image != null) {
  //       imageUploading.value = true;
  //       final imageUrl =
  //           await userRepository.uploadImage('User/Images/Profile/', image);
  //       // update user Image Record
  //       Map<String, dynamic> json = {'ProfilePicture': imageUrl};
  //       await userRepository.updateSingleField(json);

  //       user.value.profilePicture = imageUrl;
  //       user.refresh();
  //     }
  //     TLoaders.successSnackBar(
  //       title: 'Congratulations',
  //       message: 'Your profile image has been updated!.',
  //     );
  //   } catch (e) {
  //     TLoaders.errorSnackBar(
  //       title: 'Oh Snap',
  //       message: 'Something went wrong: $e',
  //     );
  //   } finally {
  //     imageUploading.value = false;
  //   }
  // }

  Future<void> saveUserLocally() async {
    try {
      await fetchUserRecords();
      await userRepository.saveUserLocally(user.value);
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: 'Something went wrong: $e',
      );
    }
  }

  Future<UserModel> getCachedUser() async {
    try {
      UserModel user = await userRepository.getCachedUser();
      return user;
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: 'Something went wrong: $e',
      );
      return UserModel.empty();
    }
  }

  Future<void> removeCachedUser() async {
    try {
      await userRepository.removeCachedUser();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: 'Something went wrong: $e',
      );
    }
  }

  // Future<Uint8List?> getCachedProfilePicture() async {
  //   try {
  //     Uint8List byteArray = await userRepository
  //         .getCachedProfilePicture(user.value.profilePicture);
  //     return byteArray;
  //   } catch (e) {
  //     TLoaders.errorSnackBar(
  //       title: 'Oh Snap!',
  //       message: 'Something went wrong: $e',
  //     );
  //   }
  //   return null;
  // }

  // Future<void> cacheProfilePicture() async {
  //   try {
  //     await userRepository.cachedProfilePicture(user.value.profilePicture);
  //   } catch (e) {
  //     TLoaders.errorSnackBar(
  //       title: 'Oh Snap!',
  //       message: 'Something went wrong: $e',
  //     );
  //   }
  // }
}
