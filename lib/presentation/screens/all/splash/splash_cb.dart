import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';
import 'package:memoiree/app/models/user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SplashView { loading, loaded, error }

class SplashController extends GetxController {
  var splashView = SplashView.loading.obs;
  @override
  void onInit() async {
    var status = true;

    status = await Permission.scheduleExactAlarm.request().isGranted;
    status = await Permission.notification.request().isGranted;

    if (!status) exit(0);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = User.fromJson(jsonDecode(prefs.getString('user') ?? "{}"));

    splashView(SplashView.loaded);

    if (user.id == null) {
      Get.offAllNamed('/auth');
    } else {
      GlobalConfigs.settings.user = user;
      Get.offAllNamed('/flashcards');
    }
    super.onInit();
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
