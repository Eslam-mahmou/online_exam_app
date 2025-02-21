import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/colors_manager.dart';
import '../../../core/Utils/font_manager.dart';
import '../../../core/Utils/style_manager.dart';

class CustomVerifyTextField extends StatelessWidget {
   CustomVerifyTextField({super.key,this.controller,this.focusNode,this.onChanged});
  TextEditingController? controller;
   FocusNode? focusNode;
   void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsManager.blueLightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: onChanged,
            style: getTextStyle(
                FontSize.s16,
                FontWeightManager.regular,
                ColorsManager.blackColor,
                fontFamily: FontFamily.roboto),
            decoration: InputDecoration(
              counterText: "",
              label: const Text(''),
              labelStyle: getTextStyle(
                  FontSize.s12,
                  FontWeightManager.regular,
                  ColorsManager.greyColor,
                  fontFamily: FontFamily.roboto),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: ColorsManager.greyColor,
                      width: 1)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: ColorsManager.redColor, width: 1)),
            ),
          ),
        ),
      ),
    );
  }
}
