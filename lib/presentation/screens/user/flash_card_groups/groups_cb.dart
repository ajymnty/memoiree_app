import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';

enum FlashCardGroupsView { loading, loaded, error }

class FlashCardGroupsController extends GetxController {
  var flashCardGroupsView = FlashCardGroupsView.loading.obs;
  var name = TextEditingController();
  var searchController = TextEditingController();
  RxList<GroupModel> shownGroups = <GroupModel>[].obs;

  RxList<GroupModel> groups = <GroupModel>[].obs;
  @override
  void onInit() async {
    await loadGroups();
    flashCardGroupsView(FlashCardGroupsView.loaded);
    super.onInit();
  }

  loadGroups() async {
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}group-by-creator/${GlobalConfigs.settings.user!.id}",
    );

    groups.value =
        res.body['groups']
            .map<GroupModel>((e) => GroupModel.fromJson(e))
            .toList();

    shownGroups.value = List.generate(groups.length, (i) => groups[i]);
  }

  upsertGroup(context, {id}) async {
    await GetConnect().post("${GlobalConfigs.baseUrl}group/${id ?? ""}", {
      'name': name.text,
      'created_by': GlobalConfigs.settings.user!.id,
    });

    await loadGroups();

    Navigator.pop(context);
  }

  deleteGroup(id) async {
    await GetConnect().get(
      "${GlobalConfigs.baseUrl}delete-group/$id",

      headers: {"Content-Type": "application/json"},
    );

    await loadGroups();
  }

  getCount(id) async {
    int length = 0;
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}flashcard-by-group/$id",
    );
    try {
      length = res.body['flashcards'].length;
    } catch (e) {
      length = 0;
    }
    return length;
  }

  searchGroup() {
    shownGroups.clear();
    if (searchController.text == "") {
      shownGroups.assignAll(groups);
      return;
    }
    shownGroups.value =
        groups
            .where((e) => e.name.contains(searchController.text.toLowerCase()))
            .toList();
  }
}

class FlashCardGroupsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlashCardGroupsController());
  }
}

class GroupModel {
  int id;
  String name;
  GroupModel({required this.name, required this.id});

  factory GroupModel.fromJson(json) {
    return GroupModel(name: json['name'] ?? 'No name', id: json['id']);
  }
}
