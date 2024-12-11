import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rental_income_management_app/models/property.dart';

import 'authentication_repository.dart';

class PropertyRepository extends GetxController {
  static PropertyRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // fetch user properties.
  Future<List<PropertyModel>> fetchUsersProperties() async {
    try {
      // Replace with the logic to get the `ownerId`
      final ownerId = AuthenticationRepository.instance.authUser!.uid;
      if (ownerId.isEmpty) {
        throw 'Unable to find user information. Please try again in a few minutes.';
      }

      // Query to fetch properties where ownerId matches
      final results = await _db
          .collection('properties')
          .where('ownerId', isEqualTo: ownerId)
          .get();

      // Map results to the PropertyModel
      return results.docs
          .map((documentSnapshot) =>
              PropertyModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw ('Something went wrong while fetching properties. Please try again later.');
    }
  }

  // Update a specific field for a property
  Future<void> updatePropertyField(
      String propertyId, Map<String, dynamic> propertyData) async {
    try {
      // Get the user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;

      if (userId.isEmpty) {
        throw 'Unable to find user information. Please try again in a few minutes.';
      }

      // Update the specified field for the given propertyId
      await _db.collection('properties').doc(propertyId).set(propertyData);
    } catch (e) {
      throw 'Unable to update the property. Try again later.';
    }
  }

  // Add a new property
  Future<String> addNewProperty(PropertyModel property) async {
    try {
      // Get the user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;

      property.ownerId = userId;

      if (userId.isEmpty) {
        throw 'Unable to find user information. Please try again in a few minutes.';
      }

      // Add the property to the Firestore collection
      final newProperty =
          await _db.collection('properties').add(property.toJson());

      // Return the newly created property ID
      return newProperty.id;
    } catch (e) {
      throw 'Unable to add the new property. Please try again later.';
    }
  }

  // Add new rooms for the property
  // Future<String> addRoomsInProperty() async {}
}
