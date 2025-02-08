import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';

import '../Utils/colors_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final Color? backgroundColor;
  final double? radius;
  final void Function() onTap;
  final TextStyle? textStyle;
  final bool isStadiumBorder;

  const CustomElevatedButton(
      {super.key,
      this.prefixIcon,
      this.textStyle,
      this.isStadiumBorder = true,
      this.backgroundColor,
      this.radius,
      this.suffixIcon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: isStadiumBorder
              ? const StadiumBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.r)),
          backgroundColor: backgroundColor ?? ColorsManager.greyColor,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon ?? const SizedBox(),
            SizedBox(
              width: 24.w,
            ),
            Text(
              label,
              style: getTextStyle(FontSize.s16, FontWeightManager.medium,
                  ColorsManager.whiteColor,
              fontFamily: FontFamily.roboto),
            ),
            SizedBox(
              width: 27.w,
            ),
            suffixIcon ?? const SizedBox()
          ],
        ));
  }
}
