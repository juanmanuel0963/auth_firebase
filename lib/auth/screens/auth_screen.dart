import 'package:auth_firebase/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<AuthScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  //LoginViewModel _viewModel = Get.put(LoginViewModel());

  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _formType == FormType.login
            ? const Text('Login')
            : const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: _formType == FormType.login ? loginForm() : registerForm(),
      ),
    );
  }

  Form loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: emailCtr..text = "george.bluth@reqres.in",
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Email'
                : null;
          },
          decoration: inputDecoration('E-mail', Icons.person),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Password'
                : null;
          },
          controller: passwordCtr..text = "123456",
          decoration: inputDecoration('Password', Icons.lock),
        ),
        ElevatedButton.icon(
          icon: _isLoading
              ? const CircularProgressIndicator()
              : const Icon(
                  Icons.access_alarm,
                  size: 0,
                ),
          label: Text(
            _isLoading ? 'Loading...' : 'Login',
          ),
          onPressed: _isLoading ? null : authLoginLoading,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _formType = FormType.register;
            });
          },
          child: const Text('Does not have an account?'),
        )
      ]),
    );
  }

  Form registerForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: emailCtr..text = "george.bluth@reqres.in",
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Email'
                : null;
          },
          decoration: inputDecoration('E-mail', Icons.person),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Password'
                : null;
          },
          controller: passwordCtr..text = "123456",
          decoration: inputDecoration('Password', Icons.lock),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          initialValue: "123456",
          validator: (value) {
            return (value == null || value.isEmpty || value != passwordCtr.text)
                ? 'Passwords does not match'
                : null;
          },
          decoration: inputDecoration('Retype Password', Icons.lock),
        ),
        ElevatedButton.icon(
          icon: _isLoading
              ? const CircularProgressIndicator()
              : const Icon(
                  Icons.access_alarm,
                  size: 0,
                ),
          label: Text(
            _isLoading ? 'Loading...' : 'Register',
          ),
          onPressed: _isLoading ? null : authRegisterLoading,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _formType = FormType.login;
            });
          },
          child: const Text('Login'),
        )
      ]),
    );
  }

  // The indicator will show up when _isLoading = true.
  // The button will be unpressable, too.
  bool _isLoading = false;

  // This function will be triggered when the button is pressed
  void authLoginLoading() async {
    setState(() {
      _isLoading = true;
    });

    if (formKey.currentState?.validate() ?? false) {
      String sStatusMessage = await AuthController.authInstance.login(
        emailCtr.text.trim(),
        passwordCtr.text.trim(),
      );

      if (sStatusMessage != "OK") {
        Get.defaultDialog(
            middleText: sStatusMessage,
            textConfirm: 'OK',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void authRegisterLoading() async {
    setState(() {
      _isLoading = true;
    });

    if (formKey.currentState?.validate() ?? false) {
      String sStatusMessage = await AuthController.authInstance.register(
        emailCtr.text.trim(),
        passwordCtr.text.trim(),
      );

      if (sStatusMessage != "OK") {
        Get.defaultDialog(
            middleText: sStatusMessage,
            textConfirm: 'OK',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}

InputDecoration inputDecoration(String labelText, IconData iconData,
    {String? prefix, String? helperText}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.grey),
    fillColor: Colors.grey.shade200,
    filled: true,
    prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black)),
  );
}

enum FormType { login, register }
