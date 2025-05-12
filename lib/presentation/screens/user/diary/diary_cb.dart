import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';

enum DiaryView { loading, loaded }

class DiaryController extends GetxController {
  var diaryView = DiaryView.loading.obs;
  var title = TextEditingController();
  var description = TextEditingController();
  var searchController = TextEditingController();

  Rx<DateTime> date = DateTime.now().obs;
  RxList diaries = [].obs;
  RxList shownDiaries = [].obs;
  @override
  void onInit() async {
    await loadDiaries();
    diaryView(DiaryView.loaded);
    super.onInit();
  }

  loadDiaries() async {
    diaries.clear();
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}diary-by-creator/${GlobalConfigs.settings.user!.id}",
    );
    diaries.assignAll(res.body['diaries']);
    shownDiaries.value = List.generate(diaries.length, (i) => diaries[i]);
  }

  searchDiaries() {
    shownDiaries.clear();
    if (searchController.text == "") {
      shownDiaries.assignAll(diaries);
      return;
    }
    shownDiaries.value =
        diaries
            .where(
              (e) =>
                  e['title'].contains(searchController.text) ||
                  e['description'].contains(searchController.text),
            )
            .toList();
  }

  upsertDiary(context, {id}) async {
    await loadDiaries();
    Navigator.pop(context);
  }

  deleteDiary(id) async {
    await GetConnect().get("${GlobalConfigs.baseUrl}delete-diary/$id");

    await loadDiaries();
  }
}

class DiaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiaryController());
  }
}
