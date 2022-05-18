import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_firebase/Constants/firebase_constants.dart';
import 'package:auth_firebase/core/authentication_manager.dart';
//import 'package:auth_firebase/home_view.dart';
//import 'package:auth_firebase/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController authInstance = Get.find();
  late Rx<User?> firebaseUser;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _authManager = Get.find();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    //ever(firebaseUser, _setInitialScreen);
  }

/*
  _setInitialScreen(User? user) {
    if (user != null) {
      // user is logged in
      Get.offAll(() => const HomeView());
    } else {
      // user is null as in user is not available or not logged in
      Get.offAll(() => const LoginView());
    }
  }
*/
  void register(String email, String password) async {
    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (user.user != null) {
        /// Set isLogin to true
        _authManager.login(user.user?.uid);
      } else {
        /// Show user a dialog about the error response
        Get.defaultDialog(
            middleText: 'Register Error',
            textConfirm: 'OK',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            });
      }
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      //print(e.message);
      // Get.snackbar("Error", e.message!);
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // this is temporary. you can handle different kinds of activities
      //such as dialogue to indicate what's wrong
      print(e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user.user != null) {
        /// Set isLogin to true
        _authManager.login(user.user?.uid);
      } else {
        /// Show user a dialog about the error response
        Get.defaultDialog(
            middleText: 'User not found!',
            textConfirm: 'OK',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            });
      }
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      //print(e.message);
      // Get.snackbar("Error", e.message!);
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void signOut() {
    try {
      _authManager.logOut();
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
