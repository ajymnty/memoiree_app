import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/all/auth/auth_cb.dart';
import 'package:memoiree/presentation/screens/all/auth/signin.dart';
import 'package:memoiree/presentation/screens/all/auth/signup.dart';

class Auth extends GetView<AuthController> {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.authView.value) {
          AuthView.loaded => _loaded(),
          AuthView.loading => _loading(),
          AuthView.error => _error(),
        },
      ),
    );
  }

  _loaded() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Obx(() {
            return controller.selectedView.value == "signin"
                ? Signin(controller: controller)
                : Signup(controller: controller);
          }),
        ),
      ),
    );
  }

  _error() {
    return Container();
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }
}
