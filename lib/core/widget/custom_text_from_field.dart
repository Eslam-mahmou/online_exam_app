import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';

class CustomTextFromField extends StatelessWidget {
  CustomTextFromField(
      {super.key,
      required this.labelText,
       this.hinText,
    this.initialValue,
    this.controller,
      this.validator,
      this.keyboardType,
      this.obscureText,
      this.suffix,});

  final String labelText;
  final String? hinText;
  final String? initialValue;
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  bool? obscureText;
  Widget? suffix;
  // String? obscuringCharacter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText??false,
        cursorColor: ColorsManager.blackColor,
        style: getTextStyle(
            FontSize.s16, FontWeightManager.regular, ColorsManager.blackColor,
            fontFamily: FontFamily.roboto),
        decoration: InputDecoration(
           labelText:labelText ,
            hintText: hinText,
            suffixIcon: suffix,
            hintStyle: getTextStyle(FontSize.s14, FontWeightManager.regular,
                ColorsManager.greyColor, fontFamily: FontFamily.roboto),
            labelStyle: getTextStyle(FontSize.s12, FontWeightManager.regular,
                ColorsManager.greyColor, fontFamily: FontFamily.roboto),
            border: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(width: 2),
            errorBorder:
                buildOutlineInputBorder(color: ColorsManager.redColor)),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(
      {double width = 1, Color color = ColorsManager.greyColor}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: color, width: width));
  }
}
