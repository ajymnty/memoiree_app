import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ShadLoading {
  static show(Future fun, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) {
        fun.then((v) {
          Navigator.pop(c);
        });
        return Center(
          child: LoadingAnimationWidget.stretchedDots(
            color: Colors.white,
            size: 40.sp,
          ),
        );
      },
    );
  }
}
