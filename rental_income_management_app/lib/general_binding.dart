import 'package:get/get.dart';

import 'features/authentication/controllers/user_controller.dart';
import 'utility/helpers/network_manager.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(UserController());
    // Get.put(VariationController());
    // Get.put(CheckoutController());
    // Get.put(AddressController());
  }
}
