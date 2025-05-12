import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/user/about/about_cb.dart';
import 'package:memoiree/presentation/widgets/shad_sidebar.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';

class About extends GetView<AboutController> {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.aboutView.value) {
          AboutView.loaded => _loaded(),
          AboutView.loading => _loading(),
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: 3,
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
                      text: "About",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                ShadSidebar(),
              ],
            ),
            SizedBox(height: 20.h),

            ShadText(
              text:
                  'Memoiree is a productivity app that combines flashcards, a personal diary, and a calendar in one simple, intuitive platform.',
              fontSize: 14.sp,
            ),
            SizedBox(height: 15.h),
            ShadText(
              text:
                  'Designed to help users improve memory, track daily thoughts, and organize their schedule, Memoiree offers a unique blend of study and self-management tools.',

              fontSize: 14.sp,
            ),
            SizedBox(height: 15.h),
            ShadText(
              text:
                  'This app was developed by five second-year students from System Plus College Foundation as a project aimed at supporting both academic success and personal growth',
              fontSize: 14.sp,
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  _loading() {
    return Text('loading');
  }
}
