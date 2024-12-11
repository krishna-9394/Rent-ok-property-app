// Controller for managing state
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_income_management_app/features/properties/controllers/properties_controller.dart';

import '../../../models/partition.dart';
import '../../../models/room.dart';
import '../../../utility/enums.dart';

class RoomController extends GetxController {
  final RxList<RoomModel> rooms = <RoomModel>[].obs;
  final roomNumber = TextEditingController();
  final roomDescription = TextEditingController();
  final RxList<Partition> partitionList = <Partition>[].obs;
  final rent = TextEditingController();
  final roomStatus = RoomStatus.vacant.obs;
  final currentTenantId = "".obs;
  final propertyController = Get.put(PropertyController());

  // Add partition to the list
  void addPartition() {
    if (rent.text.isNotEmpty) {
      partitionList.add(Partition(
        rent: int.parse(rent.text),
        status: roomStatus.value,
        tenantId: currentTenantId.value,
        paymentHistory: '',
      ));
      rent.clear();
      roomStatus.value = RoomStatus.vacant;
      currentTenantId.value = "";
    }
  }

  // Add room to the list
  void addRoom() async {
    if (roomNumber.text.isNotEmpty && roomDescription.text.isNotEmpty) {
      propertyController.addRooms(
        RoomModel(
          id: DateTime.now().toString(),
          description: roomDescription.text,
          roomNumber: roomNumber.text,
          partitions: partitionList.toList(),
        ),
      );
      roomNumber.clear();
      roomDescription.clear();
      partitionList.clear();
    }
  }
}
