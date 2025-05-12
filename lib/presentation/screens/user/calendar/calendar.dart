import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/user/calendar/calendar_cb.dart';
import 'package:memoiree/presentation/widgets/shad_loading.dart';
import 'package:memoiree/presentation/widgets/shad_sidebar.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Calendar extends GetView<CalendarController> {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.calendarView.value) {
          CalendarView.loaded => _loaded(),
          CalendarView.loading => _loading(),
          CalendarView.error => _error(),
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: 2,
        showElevation: true,
        onItemSelected: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/flashcards');
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

      floatingActionButton: ShadIconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          showShadSheet(
            side: ShadSheetSide.bottom,
            context: context,

            builder:
                (c) => ShadSheet(
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
                                  text: 'Reminder Details',
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
                            ShadInput(
                              placeholder: ShadText(text: 'Description'),
                              controller: controller.description,
                            ),
                            SizedBox(
                              width: Get.width,
                              child: ShadDatePicker(
                                selected: controller.focusedDay.value,
                                onChanged: (date) {
                                  if (date == null) return;
                                  var currentDate = controller.datetime.value;
                                  controller.datetime.value = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    currentDate.hour,
                                    currentDate.minute,
                                    currentDate.second,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: Get.width,
                              child: ShadTimePicker(
                                onChanged: (time) {
                                  var currentDate = controller.datetime.value;
                                  controller.datetime.value = DateTime(
                                    currentDate.year,
                                    currentDate.month,
                                    currentDate.day,
                                    time.hour,
                                    time.minute,
                                    time.second,
                                  );
                                  print(controller.datetime.value);
                                },
                              ),
                            ),
                            SizedBox(
                              width: Get.width,
                              child: ShadButton(
                                onPressed: () async {
                                  ShadLoading.show(
                                    controller.upsertEvent(c),
                                    context,
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
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5.w),
                    ShadText(
                      text: "Calendar",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                ShadSidebar(),
              ],
            ),

            Obx(
              () => Container(
                alignment: Alignment.center,
                width: Get.width,
                child: ShadCalendar(
                  selected: controller.focusedDay.value,
                  fromMonth: DateTime(DateTime.now().year - 1),
                  toMonth: DateTime(DateTime.now().year, 12),
                  gridMainAxisSpacing: 5.w,

                  onChanged: (date) {
                    if (date == null) return;
                    controller.focusedDay(date);
                    controller.changeEvents(date);
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: Get.height / 2.8,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.events.length,

                itemBuilder: (c, index) {
                  return _item(controller.events[index], c);
                },
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

  _item(EventsModel data, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      margin: EdgeInsets.only(bottom: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShadText(text: data.title),
              ShadText(text: data.description),
              ShadText(
                text: DateFormat('EEEE d MMMM • h:mm a').format(data.datetime),
                fontSize: 12.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
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
                onPressed: () {},
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
                        description: ShadText(text: "Delete this categories?"),
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
                                      ShadLoading.show(
                                        controller.deleteEvent(data.id),
                                        context,
                                      );
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
    );
  }
}
