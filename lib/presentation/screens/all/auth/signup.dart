import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoiree/presentation/screens/all/auth/auth_cb.dart';
import 'package:memoiree/presentation/widgets/shad_loading.dart';
import 'package:memoiree/presentation/widgets/shad_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Signup extends StatelessWidget {
  final AuthController controller;
  const Signup({super.key, required this.controller});

  @override
  build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Row(
          children: [
            SizedBox(width: 5.w),
            Text(
              'Signup.',
              style: GoogleFonts.poppins(
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 40.h),
        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width / 2 - 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ShadText(
                        text: 'First Name',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    ShadInput(
                      controller: controller.firstNameControllerC,
                      placeholder: Text('First Name'),
                      keyboardType: TextInputType.name,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width / 2 - 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ShadText(
                        text: 'Last Name',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    ShadInput(
                      controller: controller.lastNameControllerC,
                      placeholder: Text('Last Name'),
                      keyboardType: TextInputType.name,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
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
          controller: controller.usernameControllerC,
        ),
        SizedBox(height: 10.h),
        _passwordBox(
          label: 'Password',
          textController: controller.passwordControllerC,
          obscure: controller.isPasswordVisibleC,
        ),
        _passwordBox(
          label: 'Confirm Password',
          textController: controller.confirmPasswordControllerC,
          obscure: controller.isPasswordVisibleCC,
        ),

        SizedBox(height: 10.h),
        SizedBox(
          width: Get.width,
          child: ShadButton(
            onPressed: () async {
              ShadLoading.show(controller.signup(context), context);
            },
            child: Text(
              'Signup',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 75.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5.w),
            InkWell(
              onTap: () {
                controller.selectedView('signin');
              },
              child: Text(
                'Login.',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _passwordBox({String label = "", textController, RxBool? obscure}) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 5.w),
            ShadText(text: label, fontWeight: FontWeight.w500),
          ],
        ),

        Obx(
          () => ShadInput(
            controller: textController,
            placeholder: ShadText(
              text: label,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
              color: Colors.grey,
            ),
            obscureText: obscure!.value,
            keyboardType: TextInputType.text,
            trailing: ShadIconButton(
              width: 24,
              height: 24,
              padding: EdgeInsets.zero,
              decoration: const ShadDecoration(
                secondaryBorder: ShadBorder.none,
                secondaryFocusedBorder: ShadBorder.none,
              ),
              icon: Icon(obscure.value ? LucideIcons.eyeOff : LucideIcons.eye),
              onPressed: () {
                obscure(!obscure.value);
              },
            ),
          ),
        ),
        SizedBox(height: 5.h),
      ],
    );
  }
}
