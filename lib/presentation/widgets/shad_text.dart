import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShadText extends Text {
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final double? height;
  final List<Shadow>? shadows;
  final String? text;
  final int? maxFontSize;
  final int? minFontSize;
  final TextOverflow? overflow;

  const ShadText({
    super.key,
    this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
    this.fontFamily,
    this.fontStyle,
    this.height,
    this.shadows,
    this.maxFontSize,
    this.minFontSize,
    this.overflow,
  }) : super('');

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      key: key,
      overflow: overflow ?? TextOverflow.visible,
      style: GoogleFonts.poppins(
        fontSize: fontSize ?? 13.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? Colors.black,
      ),
    );
  }
}
