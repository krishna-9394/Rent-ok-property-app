import 'package:get/get.dart';
import 'package:rental_income_management_app/features/authentication/screens/signup/signup_page.dart';

import '../../features/authentication/screens/login/login_page.dart';
import 'routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
  ];
// Add more GetPage entries as needed
}
