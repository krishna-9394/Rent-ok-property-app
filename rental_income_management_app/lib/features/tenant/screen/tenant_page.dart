// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// class TenantScreen extends StatelessWidget {
//   const TenantScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(BrandControllerAdmin());
//     return Scaffold(
//       appBar: TAppBar(
//         showBackArrow: true,
//         title:
//             Text('Add Brand', style: Theme.of(context).textTheme.headlineSmall),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Heading
//               SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     Obx(
//                       () {
//                         final networkImage = controller.imageUrl.value;
//                         final image = networkImage.isNotEmpty
//                             ? networkImage
//                             : TImages.defaultCategoryIcon;

//                         return controller.imageUploading.value
//                             ? const TShimmerEffect(
//                                 width: 80,
//                                 height: 80,
//                                 radius: 80,
//                               )
//                             : TCircularImage(
//                                 image: image,
//                                 height: 80,
//                                 width: 80,
//                                 isNetworkImage: networkImage.isNotEmpty,
//                               );
//                       },
//                     ),
//                     TextButton(
//                       onPressed: () => controller.uploadBrandImage(),
//                       child: const Text('Set the Brand Logo'),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: TSizes.spaceBtwSections,
//               ),
//               // TextField and Button
//               Form(
//                 key: controller.formKey,
//                 child: Column(
//                   children: [
//                     // Brand name
//                     TextFormField(
//                       controller: controller.brandName,
//                       validator: (value) =>
//                           TValidator.validateEmptyString('Brand Name', value),
//                       expands: false,
//                       decoration: const InputDecoration(
//                         labelText: TTexts.brandName,
//                         prefixIcon: Icon(Iconsax.user),
//                       ),
//                     ),
//                     const SizedBox(height: TSizes.spaceBtwInputFields),

//                     InputDecorator(
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.all(12.0),
//                       ),
//                       child: Obx(() {
//                         return Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Select Category',
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.w600),
//                               ),
//                               const SizedBox(height: 10),
//                               Wrap(
//                                 spacing: 8.0,
//                                 runSpacing: 4.0,
//                                 children: controller.categoryList.map((entry) {
//                                   return ChoiceChip(
//                                     label: Text(entry.value),
//                                     selected: controller.selectedCategory
//                                         .contains(entry.key),
//                                     onSelected: (bool selected) {
//                                       if (selected) {
//                                         controller.selectedCategory
//                                             .add(entry.key);
//                                       } else {
//                                         controller.selectedCategory
//                                             .remove(entry.key);
//                                       }
//                                     },
//                                     selectedColor: Colors.blue,
//                                     labelStyle: TextStyle(
//                                       color: controller.selectedCategory
//                                               .contains(entry.key)
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                     backgroundColor: Colors.grey[300],
//                                   );
//                                 }).toList(),
//                               ),
//                             ],
//                           ),
//                         );
//                       }),
//                     ),
//                     const SizedBox(height: TSizes.spaceBtwInputFields),
//                     // checkbox for isFeatured
//                     InputDecorator(
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.all(12.0),
//                       ),
//                       child: Row(
//                         children: [
//                           Obx(
//                             () => Checkbox(
//                               value: controller.isFeatured.value,
//                               onChanged: (value) =>
//                                   controller.updateIsFeatured(),
//                             ),
//                           ),
//                           const Text(TTexts.isFeatured),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: TSizes.spaceBtwSections),
//               // Save Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => controller.addBrand(),
//                   child: const Text('Submit'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
