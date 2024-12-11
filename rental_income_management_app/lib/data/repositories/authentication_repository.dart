import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/authentication/controllers/user_controller.dart';
import '../../features/authentication/screens/login/login_page.dart';
import '../../models/user.dart';
import '../../navigation_menu.dart';
import '../../utility/exception/firebase_auth_exception.dart';
import '../../utility/exception/firebase_exception.dart';
import '../../utility/exception/format_exception.dart';
import '../../utility/exception/platform_exception.dart';
import '../../utility/storage_utility.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get Authenticated user data
  User? get authUser => _auth.currentUser;

  // called from main.dart on app launch
  @override
  void onReady() {
    // remove native splash screen
    // FlutterNativeSplash.remove();

    // redirect to appropriate screen
    screenRedirect();
  }

  screenRedirect() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      // to navigate to menu if the user is already signedIn
      await TLocalStorage.init(user.uid);
      // Check if user data exists
      UserModel? cachedUser = TLocalStorage.instance().getUser();
      if (cachedUser == null) {
        // User data exists, proceed to the main screen
        await UserController.instance.saveUserLocally();
      }
      Get.offAll(() => const NavigationMenu());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  /* ----------------------------Email & Password SignIn---------------------- */
  /// SignIn
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong! Please try again.";
    }
  }

  /// Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong! Please try again.";
    }
  }

  // TODO 1: check the role function.
  // Future<Role> fetchRole(String email) async {
  // try {
  //   final user = _auth.currentUser;
  //   if (user == null) {
  //     throw Exception('No user is signed in.');
  //   }
  //   final email = user.email;
  //   // Check if the email is in the admins collection
  //   final adminSnapshot =
  //       await _db.collection('admin').where('email', isEqualTo: email).get();

  //   if (adminSnapshot.docs.isNotEmpty) {
  //     return Role.admin;
  //   }

  //   // Check if the email is in the retailers collection
  //   final retailerSnapshot = await _db
  //       .collection('retailer')
  //       .where('email', isEqualTo: email)
  //       .get();

  //   if (retailerSnapshot.docs.isNotEmpty) {
  //     return Role.shopkeeper;
  //   }

  //   // If the email is not found in either collection, default to customer
  //   return Role.customer;
  // } on FirebaseException catch (e) {
  //   throw TFirebaseException(e.toString());
  // } on FormatException catch (e) {
  //   throw TFormatException(e.toString());
  // } on PlatformException catch (e) {
  //   throw TPlatformException(e.toString());
  // } catch (e) {
  //   throw 'Something went wrong. Please try again';
  // }
  // }

  /// Forget Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong! Please try again.";
    }
  }

  /// Re-Authenticate User
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      // create a credentials
      AuthCredential authCredential =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong! Please try again.";
    }
  }

  /// Google SignIn
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // create a new Credentials
      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      // once signed in, return the credentials
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("Something went wrong: ${e.toString()}");
      return null;
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      await TLocalStorage.instance().removeUser();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong! Please try again.";
    }
  }

  // /// Delete the user account
  // Future<void> deleteAccount() async {
  //   try {
  //     await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
  //     await _auth.currentUser!.delete();
  //     await TLocalStorage.instance().removeUser();
  //   } on FirebaseAuthException catch (e) {
  //     throw TFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw "Something went wrong! Please try again.";
  //   }
  // }
}
