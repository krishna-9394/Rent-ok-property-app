import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rental_income_management_app/features/properties/screens/properties.dart';

import 'features/authentication/controllers/user_controller.dart';
import 'features/home/home.dart';
import 'utility/constants.dart/colors.dart';
import 'utility/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final userRole = UserController.instance.user.value.role;
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: isDarkMode ? TColors.dark : TColors.white,
          indicatorColor: isDarkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.dark.withOpacity(0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            // NavigationDestination(icon: Icon(Iconsax.shop), label: 'Shop'),
            NavigationDestination(
                icon: Icon(Iconsax.document_upload), label: 'upload'),
            // NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            // NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() {
        return controller.screens[controller.selectedIndex.value];
        // if(userRole == Role.admin) {
        //   return
        // } else {
        //   final index = controller.selectedIndex.value;
        //   if(index==0 || index==1) {
        //     return controller.screens[index];
        //   } else {
        //     return controller.screens[index+1];
        //   }
        // }
      }),
    );
  }
}

class NavigationController extends GetxController {
  Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    // const TenantScreen(),
    const PropertyScreen(),
    // const StoreScreen(),
    // const UploadScreen(),
    // const WishlistScreen(),
    // const SettingScreen(),
  ];
}
