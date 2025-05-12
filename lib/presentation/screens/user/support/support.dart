import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:memoiree/presentation/screens/user/support/support_cb.dart';
import 'package:memoiree/presentation/widgets/shad_dropdown.dart';
import 'package:memoiree/presentation/widgets/shad_sidebar.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Support extends GetView<SupportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => switch (controller.supportView.value) {
          SupportView.loaded => _loaded(),
          SupportView.loading => _loading(),
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
                      text: "Feedback Hub",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                ShadSidebar(),
              ],
            ),
            ShadInput(placeholder: ShadText(text: "Title")),
            ShadDropdown(
              items: ['Bug', 'Review', 'Suggestion'],
              onChanged: (v) {},
              hintText: "Type",
            ),
            SizedBox(
              height: 350.h,
              width: Get.width,
              child: ShadTextarea(placeholder: ShadText(text: "Description")),
            ),
          ],
        ),
      ),
    );
  }

  _loading() {
    return Text('loading');
  }
}
