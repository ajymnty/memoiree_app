import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/user/start/start_cb.dart';
import 'package:memoiree/presentation/widgets/shad_alerts.dart';
import 'package:memoiree/presentation/widgets/shad_sidebar.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Start extends GetView<StartController> {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.startView.value) {
          StartView.loaded => _loaded(),
          StartView.loading => _loading(),
          StartView.error => _error(),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Wrap(
        children: [
          SizedBox(
            height: 50.h,
            width: Get.width,
            child: Obx(
              () => Row(
                spacing: 5.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShadText(
                    text: (controller.currentPage.value + 1).toString(),
                    fontSize: 20.sp,
                  ),
                  ShadText(text: "/", fontSize: 10.sp),
                  ShadText(
                    text: controller.flashcards.length.toString(),
                    fontSize: 20.sp,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            width: Get.width,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 2.35,
                  child: ShadButton(
                    onPressed: () {
                      controller.flipController.flipcard();
                    },
                    backgroundColor: Colors.teal,
                    child: ShadText(text: "Flip", color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: Get.width / 2.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShadButton(
                        onPressed: () {
                          if (controller.currentPage.value == 0) {
                            showShadDialog(
                              context: context,
                              builder:
                                  (c) => Scaffold(
                                    backgroundColor: Colors.transparent,

                                    body: ShadCustomAlert(
                                      title: "Error!",
                                      icon: Icons.close,
                                      subtitle:
                                          "You are on the first flashcard of your deck!",
                                      buttonText: 'Okay',
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.pop(c);
                                      },
                                    ),
                                  ),
                            );
                          } else {
                            controller.currentPage--;
                          }
                        },
                        backgroundColor: Colors.white,
                        decoration: ShadDecoration(
                          color: Colors.white,
                          border: ShadBorder.all(
                            width: 1,
                            color: Colors.black12,
                          ),
                        ),
                        child: ShadText(text: 'Previous'),
                      ),
                      ShadButton(
                        onPressed: () {
                          if (!controller.flipController.state!.isFront) {
                            controller.flipController.flipcard();
                          }
                          if (controller.currentPage.value <
                              controller.flashcards.length - 1) {
                            controller.currentPage++;
                          } else {
                            showShadDialog(
                              context: context,
                              builder:
                                  (c) => Scaffold(
                                    backgroundColor: Colors.transparent,

                                    body: ShadCustomAlert(
                                      title: "Error!",
                                      icon: Icons.close,
                                      subtitle:
                                          "You reach the last flashcard of your deck!",
                                      buttonText: 'Okay',
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.pop(c);
                                      },
                                    ),
                                  ),
                            );
                          }
                        },
                        child: ShadText(text: 'Next', color: Colors.white),
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
                      text:
                          "Learning Mode - ${controller.args['type'] == "group" ? "Deck" : "Category"}",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                ShadSidebar(),
              ],
            ),
            SizedBox(height: 10.h),
            Obx(
              () => FlipCard(
                frontWidget: _card(
                  "Question",
                  controller
                      .flashcards[controller.currentPage.value]
                      .background,
                  controller.flashcards[controller.currentPage.value].question,
                  controller.flashcards[controller.currentPage.value].size,
                ),
                backWidget: _card(
                  "Answer",
                  controller
                      .flashcards[controller.currentPage.value]
                      .background,
                  controller.flashcards[controller.currentPage.value].answer,
                  controller.flashcards[controller.currentPage.value].size,
                ),
                controller: controller.flipController,
                rotateSide: RotateSide.bottom,
                onTapFlipping: false,
                axis: FlipAxis.vertical,
              ),
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

  _card(title, background, data, size) {
    return Container(
      width: Get.width - 40.w,
      height:
          size.toString().toLowerCase() == "small"
              ? 100.h
              : size.toString().toLowerCase() == "medium"
              ? 250.h
              : size.toString().toLowerCase() == "large"
              ? 400.h
              : null,
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
      decoration: BoxDecoration(
        color: background.toString() == "0" ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.grey.withOpacity(0.5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: ShadText(
              text: title,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: background.toString() != "0" ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            constraints: BoxConstraints(maxHeight: Get.height - 280.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ShadText(
                overflow: TextOverflow.fade,
                text: data,
                color:
                    background.toString() != "0" ? Colors.white : Colors.black,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
