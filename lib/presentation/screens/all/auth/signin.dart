import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:memoiree/presentation/screens/all/auth/auth_cb.dart';
import 'package:memoiree/presentation/widgets/shad_loading.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Signin extends StatelessWidget {
  final AuthController controller;

  const Signin({super.key, required this.controller});

  @override
  build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 75.h),
        Row(
          children: [
            SizedBox(width: 5.w),
            Text(
              'Memoiree',
              style: GoogleFonts.poppins(
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 5.w),
            Text(
              'Login with your account',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 50.h),
        Row(
          children: [
            SizedBox(width: 5.w),
            Text(
              'Username',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        ShadInput(
          placeholder: Text('Username'),
          keyboardType: TextInputType.text,
          controller: controller.usernameController,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SizedBox(width: 5.w),
            Text(
              'Password',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Obx(
          () => ShadInput(
            controller: controller.passwordController,
            placeholder: Text('Password'),
            obscureText: controller.isPasswordVisible.value,
            keyboardType: TextInputType.emailAddress,
            trailing: ShadIconButton(
              width: 24,
              height: 24,
              padding: EdgeInsets.zero,
              decoration: const ShadDecoration(
                secondaryBorder: ShadBorder.none,
                secondaryFocusedBorder: ShadBorder.none,
              ),
              icon: Icon(
                controller.isPasswordVisible.value
                    ? LucideIcons.eyeOff
                    : LucideIcons.eye,
              ),
              onPressed: () {
                controller.isPasswordVisible(
                  !controller.isPasswordVisible.value,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: Get.width,
          child: ShadButton(
            onPressed: () async {
              // show loading
              // showDialog(
              //   context: Get.context!,
              //   builder:
              //       (c) => LoadingAnimationWidget.stretchedDots(
              //         color: Colors.white,
              //         size: 40.sp,
              //       ),
              // );
              //Get.back();
              await controller.login(context);
            },
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 100.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account?',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5.w),
            InkWell(
              onTap: () {
                controller.selectedView('signup');
              },
              child: Text(
                'Signup.',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
