import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../controllers/properties_controller.dart';

class ManagerSelectionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyController());
    controller.getAllTheManagersList();
    final searchController = TextEditingController();
    final filteredManagers = <UserModel>[].obs;

    return Obx(() {
      // Update filtered managers when search query changes
      filteredManagers.assignAll(
        controller.managersAvailable.where((manager) {
          final query = searchController.text.toLowerCase();
          return manager.fullName.toLowerCase().contains(query);
        }).toList(),
      );

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Assign Manager",style: TextStyle(fontSize: 20),), 
              const SizedBox(height: 30),
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Manager',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (_) {
                  filteredManagers.refresh();
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<UserModel>(
                value: controller.assignedManager.value.id.isNotEmpty
                    ? controller.assignedManager.value
                    : null,
                items: filteredManagers.map((manager) {
                  return DropdownMenuItem(
                    value: manager,
                    child: Text(manager.fullName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.assignedManager.value = value;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Select Manager',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.assignedManager.value.id.isNotEmpty) {
                    controller.assignManager();
                  }
                },
                child: const Text('Assign'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
