import 'package:flutter/material.dart';
import 'package:rental_income_management_app/features/properties/controllers/properties_controller.dart';
import 'package:rental_income_management_app/models/property.dart';

import '../../../common/custom_shapes/rounded_container.dart';
import '../../../utility/constants.dart/colors.dart';
import '../../../utility/constants.dart/sizes.dart';
import '../../../utility/enums.dart';
import '../../../utility/helpers/helper_functions.dart';

class TSingleProperty extends StatelessWidget {
  const TSingleProperty({
    super.key,
    required this.property,
    required this.onTap,
  });
  final PropertyModel property;
  final VoidCallback onTap;

  IconData getPropertyIcon(Property propertyType) {
    if (propertyType == Property.flat) return Icons.apartment;
    if (propertyType == Property.pg) return Icons.bed;
    if (propertyType == Property.hostel) return Icons.hotel;
    if (propertyType == Property.shop) return Icons.store;
    if (propertyType == Property.office) return Icons.business;
    if (propertyType == Property.residential) return Icons.home;
    return Icons.domain;
  }

  String getPropertyType(Property propertyType) {
    if (propertyType == Property.flat) return "Apartment";
    if (propertyType == Property.pg) return "Paying Guest House";
    if (propertyType == Property.hostel) return "Hostel";
    if (propertyType == Property.shop) return "Shop";
    if (propertyType == Property.office) return "Office";
    if (propertyType == Property.residential) return "Residential";
    return "Commercial";
  }


  @override
  Widget build(BuildContext context) {
    final controller = PropertyController.instance;
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: true,
        width: double.infinity,
        padding: const EdgeInsets.all(TSizes.sm),
        backgroundColor: TColors.primary.withOpacity(0.5),
        borderColor: TColors.darkGrey,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Stack(
          children: [
            ListTile(
              leading: Icon(
                getPropertyIcon(property.propertyType),
                color: (isDark ? TColors.light : TColors.dark),
              ),
              title: Text(
                  property.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  property.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
            ),
            // Positioned(
            //   right: 5,
            //   child: 
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       property.name,
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       style: Theme.of(context).textTheme.titleLarge,
            //     ),
            //     const SizedBox(height: TSizes.sm / 2),
            //     Text(
            //       property.description,
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       style: Theme.of(context).textTheme.titleLarge,
            //     ),
            //     const SizedBox(height: TSizes.sm / 2),
            //     Text(
            //       getPropertyType(property.propertyType),
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       style: Theme.of(context).textTheme.titleLarge,
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
