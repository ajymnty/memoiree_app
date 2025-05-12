import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/user/diary/diary_cb.dart';
import 'package:memoiree/presentation/widgets/shad_sidebar.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Diary extends GetView<DiaryController> {
  const Diary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.diaryView.value) {
          DiaryView.loaded => _loaded(),
          DiaryView.loading => _loading(),
        },
      ),
      floatingActionButton: ShadIconButton(
        onPressed: () {
          _showSheet(context);
        },
        icon: Icon(Icons.add),
      ),
    );
  }

  _loaded() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5.w),
                    ShadText(
                      text: "Diary",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                ShadSidebar(),
              ],
            ),
            ShadInput(
              placeholder: ShadText(text: 'Search'),
              trailing: Icon(Icons.search_rounded),
            ),
            SizedBox(height: 5.h),
            Obx(
              () => SizedBox(
                height: Get.height - 140.h,
                width: Get.width,
                child: ListView.builder(
                  itemCount: controller.diaries.value.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    // FlashCardsModel data = controller.flashcards[index];
                    return _item(controller.diaries[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loading() {
    return Text('loading');
  }

  _item(data) {
    var popOverController = ShadPopoverController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.5.h),
      margin: EdgeInsets.only(bottom: 7.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShadText(
                      text: data['title'],
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      //fontWeight: FontWeight.w500,
                    ),

                    ShadText(text: data['description']),
                    ShadText(
                      text: data['date'],
                      fontSize: 11.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                ShadPopover(
                  controller: popOverController,
                  child: ShadIconButton(
                    icon: Icon(Icons.more_vert_rounded, size: 17.sp),
                    padding: EdgeInsets.all(2.5),
                    height: 20.h,
                    width: 20.h,
                    onPressed: () {
                      popOverController.toggle();
                    },
                  ),
                  popover:
                      (c) => Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 165.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              children: [
                                ShadButton(
                                  onPressed: () {
                                    _showSheet(
                                      c,
                                      title: data['title'],
                                      description: data['description'],
                                      id: data['id'],
                                      date: data['date'],
                                    );
                                  },
                                  child: ShadText(
                                    text: 'Edit',
                                    color: Colors.white,
                                  ),
                                ),
                                ShadButton(
                                  onPressed: () async {
                                    await controller.deleteDiary(data['id']);
                                  },
                                  child: ShadText(
                                    text: 'Delete',
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showSheet(context, {title, description, id, date}) {
    controller.title.text = title ?? "";
    controller.description.text = description ?? "";

    showShadSheet(
      side: ShadSheetSide.bottom,
      context: context,
      backgroundColor: Colors.white,

      builder:
          (context) => ShadSheet(
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
                            text: 'Diary Details',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      ShadInput(
                        placeholder: ShadText(text: 'Title'),
                        controller: controller.title,
                      ),
                      SizedBox(height: 5),
                      ShadTextarea(
                        placeholder: ShadText(text: 'Description'),
                        controller: controller.description,
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: Get.width,
                        child: ShadDatePicker(
                          onChanged: (date) {
                            if (date == null) return;
                            controller.date.value = date;
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width,
                        child: ShadButton(
                          onPressed: () async {
                            controller.upsertDiary(context, id: id);
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
          ),
    );
  }
}
