import 'package:border_progress_indicator/border_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/user/quiz_mode/quiz_mode_cb.dart';
import 'package:memoiree/presentation/widgets/shad_sidebar.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizMode extends GetView<QuizModeController> {
  const QuizMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.quizModeView.value) {
          QuizModeView.loaded => _loaded(),
          QuizModeView.loading => _loading(),
          QuizModeView.error => _error(),
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
                      text: "Quiz Mode",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                ShadSidebar(),
              ],
            ),
            SizedBox(height: 10.h),
            BorderProgressIndicator(
              value: 0.9,
              strokeWidth: 5.sp,
              borderRadius: 10.r,
              color: Colors.teal,
              child: Container(
                width: Get.width - 40.w,

                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                  vertical: 15.sp,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ShadText(
                        text: 'Question',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: Get.height - 280.h,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ShadText(
                          overflow: TextOverflow.fade,
                          text:
                              'Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisquet amet consectetur adipisct amet consectetur adipiscing t amt amet consectetur adipiscing t amet consectetur adipiscing t amet consectetur adipiscing t amet consectetur adipiscing et consectetur adipiscing t amet consectetur adipiscing ing t amet consectetur adipiscing t amet consectetur adipiscing t amet consectetur adipiscing t amet consectetur adipiscing t consectetur adipiscing elit. Quisqu faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.',
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ShadText(
                        text: 'Your Answer',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ShadTextarea(placeholder: ShadText(text: 'Answer..')),
                  ],
                ),
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
