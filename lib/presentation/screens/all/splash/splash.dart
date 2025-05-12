import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/all/splash/splash_cb.dart';

class Splash extends GetView<SplashController> {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.splashView.value) {
          SplashView.loaded => _loaded(),
          SplashView.loading => _loading(),
          SplashView.error => _error(),
        },
      ),
    );
  }

  _loaded() {
    return Text('App has Loaded');
  }

  _error() {
    return Container();
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }
}
