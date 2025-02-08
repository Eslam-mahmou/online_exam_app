import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';

import '../../../core/Utils/colors_manager.dart';
import '../../../core/widget/custom_elevated_button.dart';
import '../../../core/widget/custom_text_from_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Column(
        children: [
          CustomTextFromField(
            labelText: "Current password",
            hinText: "Current password",
            validator: AppValidate.validatePassword,
          ),
          CustomTextFromField(
              labelText: "New password",
              hinText: "new password",
              validator: AppValidate.validatePassword),
          CustomTextFromField(
            labelText: "Confirm password",
            hinText: "confirm password",
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomElevatedButton(
            label: 'Update',
            onTap: () {},
            backgroundColor: ColorsManager.primaryColor,
          ),
        ],
      ),
    );
  }
}
