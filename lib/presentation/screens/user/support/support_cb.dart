import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';

enum SupportView { loading, loaded }

class SupportController extends GetxController {
  var supportView = SupportView.loading.obs;
  var title = TextEditingController();
  var description = TextEditingController();
  RxString type = "".obs;

  @override
  void onInit() {
    supportView(SupportView.loaded);
    super.onInit();
  }

  upsertSupport(context, {id}) async {
    print({
      "title": title.text,
      "description": description.text,
      "category": type.value,
      "created_by": GlobalConfigs.settings.user!.id,
      "status": "pending",
    });
    var res = await GetConnect().post("${GlobalConfigs.baseUrl}support", {
      "title": title.text,
      "description": description.text,
      "category": type.value,
      "created_by": GlobalConfigs.settings.user!.id,
      "status": "pending",
    });
    print(res.body);
  }
}

class SupporBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportController());
  }
}
