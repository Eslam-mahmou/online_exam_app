import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';

import '../../../../core/Utils/colors_manager.dart';
import '../../../../core/Utils/font_manager.dart';
import '../../../../core/Utils/style_manager.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/custom_text_from_field.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password"),
      ),
      body: Column(
        children: [
          Text(
            "Email verification",
            style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                ColorsManager.blackColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Please enter your code that send to your\n email address",
            textAlign: TextAlign.center,
            style: getTextStyle(
              FontSize.s14,
              FontWeightManager.regular,
              ColorsManager.greyColor,
              height: 1.4.h,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: TextFormField(
                    // validator: validator,
                    // obscureText: obscureText,
                    style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                        ColorsManager.blackColor,
                        fontFamily: FontFamily.roboto),
                    decoration: InputDecoration(
                      label: Text(''),
                      labelStyle: getTextStyle(FontSize.s12,
                          FontWeightManager.regular, ColorsManager.greyColor,
                          fontFamily: FontFamily.roboto),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: ColorsManager.greyColor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: ColorsManager.redColor, width: 1)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: TextFormField(
                    // validator: validator,
                    // obscureText: obscureText,
                    style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                        ColorsManager.blackColor,
                        fontFamily: FontFamily.roboto),
                    decoration: InputDecoration(
                      label: Text(''),
                      labelStyle: getTextStyle(FontSize.s12,
                          FontWeightManager.regular, ColorsManager.greyColor,
                          fontFamily: FontFamily.roboto),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: ColorsManager.greyColor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: ColorsManager.redColor, width: 1)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: TextFormField(
                    // validator: validator,
                    // obscureText: obscureText,
                    style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                        ColorsManager.blackColor,
                        fontFamily: FontFamily.roboto),
                    decoration: InputDecoration(
                      label: Text(''),
                      labelStyle: getTextStyle(FontSize.s12,
                          FontWeightManager.regular, ColorsManager.greyColor,
                          fontFamily: FontFamily.roboto),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: ColorsManager.greyColor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: ColorsManager.redColor, width: 1)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: TextFormField(
                    // validator: validator,
                    // obscureText: obscureText,
                    style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                        ColorsManager.blackColor,
                        fontFamily: FontFamily.roboto),
                    decoration: InputDecoration(
                      label: Text(''),
                      labelStyle: getTextStyle(FontSize.s12,
                          FontWeightManager.regular, ColorsManager.greyColor,
                          fontFamily: FontFamily.roboto),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: ColorsManager.greyColor, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: ColorsManager.redColor, width: 1)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomElevatedButton(
            label: 'Continue',
            onTap: () {
              Navigator.pushNamed(context, PagesRoutes.resetPassLogin);
            },
            backgroundColor: ColorsManager.primaryColor,
          ),
        ],
      ),
    );
  }
}
