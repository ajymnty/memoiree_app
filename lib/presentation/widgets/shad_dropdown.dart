import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShadDropdown extends StatelessWidget {
  final List items;
  final Function(dynamic) onChanged;
  final String hintText;
  final String? value;
  const ShadDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: CustomDropdown(
        items: items,
        onChanged: onChanged,
        listItemPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 7.5.h,
        ),
        itemsListPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 7.5.h,
        ),
        closedHeaderPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 7.5.h,
        ),
        initialItem: value,
        hintText: hintText,
        decoration: CustomDropdownDecoration(
          closedBorder: Border.all(color: Colors.black12),
          closedBorderRadius: BorderRadius.circular(5.r),

          hintStyle: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          headerStyle: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          listItemStyle: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
