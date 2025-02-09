import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/widget/custom_elevated_button.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';

import '../../../core/Utils/font_manager.dart';
import '../../../core/Utils/style_manager.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFromField(
              labelText: "User Name",
              hinText: "Enter your user name",
              validator: AppValidate.validateUserName,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomTextFromField(
                        labelText: "First Name",
                        hinText: "Enter first name",
                        validator: AppValidate.validateFullName)),
                Expanded(
                    child: CustomTextFromField(
                        labelText: "Last Name",
                        hinText: "Enter last name",
                        validator: AppValidate.validateFullName)),
              ],
            ),
            CustomTextFromField(
                labelText: "Email",
                hinText: "Enter your email",
                validator: AppValidate.validateEmail),
            Row(
              children: [
                Expanded(
                    child: CustomTextFromField(
                  labelText: "Password",
                  hinText: "Password",
                )),
                Expanded(
                    child: CustomTextFromField(
                  labelText: "Confirm password",
                  hinText: "Confirm",
                )),
              ],
            ),
            CustomTextFromField(
                labelText: "Phone number",
                hinText: "Enter phone number",
                validator: AppValidate.validateMobile),
            SizedBox(
              height: 20.h,
            ),
            CustomElevatedButton(
              label: 'Signup',
              onTap: () {},
              backgroundColor: ColorsManager.primaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                      ColorsManager.blackColor),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Login",
                      style: getTextStyle(FontSize.s16,
                          FontWeightManager.regular, ColorsManager.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorsManager.primaryColor)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
