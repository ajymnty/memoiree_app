import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';
import 'package:memoiree/app/models/user.dart';
import 'package:memoiree/presentation/widgets/shad_alerts.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthView { loading, loaded, error }

class AuthController extends GetxController {
  var authView = AuthView.loading.obs;
  var selectedView = "signin".obs;
  var isPasswordVisible = false.obs;
  var isPasswordVisibleC = false.obs;
  var isPasswordVisibleCC = false.obs;
  //controllers for signin form
  var usernameController = TextEditingController(text: 'niiko');
  var passwordController = TextEditingController(text: 'nikko');
  //validators for signup form
  var usernameControllerC = TextEditingController();
  var passwordControllerC = TextEditingController();
  var confirmPasswordControllerC = TextEditingController();
  var firstNameControllerC = TextEditingController();
  var lastNameControllerC = TextEditingController();

  @override
  void onInit() {
    authView(AuthView.loaded);
    super.onInit();
  }

  login(context) async {
    // showShadDialog(
    //   context: context,
    //   builder: (context) => Container(),
    //   barrierDismissible: false,
    // );

    var res = await GetConnect().post(
      "${GlobalConfigs.baseUrl}login",
      {
        "username": usernameController.text,
        "password": passwordController.text,
      },
      headers: {"Content-Type": "application/json"},
    );
    Get.back();
    var isSuccess = res.statusCode == 200;
    showShadDialog(
      context: context,
      builder:
          (c) => ShadCustomAlert(
            title: isSuccess ? 'Success' : 'Error',
            icon: Icons.error,
            subtitle: isSuccess ? 'Login successful!' : 'Invalid Credentials!',
            buttonText: 'Ok',
            color: isSuccess ? Colors.green : Colors.red,
            onPressed: () {
              Navigator.pop(c);
            },
          ),
    );
    if (isSuccess) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = User.fromJson(res.body['user']);
      prefs.setString('user', jsonEncode(user.toJson()));
      GlobalConfigs.settings.user = user;
      Get.offAllNamed('/flashcards');
    }
  }

  signup(context) async {
    var body = {
      'first_name': firstNameControllerC.text,
      'last_name': lastNameControllerC.text,
      'username': usernameControllerC.text,
      'password': passwordControllerC.text,
    };
    var res = await GetConnect().post("${GlobalConfigs.baseUrl}signup", body);

    if (res.statusCode != 200) {
      // alert error
    } else {
      Get.dialog(
        ShadDialog(
          child: ShadCustomAlert(
            icon: Icons.check,
            title: 'Success',
            subtitle: 'Signup success',
            buttonText: 'Okay',
            color: Colors.green,
            onPressed: () {
              selectedView('signin');
            },
          ),
        ),
      );
    }
  }

  void someFunction() async {
    try {
      showDialog(
        context: Get.context!,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
      await Future.delayed(Duration(seconds: 1));
      Get.back();
    } catch (e) {
      print("Error: $e");
    }
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
