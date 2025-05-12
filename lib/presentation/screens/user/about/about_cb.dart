import 'package:get/get.dart';

enum AboutView { loading, loaded }

class AboutController extends GetxController {
  var aboutView = AboutView.loading.obs;

  @override
  void onInit() {
    aboutView(AboutView.loaded);
    super.onInit();
  }
}

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutController());
  }
}
