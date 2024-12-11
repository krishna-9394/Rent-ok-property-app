import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:rental_income_management_app/utility/constants.dart/colors.dart';
import 'data/repositories/authentication_repository.dart';
import 'firebase_options.dart';
import 'general_binding.dart';
import 'homepage.dart';
import 'utility/app_routes/app_routes.dart';
import 'utility/theme/theme.dart';

void main() async {
  // Widget Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Getx-Local Storage
  await GetStorage.init();

  // Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  runApp(
    ChangeNotifierProvider(
      create: (context) => SelectedIndexProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBinding(),
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      getPages: AppRoutes.pages,
      // show Loader or Circular Progress meanwhile Authentication repository will decide show screen
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
