import 'package:get/get.dart';

enum QuizModeView { loading, loaded, error }

class QuizModeController extends GetxController {
  var quizModeView = QuizModeView.loading.obs;
  @override
  void onInit() async {
    quizModeView(QuizModeView.loaded);

    super.onInit();
  }
}

class QuizModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizModeController());
  }
}
