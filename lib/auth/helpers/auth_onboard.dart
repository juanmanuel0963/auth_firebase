import 'package:auth_firebase/auth/helpers/auth_manager.dart';
import 'package:auth_firebase/home/screens/home_screen.dart';
import 'package:auth_firebase/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthOnBoard extends StatelessWidget {
  const AuthOnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthManager _authManager = Get.find();

    return Obx(() {
      return _authManager.isLogged.value
          ? const HomeScreen()
          : const AuthScreen();
    });
  }
}
