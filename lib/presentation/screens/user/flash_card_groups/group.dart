import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/user/flash_card_groups/groups_cb.dart';
import 'package:memoiree/presentation/widgets/shad_sidebar.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FlashCardGroups extends GetView<FlashCardGroupsController> {
  const FlashCardGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.flashCardGroupsView.value) {
          FlashCardGroupsView.loaded => _loaded(),
          FlashCardGroupsView.loading => _loading(),
          FlashCardGroupsView.error => _error(),
        },
      ),
      floatingActionButton: ShadIconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          showShadDialog(
            context: context,
            builder:
                (context) => ShadDialog(
                  child: Wrap(
                    children: [
                      SizedBox(
                        //padding: EdgeInsets.symmetric(horizontal: 20.w),
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 5.w),
                                ShadText(
                                  text: 'Group Info',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            ShadInput(
                              placeholder: ShadText(text: 'Name'),
                              controller: controller.name,
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width / 2 - 25.w,
                                  child: ShadButton(
                                    decoration: ShadDecoration(
                                      border: ShadBorder.all(
                                        width: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: ShadText(
                                      text: 'Cancel',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 2 - 25.w,
                                  child: ShadButton(
                                    onPressed: () async {
                                      await controller.upsertGroup(context);
                                    },
                                    child: ShadText(
                                      text: 'Add',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          );
        },
      ),
    );
  }

  _loaded() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5.w),
                    ShadText(
                      text: "Flash Card Decks",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                ShadSidebar(),
              ],
            ),
            //Row(children: [Container(),CustomDropdown(items: [''], onChanged: onChanged)]),
            SizedBox(height: 5.h),
            ShadInput(
              placeholder: ShadText(text: 'Search'),
              trailing: Icon(Icons.search_rounded),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: Get.height - 140.h,
              width: Get.width,
              child: ListView.builder(
                itemCount: controller.groups.length,
                itemBuilder: (c, index) {
                  var data = controller.groups[index];
                  return _item(data, c);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _item(GroupModel data, context) {
    return GestureDetector(
      onTap: () {
        showShadDialog(
          context: context,
          builder: (c) {
            return ShadDialog(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShadText(
                    text: " Start Learning?",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  ShadText(
                    text: "Would you like to go review mode?",
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ShadButton(
                            onPressed: () {
                              Navigator.pop(c);
                            },
                            child: ShadText(text: 'No'),
                            backgroundColor: Colors.white,
                            decoration: ShadDecoration(
                              border: ShadBorder.all(
                                color: Colors.black12,
                                width: 1,
                              ),
                            ),
                          ),
                          ShadButton(
                            onPressed: () async {
                              Navigator.pop(c);
                              if (await controller.getCount(data.id) == 0) {
                                return;
                              }
                              Get.toNamed(
                                '/flash-card-start',
                                arguments: {'id': data.id, 'type': 'group'},
                              );
                            },
                            child: ShadText(text: 'Yes', color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        margin: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 3,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShadText(text: 'Name: ', fontSize: 14.sp),
                    Container(
                      constraints: BoxConstraints(maxHeight: 50.h),
                      child: ShadText(
                        text: data.name,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ShadText(text: 'Flashcard Count: ', fontSize: 14.sp),
                    FutureBuilder(
                      future: controller.getCount(data.id),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return ShadText(
                            text: snapshot.data.toString(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          );
                        }
                        return ShadText(
                          text: "loading..",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                ShadIconButton(
                  width: 22.w,
                  height: 22.w,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.all(3.w),
                  icon: Icon(Icons.edit, size: 15.sp),
                  onPressed: () {
                    showShadDialog(
                      context: context,

                      builder: (context) {
                        controller.name.text = data.name;
                        return ShadDialog(
                          child: Wrap(
                            children: [
                              SizedBox(
                                //padding: EdgeInsets.symmetric(horizontal: 20.w),
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 5.w),
                                        ShadText(
                                          text: 'Category Details',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    ShadInput(
                                      placeholder: ShadText(text: 'Name'),
                                      controller: controller.name,
                                    ),
                                    SizedBox(
                                      width: Get.width,
                                      child: ShadButton(
                                        onPressed: () async {
                                          await controller.upsertGroup(
                                            context,
                                            id: data.id,
                                          );
                                        },
                                        child: ShadText(
                                          text: 'Add',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                ShadIconButton(
                  width: 20.w,
                  height: 20.w,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(2.w),
                  icon: Icon(Icons.delete, size: 15.sp),
                  onPressed: () async {
                    showShadDialog(
                      context: context,
                      builder: (c) {
                        return ShadDialog.alert(
                          title: ShadText(
                            text: "Delete?",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          description: ShadText(text: "Delete this deck?"),
                          actions: [
                            SizedBox(
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Get.width / 3,
                                    child: ShadButton(
                                      backgroundColor: Colors.white,
                                      decoration: ShadDecoration(
                                        border: ShadBorder.all(
                                          width: 1,
                                          color: Colors.black12,
                                        ),
                                      ),
                                      child: ShadText(text: 'No'),
                                      onPressed: () async {
                                        Navigator.pop(c);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width / 3,
                                    child: ShadButton(
                                      child: ShadText(
                                        text: 'Yes',
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        await controller.deleteGroup(data.id);
                                        Navigator.pop(c);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _error() {
    return Container();
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }
}
