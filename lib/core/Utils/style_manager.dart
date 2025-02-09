import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';

TextStyle getTextStyle(double fontSize, FontWeight fontWeight, Color color,
    {String fontFamily = FontFamily.inter,
    TextDecoration? decoration,
    Color decorationColor = ColorsManager.blackColor}) {
  return TextStyle(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      fontFamily: fontFamily);
}
