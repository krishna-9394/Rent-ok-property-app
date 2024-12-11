import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_income_management_app/data/repositories/authentication_repository.dart';

import '../../models/user.dart';
import '../../utility/exception/firebase_exception.dart';
import '../../utility/exception/format_exception.dart';
import '../../utility/exception/platform_exception.dart';
import '../../utility/storage_utility.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user data to firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetailsWithUID(String uid) async {
    try {
      final documentSnapshot = await _db
          .collection("users")
          .doc(uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to update user details based on user ID
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //Function to update user detail
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //Function to remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to fetch all users with the role of "manager"
  Future<List<UserModel>> fetchManagers() async {
    try {
      // Query Firestore to get all users with role "manager"
      final querySnapshot = await _db
          .collection("users")
          .where("Role", isEqualTo: "manager")
          .get();

      // Convert the QuerySnapshot into a list of UserModel
      final managers = querySnapshot.docs.map((doc) {
        return UserModel.fromSnapshot(doc);
      }).toList();

      return managers;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // // Upload Data
  // Future<String> uploadImage(String path, XFile image) async {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(path).child(image.name);
  //     await ref.putFile(File(image.path));
  //     final url = await ref.getDownloadURL();
  //     return url;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.toString());
  //   } on FormatException catch (e) {
  //     throw TFormatException(e.toString());
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.toString());
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  Future<void> saveUserLocally(UserModel user) async {
    try {
      await TLocalStorage.instance().saveUser(user);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<UserModel> getCachedUser() async {
    try {
      UserModel? user = TLocalStorage.instance().getUser();
      if (user == null) return UserModel.empty();
      return user;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> removeCachedUser() async {
    try {
      await TLocalStorage.instance().removeUser();
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> cachedProfilePicture(String imageUrl) async {
    try {
      await TLocalStorage.instance().cacheProfilePicture(imageUrl);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<Uint8List> getCachedProfilePicture(String imageUrl) async {
    try {
      Uint8List cachedByteArray =
          TLocalStorage.instance().getCachedProfilePicture(imageUrl);
      return cachedByteArray;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
