import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_firebase/auth/constants/firebase_constants.dart';
import 'package:auth_firebase/auth/helpers/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController authInstance = Get.find();
  late Rx<User?> firebaseUser;
  late final AuthManager authManager;

  @override
  void onInit() {
    super.onInit();
    authManager = Get.find();
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
  Future<String> login(String email, String password) async {
    //Status message
    String sStatusMessage = "";

    try {
      //User authentication in Firebase
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      //Set isLogin to true
      authManager.login(user.user?.uid);
      //Set return message
      sStatusMessage = "OK";
    } on FirebaseAuthException catch (e) {
      //signOut
      signOut();
      //Set return message
      sStatusMessage = e.code;
    } catch (e) {
      //signOut
      signOut();
      //Set return message
      sStatusMessage = e.toString();
    }

    return sStatusMessage;
  }

  void register(String email, String password) async {
    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (user.user != null) {
        /// Set isLogin to true
        authManager.login(user.user?.uid);
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

  void signOut() {
    try {
      auth.signOut();
      authManager.logOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
