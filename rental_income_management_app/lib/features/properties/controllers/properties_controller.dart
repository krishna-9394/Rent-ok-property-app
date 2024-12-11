import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_income_management_app/data/repositories/property_repository.dart';
import 'package:rental_income_management_app/data/repositories/user_repository.dart';
import 'package:rental_income_management_app/features/authentication/controllers/user_controller.dart';
import 'package:rental_income_management_app/features/properties/screens/properties_detail.dart';
import 'package:rental_income_management_app/models/partition.dart';
import 'package:rental_income_management_app/models/property.dart';
import 'package:rental_income_management_app/models/room.dart';
import 'package:rental_income_management_app/models/user.dart';
import 'package:rental_income_management_app/utility/enums.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../../../utility/constants.dart/images_string.dart';
import '../../../utility/helpers/network_manager.dart';
import '../../../utility/popups/full_screen_loaders.dart';
import '../../../utility/popups/loaders.dart';
import '../screens/properties.dart';

class PropertyController extends GetxController {
  static PropertyController get instance => Get.find();

  final propertyName = TextEditingController();
  final selectedPropertyType = "".obs;
  final propertyDescription = TextEditingController();
  final ownerId = "".obs;
  final flatHouseBuildingName = TextEditingController();
  final areaStreetSectorVillageName = TextEditingController();
  final pincode = TextEditingController();
  final townCityName = TextEditingController();
  final country = TextEditingController();

  final propertyRepository = Get.put(PropertyRepository());
  final userRepository = Get.put(UserRepository());
  // for assigning the manager
  final RxList<UserModel> managersAvailable = <UserModel>[].obs;
  final assignedManager = UserModel.empty().obs;
  final selectedProperty = PropertyModel.empty().obs;

  // rooms list
  final RxList<RoomModel> rooms = <RoomModel>[].obs;
  final refreshData = true.obs;

  GlobalKey<FormState> propertyFormKey = GlobalKey<FormState>();
  final Rx<PropertyModel> selectedAddress = PropertyModel.empty().obs;

  // Fetch all user specific addresses
  Future<List<PropertyModel>> getAllUserProperties() async {
    try {
      final properties = await propertyRepository.fetchUsersProperties();
      return properties;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Address not found", message: e.toString());
      return [];
    }
  }

  // Add New Property
  Future addNewProperty() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Property...', TImages.docerAnimation);

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!propertyFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Property
      final property = PropertyModel(
        id: '',
        name: propertyName.text.trim(),
        propertyType:
            propertyMap[selectedPropertyType.value] ?? Property.residential,
        description: propertyDescription.text.trim(),
        ownerId: AuthenticationRepository.instance.authUser!.uid,
        flatHouseBuildingName: flatHouseBuildingName.text.trim(),
        areaStreetSectorVillage: areaStreetSectorVillageName.text.trim(),
        postalCode: pincode.text.trim(),
        townCity: townCityName.text.trim(),
        country: country.text.trim(),
        rooms: rooms.value,
        registeredOn: DateTime.now(),
        updatedOn: null,
      );

      final id = await propertyRepository.addNewProperty(property);

      // Remove Loaders
      TFullScreenLoader.stopLoading();

      // show Success message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your Property has been saved successfully',
      );

      // refresh Addresses data
      refreshData.toggle();

      // reset field
      resetFormField();

      // redirecting to addresses screens
      Get.to(() => const PropertyScreen());
    } catch (e) {
      // remove loaders
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Property could not be added..', message: e.toString());
    }
  }

  // Fetch the list of all managers
  Future<void> getAllTheManagersList() async {
    try {
      final managers = await userRepository.fetchManagers();
      managers.clear();
      managersAvailable.assignAll(managers);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Managers not found", message: e.toString());
    }
  }

  // Fetch and assign already assigned manager if applicable
  Future<void> fetchAssignedManager(String assignedManagerId) async {
    try {
      final manager =
          await userRepository.fetchUserDetailsWithUID(assignedManagerId);
      assignedManager.value = manager;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Assigned Manager Error", message: e.toString());
    }
  }

  // assign manager to the property.
  Future<void> assignManager() async {
    Map<String, dynamic> updatedProperty = selectedProperty.value.toJson();
    updatedProperty['managerAssigned'] = assignedManager.value.id;
    await propertyRepository.updatePropertyField(
      selectedProperty.value.id,
      updatedProperty,
    );
    Get.off(PropertyDetailsScreen(property: selectedProperty.value));
  }

  // add room
  Future<void> addRooms(RoomModel room) async {
    selectedProperty.value.rooms.add(room);
    Map<String, dynamic> updatedProperty = selectedProperty.value.toJson();
    await propertyRepository.updatePropertyField(
      selectedProperty.value.id,
      updatedProperty,
    );
    Get.off(PropertyDetailsScreen(property: selectedProperty.value));
  }

  resetFormField() {
    propertyName.clear();
    selectedPropertyType.value = "";
    propertyDescription.clear();
    flatHouseBuildingName.clear();
    areaStreetSectorVillageName.clear();
    pincode.clear();
    townCityName.clear();
    country.clear();
    rooms.clear();
    propertyFormKey.currentState?.reset();
  }

  // Future<dynamic> selectNewAddressPopup(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (_) => Container(
  //             padding: const EdgeInsets.all(TSizes.lg),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const TSectionHeading(
  //                   title: 'Select Address',
  //                   showActionButton: false,
  //                 ),
  //                 Expanded(
  //                   child: FutureBuilder(
  //                     future: getAllUserAddresses(),
  //                     builder: (_, snapshot) {
  //                       final response =
  //                           TCloudHelperFunctions.checkMultiRecordState(
  //                               snapshot: snapshot);
  //                       if (response != null) return response;

  //                       return ListView.builder(
  //                           shrinkWrap: true,
  //                           itemCount: snapshot.data!.length,
  //                           itemBuilder: (_, index) => TSingleAddress(
  //                               address: snapshot.data![index],
  //                               onTap: () async {
  //                                 await selectedAddress(snapshot.data![index]);
  //                                 Get.back();
  //                               }));
  //                     },
  //                   ),
  //                 ),
  //                 const SizedBox(height: TSizes.defaultSpace * 2),
  //                 SizedBox(
  //                   width: double.infinity,
  //                   child: ElevatedButton(
  //                     child: const Text("Add new Address"),
  //                     onPressed: () => Get.to(
  //                       () => const AddNewAddressScreen(),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ));
  // }
}
