import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ShadLoading {
  Widget build() {
    return Center(
      child: LoadingAnimationWidget.stretchedDots(
        color: Colors.white,
        size: 40.sp,
      ),
    );
  }
}
