import 'package:get/get.dart';

enum AlarmsView { loading, loaded, error }

class AlarmsController extends GetxController {
  var alarmsView = AlarmsView.loading.obs;
  @override
  void onInit() async {
    alarmsView(AlarmsView.loaded);

    super.onInit();
  }
}

class AlarmsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlarmsController());
  }
}
