import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum FlashCardsView { loading, loaded, error }

class FlashCardsController extends GetxController {
  var flashCardsView = FlashCardsView.loading.obs;
  var name = TextEditingController();
  var question = TextEditingController();
  var answer = TextEditingController();
  var category = 0.obs;
  var group = 0.obs;
  var size = "small".obs;
  var groups = [].obs;
  var categories = [].obs;
  RxList<FlashCardsModel> flashcards = <FlashCardsModel>[].obs;
  RxList<FlashCardsModel> shownFlashCards = <FlashCardsModel>[].obs;
  var searchController = TextEditingController();
  var background = 0.obs;
  var popOverController = ShadPopoverController();
  @override
  void onInit() async {
    await loadFlashCards();
    await loadCategories();
    await loadGroups();
    flashCardsView(FlashCardsView.loaded);
    super.onInit();
  }

  searchFlashCards() {
    shownFlashCards.clear();
    if (searchController.text == "") {
      shownFlashCards.assignAll(flashcards);
      return;
    }
    shownFlashCards.value =
        flashcards
            .where(
              (e) =>
                  e.name.contains(searchController.text) ||
                  e.question.contains(searchController.text) ||
                  e.answer.contains(searchController.text),
            )
            .toList();
  }

  loadFlashCards() async {
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}flashcard-by-user/${GlobalConfigs.settings.user!.id}",
    );

    flashcards(
      res.body['flashcards']
          .map<FlashCardsModel>((e) => FlashCardsModel.fromJson(e))
          .toList(),
    );
    shownFlashCards.value = List.generate(
      flashcards.length,
      (i) => flashcards[i],
    );
  }

  loadCategories() async {
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}category-by-creator/${GlobalConfigs.settings.user!.id}",
    );

    categories(res.body['category']);
  }

  loadGroups() async {
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}group-by-creator/${GlobalConfigs.settings.user!.id}",
    );

    groups(res.body['groups']);
  }

  upsertFlashcard(context, {id}) async {
    await GetConnect().post("${GlobalConfigs.baseUrl}flashcard/${id ?? ""}", {
      'name': name.text,
      'category': "none",
      'group': group.value,
      'question': question.text,
      'answer': answer.text,
      'size': size.value,
      'background': background.value,
      'owner': GlobalConfigs.settings.user!.id,
    });

    await loadFlashCards();

    Navigator.pop(context);
  }

  deleteFlashcard(id) async {
    await GetConnect().get(
      "${GlobalConfigs.baseUrl}delete-flashcard/$id",

      headers: {"Content-Type": "application/json"},
    );

    await loadFlashCards();
  }
}

class FlashCardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlashCardsController());
  }
}

class FlashCardsModel {
  int id;
  String name;
  int category;
  int group;
  String size;
  String question;
  String answer;
  String background;

  FlashCardsModel({
    required this.id,
    required this.name,
    required this.category,
    required this.group,
    required this.size,
    required this.question,
    required this.answer,
    required this.background,
  });

  factory FlashCardsModel.fromJson(Map<String, dynamic> json) {
    return FlashCardsModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? "",
      category: int.tryParse(json['category'].toString()) ?? 0,
      group: int.tryParse(json['group'].toString()) ?? 0,
      question: json['question'] ?? "",
      answer: json['answer'] ?? "",
      size: json['size'] ?? "Small",
      background: json['background'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'group': group,
      'question': question,
      'answer': answer,
      'background': background,
    };
  }
}
