import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';

import '../../../../core/Utils/colors_manager.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/custom_text_from_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password"),
      ),
      body: Column(
        children: [
          Text(
            "Forget Password",
            style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                ColorsManager.blackColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Please enter your email associated to\n your account",
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
          CustomTextFromField(
            labelText: "Email",
            hinText: "Enter your email",
            validator: AppValidate.validateUserName,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomElevatedButton(
            label: 'Continue',
            onTap: () {
              Navigator.pushNamed(context, PagesRoutes.emailVerification);
            },
            backgroundColor: ColorsManager.primaryColor,
          ),
        ],
      ),
    );
  }
}
