import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_income_management_app/features/properties/controllers/properties_controller.dart';
import 'package:rental_income_management_app/features/properties/controllers/room_controller.dart';

import '../../../common/appbar/appbar.dart';
import '../../../models/property.dart';
import '../../../utility/enums.dart';
import 'add_new_rooms.dart';
import 'manager_selection_sheet.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final PropertyModel property;

  const PropertyDetailsScreen({Key? key, required this.property})
      : super(key: key);

  IconData getPropertyIcon(Property propertyType) {
    if (propertyType == Property.flat) return Icons.apartment;
    if (propertyType == Property.pg) return Icons.bed;
    if (propertyType == Property.hostel) return Icons.hotel;
    if (propertyType == Property.shop) return Icons.store;
    if (propertyType == Property.office) return Icons.business;
    if (propertyType == Property.residential) return Icons.home;
    return Icons.domain;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyController());
    final roomsController = Get.put(RoomController());
    if (property.managerAssigned != null) {
      controller.fetchAssignedManager(property.managerAssigned!);
    }
    // TODO 1: Start from here and assign the room.
    if(property.rooms.length!=roomsController.rooms.length) {
    }
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          property.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to Edit Property Screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {
              // Add favorite functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Circular Icon and Name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.purple,
                    child: Icon(
                      getPropertyIcon(property.propertyType),
                      size: 75,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    property.name,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),

            const Divider(thickness: 2, height: 30),

            // Property Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Property Details',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Address'),
                    subtitle: Text(
                      '${property.flatHouseBuildingName}, ${property.areaStreetSectorVillage}, ${property.townCity}, ${property.country}, ${property.postalCode}',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Description'),
                    subtitle: Text(property.description),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Registered On'),
                    subtitle: Text(
                      property.registeredOn != null
                          ? property.registeredOn!.toLocal().toString()
                          : 'N/A',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.update),
                    title: const Text('Last Updated'),
                    subtitle: Text(
                      property.updatedOn != null
                          ? property.updatedOn!.toLocal().toString()
                          : 'N/A',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Manager'),
                    subtitle: property.managerAssigned != null ? Text(controller.assignedManager.value.fullName) : const Text('None'),
                  ),
                  const Divider(thickness: 2, height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'Rooms',
            onPressed: () => _showRoomAdditionPopup(context),
            tooltip: "Add Rooms",
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'Manager',
            onPressed: () => _showManagerSelectionPopup(context),
            tooltip: "Assign Manager",
            child: const Icon(Icons.person_add),
          ),
        ],
      ),
    );
  }

  void _showManagerSelectionPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ManagerSelectionSheet(),
    );
  }

    void _showRoomAdditionPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => RoomManagementScreen(),
    );
  }
}
