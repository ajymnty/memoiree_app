import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/user/flash_cards/flash_card_cb.dart';
import 'package:memoiree/presentation/widgets/shad_dropdown.dart';
import 'package:memoiree/presentation/widgets/shad_sidebar.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FlashCards extends GetView<FlashCardsController> {
  const FlashCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.flashCardsView.value) {
          FlashCardsView.loaded => _loaded(),
          FlashCardsView.loading => _loading(),
          FlashCardsView.error => _error(),
        },
      ),
      floatingActionButton: ShadIconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          _showSheet(context);
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: 0,
        showElevation: true,
        onItemSelected: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/flash-cards');
            case 1:
              Get.toNamed('/flash-card-groups');
            case 2:
              Get.toNamed('/calendar');
            default:
              Get.toNamed('/about');
          }
        },
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.add_circle),
            title: Text('Flashcards'),
          ),
          FlashyTabBarItem(
            icon: Icon(CupertinoIcons.square_stack_3d_up),
            title: Text('Decks'),
          ),
          FlashyTabBarItem(
            icon: Icon(CupertinoIcons.calendar),
            title: Text('Calendar'),
          ),
          FlashyTabBarItem(
            icon: Icon(CupertinoIcons.info),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  _loaded() {
    return SafeArea(
      child: SingleChildScrollView(
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
                        text: "Flash Cards",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  ShadSidebar(),
                ],
              ),
              SizedBox(height: 5.h),
              ShadInput(
                placeholder: ShadText(text: 'Search'),
                controller: controller.searchController,
                onChanged: (v) {
                  controller.searchFlashCards();
                },
                trailing: Icon(Icons.search_rounded),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => SizedBox(
                  height: Get.height - 200.h,
                  width: Get.width,
                  child: ListView.builder(
                    itemCount: controller.shownFlashCards.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      FlashCardsModel data = controller.shownFlashCards[index];
                      return _item(data);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _item(FlashCardsModel data) {
    var c = FlipCardController();
    var popOverController = ShadPopoverController();
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.5.h),
      margin: EdgeInsets.only(bottom: 7.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(blurRadius: 3, color: Colors.grey.withOpacity(0.4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              color: Colors.green,
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShadText(
                  text: data.name,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  //fontWeight: FontWeight.w500,
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
                                      category: data.category,
                                      group: data.group,
                                      size: data.size,
                                      name: data.name,
                                      question: data.question,
                                      answer: data.answer,
                                      id: data.id,
                                    );
                                  },
                                  child: ShadText(
                                    text: 'Edit',
                                    color: Colors.white,
                                  ),
                                ),
                                ShadButton(
                                  onPressed: () async {
                                    await controller.deleteFlashcard(data.id);
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
          SizedBox(height: 7.5.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(0, 0),
              //     color: Colors.grey.withOpacity(0.5),
              //     blurRadius: 5,
              //   ),
              // ],
            ),
            child: FlipCard(
              frontWidget: Container(
                width: Get.width,
                constraints: BoxConstraints(maxHeight: 70.h),
                child: Row(
                  children: [
                    ShadText(
                      text: "Question: ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(height: 5.h),
                    ShadText(
                      text: data.question,
                      fontSize: 14.sp,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              backWidget: Container(
                width: Get.width,
                constraints: BoxConstraints(maxHeight: 70.h),
                child: Row(
                  children: [
                    ShadText(
                      text: "Answer: ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(height: 5.h),
                    ShadText(
                      text: data.answer,
                      fontSize: 14.sp,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              controller: c,
              rotateSide: RotateSide.bottom,
              onTapFlipping: true,
              axis: FlipAxis.vertical,
            ),
          ),
        ],
      ),
    );
  }

  _showSheet(
    context, {
    category,
    group,
    size,
    name,
    question,
    answer,
    id,
    background,
  }) {
    controller.name.text = name ?? "";
    controller.question.text = question ?? "";
    controller.answer.text = answer ?? "";

    var g =
        group != null && controller.groups.isNotEmpty
            ? controller.groups[int.parse(group.toString())]['name']
            : null;
    var s = size?.toString().capitalizeFirst;
    var t =
        background == 0
            ? "Light"
            : background == 1
            ? "Dark"
            : null;

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
                            text: 'Flash Card Details',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ],
                      ),
                      //SizedBox(height: 5),
                      // ShadDropdown(
                      //   items:
                      //       ['None'] +
                      //       controller.categories
                      //           .map<String>((e) => e['name'])
                      //           .toList(),
                      //   value: c,
                      //   onChanged: (v) {
                      //     if (v.toString().toLowerCase() == "none") {
                      //       controller.category.value = 0;
                      //       return;
                      //     }
                      //     controller.category.value =
                      //         controller.categories.firstWhere(
                      //           (e) => e['name'] == v,
                      //         )['id'];
                      //   },
                      //   hintText: "Category",
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width / 2 - 25.w,
                            child: ShadDropdown(
                              value: t ?? "Dark",
                              items: ['Dark', 'Light'],
                              onChanged: (v) {
                                if (v == "Dark") {
                                  controller.background.value = 0;
                                } else {
                                  controller.background.value == 1;
                                }
                              },
                              hintText: "Theme",
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 2 - 25.w,
                            child: ShadDropdown(
                              value: s ?? "Small",
                              items: ['Small', 'Medium', 'Large', 'Auto'],
                              onChanged: (v) {
                                controller.size.value =
                                    v.toString().toLowerCase();
                              },
                              hintText: "Flashcard Size",
                            ),
                          ),
                        ],
                      ),
                      ShadDropdown(
                        value: g,
                        items:
                            ['None'] +
                            controller.groups
                                .map<String>((e) => e['name'])
                                .toList(),
                        onChanged: (v) {
                          if (v.toString().toLowerCase() == "none") {
                            controller.group.value = 0;
                            return;
                          }
                          controller.group.value =
                              controller.groups.firstWhere(
                                (e) => e['name'] == v,
                              )['id'];
                        },
                        hintText: "Flashcard Deck",
                      ),

                      ShadInput(
                        placeholder: ShadText(text: 'Name'),
                        controller: controller.name,
                      ),
                      ShadTextarea(
                        placeholder: ShadText(text: 'Question'),
                        controller: controller.question,
                      ),
                      ShadTextarea(
                        placeholder: ShadText(text: 'Answer'),
                        controller: controller.answer,
                      ),

                      SizedBox(
                        width: Get.width,
                        child: ShadButton(
                          onPressed: () async {
                            await controller.upsertFlashcard(context, id: id);
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

  _error() {
    return Container();
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }
}
