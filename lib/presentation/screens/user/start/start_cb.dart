import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';
import 'package:memoiree/presentation/screens/user/flash_cards/flash_card_cb.dart';

enum StartView { loading, loaded, error }

class StartController extends GetxController {
  var startView = StartView.loading.obs;
  var flipController = FlipCardController();
  RxList<FlashCardsModel> flashcards = <FlashCardsModel>[].obs;
  Map<String?, dynamic> args = {};
  RxInt currentPage = 0.obs;

  @override
  void onInit() async {
    args = Get.arguments;
    await loadFlashCards();
    startView(StartView.loaded);

    super.onInit();
  }

  loadFlashCards() async {
    flashcards(
      (await GetConnect().get(
            '${GlobalConfigs.baseUrl}flashcard-by-${args['type']}/${args['id']}',
          )).body['flashcards']
          .map<FlashCardsModel>((e) => FlashCardsModel.fromJson(e))
          .toList(),
    );
  }
}

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartController());
  }
}
