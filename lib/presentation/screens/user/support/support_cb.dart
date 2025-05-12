import 'package:get/get.dart';

enum SupportView { loading, loaded }

class SupportController extends GetxController {
  var supportView = SupportView.loading.obs;

  @override
  void onInit() {
    supportView(SupportView.loaded);
    super.onInit();
  }
}

class SupporBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportController());
  }
}
