import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rental_income_management_app/features/properties/controllers/properties_controller.dart';
import 'package:rental_income_management_app/features/properties/screens/add_new_properties.dart';
import 'package:rental_income_management_app/features/properties/screens/single_property.dart';

import '../../../common/appbar/appbar.dart';
import '../../../utility/constants.dart/colors.dart';
import '../../../utility/constants.dart/sizes.dart';
import '../../../utility/helpers/cloud_helper_function.dart';
import 'properties_detail.dart';

class PropertyScreen extends StatelessWidget {
  const PropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(
          () => const AddNewPropertyScreen(),
        ),
        child: const Icon(Iconsax.add, color: Colors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Properties',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserProperties(),
              builder: (context, snapshot) {
                // Helper Function: handles Loaders, No Records, or Error Message
                final response = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);

                if (response != null) return response;
                // Records found
                final properties = snapshot.data!;

                return ListView.builder(
                  itemCount: properties.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TSingleProperty(
                      onTap: () {
                        controller.selectedProperty.value = properties[index];
                        Get.to(
                          PropertyDetailsScreen(property: properties[index]),
                        );
                      },
                      property: properties[index],
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
