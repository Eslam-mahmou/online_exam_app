import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';

TextStyle getTextStyle(double fontSize, FontWeight fontWeight, Color color,
    {String fontFamily = FontFamily.inter}) {
  return TextStyle(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily);
}
