import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';

import '../../../core/widget/custom_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        title: Text(
          "Login",
          textAlign: TextAlign.start,
          style: getTextStyle(
              FontSize.s20, FontWeightManager.medium, ColorsManager.blackColor),
        ),
        backgroundColor: ColorsManager.whiteColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 12.h,
          ),
          CustomTextFromField(labelText: "Email", hinText: "Enter your email"),
          SizedBox(
            height: 24.h,
          ),
          CustomTextFromField(
              labelText: "Password", hinText: "Enter your password"),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              Text(
                "Remember me",
                style: getTextStyle(FontSize.s12, FontWeightManager.regular,
                    ColorsManager.blackColor),
              ),
              Expanded(
                child: SizedBox(
                  width: 16.w,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Text(
                    "Forget password?",
                    style: getTextStyle(FontSize.s12, FontWeightManager.regular,
                        ColorsManager.blackColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 48.h,
          ),
          CustomElevatedButton(
            label: "Login",
            onTap: () {
              Navigator.pushNamed(context, PagesRoutes.layoutScreen);
            },
            backgroundColor: ColorsManager.primaryColor,
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                    ColorsManager.blackColor),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PagesRoutes.signUpScreen);
                },
                child: Text("Sign up",
                    style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                        ColorsManager.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.primaryColor)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
