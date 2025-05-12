import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';

enum FlashCardCategoriesView { loading, loaded, error }

class FlashCardCategoriesController extends GetxController {
  var flashCardsCategoriesView = FlashCardCategoriesView.loading.obs;
  var name = TextEditingController();
  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;
  @override
  void onInit() async {
    await loadCategories();
    flashCardsCategoriesView(FlashCardCategoriesView.loaded);

    super.onInit();
  }

  loadCategories() async {
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}category-by-creator/${GlobalConfigs.settings.user!.id}",
    );

    categories.value =
        (res.body['category'] as List)
            .map((e) => CategoriesModel.fromJson(e))
            .toList();
  }

  upsertCategory(context, {id}) async {
    await GetConnect().post(
      "${GlobalConfigs.baseUrl}category/${id ?? ""}",
      {'name': name.text, 'created_by': GlobalConfigs.settings.user!.id},
      headers: {"Content-Type": "application/json"},
    );

    await loadCategories();
    Navigator.pop(context);
  }

  deleteCategory(id) async {
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}delete-category/$id",

      headers: {"Content-Type": "application/json"},
    );

    print(res.body);
    await loadCategories();
  }
}

class FlashCardCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlashCardCategoriesController());
  }
}

class CategoriesModel {
  int id;
  String name;

  CategoriesModel({required this.name, required this.id});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(name: json['name'], id: json['id']);
  }

  toJson() {
    return {'name': name};
  }
}
