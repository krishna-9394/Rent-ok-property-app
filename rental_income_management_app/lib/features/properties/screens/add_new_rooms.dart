import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rental_income_management_app/features/properties/controllers/properties_controller.dart';

import '../../../utility/enums.dart';
import '../controllers/room_controller.dart';

class RoomManagementScreen extends StatelessWidget {
  RoomManagementScreen({super.key});
  final roomController = Get.put(RoomController());
  final propertyController = Get.put(PropertyController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Add Rooms",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 30),
          // Room Details Input
          TextField(
            controller: roomController.roomNumber,
            decoration: const InputDecoration(labelText: "Room Number"),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: roomController.roomDescription,
            decoration: const InputDecoration(labelText: "Room Description"),
          ),
          const SizedBox(height: 16),

          // paritions
          Row(
            children: [
              const Expanded(flex: 1, child: Divider(thickness: 2)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("Partitions",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const Expanded(flex: 1, child: Divider(thickness: 2)),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (roomController.partitionList.isEmpty) {
              // Show animation or message when the list is empty
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 50, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No partitions available",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              );
            }

            // Display the list if it has items
            return Column(
              children: [
                ...roomController.partitionList.map((partition) {
                  return ListTile(
                    title: Text("Rent: \$${partition.rent}"),
                    subtitle: Text(
                      "Status: ${partition.status == RoomStatus.vacant ? "Vacant" : "Occupied"}\nTenant ID: ${partition.tenantId.isEmpty ? "N/A" : partition.tenantId}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        roomController.partitionList.remove(partition);
                      },
                    ),
                  );
                }).toList(),
              ],
            );
          }),

          const SizedBox(height: 16),
          // paritions
          Row(
            children: [
              const Expanded(flex: 1, child: Divider(thickness: 2)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("Add New Partition",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const Expanded(flex: 1, child: Divider(thickness: 2)),
            ],
          ),
          const SizedBox(height: 20),
          // Add Partition Input Fields
          TextField(
            controller: roomController.rent,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Rent"),
          ),
          const SizedBox(height: 16),
          Obx(() {
            // Select the Brands to load
            return DropdownButtonFormField<RoomStatus>(
              value: roomController.roomStatus.value,
              items: RoomStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(
                    status == RoomStatus.vacant ? "Vacant" : "Occupied",
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  roomController.roomStatus.value = value;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Vacancy Status',
              ),
              validator: (value) =>
                  value == null ? 'Please select a Role' : null,
            );
          }),
          const SizedBox(height: 16),
          TextField(
            controller: TextEditingController(),
            onChanged: (value) => roomController.currentTenantId.value = value,
            decoration:
                const InputDecoration(labelText: "Tenant ID (Optional)"),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: roomController.addPartition,
            child: const Text("Add Partition"),
          ),
          const SizedBox(height: 16),

          // Add Room Button
          ElevatedButton(
            onPressed: () {
              roomController.addRoom();
              Navigator.pop(context); // Close the modal after adding the room
            },
            child: const Text("Add Room"),
          ),
        ],
      ),
    );
  }
}
