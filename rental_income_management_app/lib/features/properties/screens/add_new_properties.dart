import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rental_income_management_app/features/properties/controllers/properties_controller.dart';
import 'package:rental_income_management_app/utility/enums.dart';

import '../../../common/appbar/appbar.dart';
import '../../../utility/constants.dart/sizes.dart';
import '../../../utility/validators.dart';

class AddNewPropertyScreen extends StatelessWidget {
  const AddNewPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Add New Property'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.propertyFormKey,
            child: Column(
              children: [
                /// Property Name
                TextFormField(
                  controller: controller.propertyName,
                  validator: (value) =>
                      TValidator.validateEmptyString('Name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Property Name',
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Property Description
                TextFormField(
                  controller: controller.propertyDescription,
                  validator: (value) =>
                      TValidator.validateEmptyString('Name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.info_circle),
                    labelText: 'Property Description',
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Select the type of Property
                DropdownButtonFormField<String>(
                  value: controller.selectedPropertyType.value.isEmpty
                      ? null
                      : controller.selectedPropertyType.value,
                  items: propertyMap.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.key),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    controller.selectedPropertyType.value = newValue ?? "";
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Property Type',
                    prefixIcon: Icon(Iconsax.category),
                  ),
                  validator: (value) =>
                      value == null ? 'Please select a Property Type' : null,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                /// Property Building Name
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.flatHouseBuildingName,
                        validator: (value) =>
                            TValidator.validateEmptyString('Street', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Property/Building/House Number',
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                /// Area/Street/Sector/Village
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.areaStreetSectorVillageName,
                        validator: (value) =>
                            TValidator.validateEmptyString('Street', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Area/Street/Sector/Village/Landmark',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Pincode & City/Town
                Row(
                  children: [
                    /// Pincode
                    Expanded(
                      child: TextFormField(
                        controller: controller.pincode,
                        validator: (value) => TValidator.validateEmptyString(
                            'Postal Code', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),

                    /// City
                    Expanded(
                      child: TextFormField(
                        controller: controller.townCityName,
                        validator: (value) =>
                            TValidator.validateEmptyString('City', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'Town/City',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Country
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      TValidator.validateEmptyString('Country', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewProperty(),
                    child: const Text('Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
