import 'package:flutter/material.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';

class CustomTextFromField extends StatelessWidget {
  CustomTextFromField(
      {super.key,
      required this.labelText,
       this.hinText,
      this.controller,
      this.validator,
      this.keyboardType,
      this.obscureText = false,
      this.suffix});

  final String labelText;
  final String? hinText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  bool obscureText;
  Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: getTextStyle(
          FontSize.s16, FontWeightManager.regular, ColorsManager.blackColor,
          fontFamily: FontFamily.roboto),
      decoration: InputDecoration(
          label: Text(labelText),
          hintText: hinText,
          suffix:suffix ,
          hintStyle: getTextStyle(
              FontSize.s14, FontWeightManager.regular, ColorsManager.greyColor,
              fontFamily: FontFamily.roboto),
          labelStyle: getTextStyle(
              FontSize.s12, FontWeightManager.regular, ColorsManager.greyColor,
              fontFamily: FontFamily.roboto),
          border: buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(width: 2),
          errorBorder: buildOutlineInputBorder(color: ColorsManager.redColor)),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(
      {double width = 1, Color color = ColorsManager.greyColor}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: color, width: width));
  }
}
