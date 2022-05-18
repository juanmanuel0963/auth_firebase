import 'package:auth_firebase/Constants/firebase_constants.dart';
import 'package:auth_firebase/Controllers/auth_controller.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:auth_firebase/splash_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  firebaseInitialization.then((value) {
    // we are going to inject the auth controller over here!
    Get.put(AuthController());
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Authentication Manager',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SplashView(),
    );
  }
}
