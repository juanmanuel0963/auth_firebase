import 'package:auth_firebase/auth/constants/firebase_constants.dart';
import 'package:auth_firebase/auth/controllers/auth_controller.dart';
import 'package:auth_firebase/auth/screens/splash_screen.dart';
import 'package:auth_firebase/helpers/loading/loading_overlay.dart';
import 'package:auth_firebase/helpers/translations/app_translations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  firebaseInitialization.then((value) {
    // We inject the auth controller
    Get.put(AuthController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Alexandrya',
      translations: AppTranslations(),
      locale: const Locale('es'),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      //home: SplashScreen(),
      home: LoadingOverlay(
        child: SplashScreen(),
      ),
    );
  }
}
