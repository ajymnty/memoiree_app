import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';

class CustomConnect extends GetConnect {
  CustomConnect() {
    super.baseUrl = GlobalConfigs.baseUrl;
  }
}
