import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/widget/custom_elevated_button.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/presentation/layout/widget/custom_picker_image.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 45.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Profile",
              style: getTextStyle(FontSize.s20, FontWeightManager.medium,
                  ColorsManager.blackColor),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          const CustomPickerImage(),
          SizedBox(
            height: 24.h,
          ),
          CustomTextFromField(
            labelText: "User name",
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFromField(
                labelText: "First name",
              )),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                  child: CustomTextFromField(
                labelText: "Last name",
              )),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          CustomTextFromField(
            labelText: "Email",
          ),
          SizedBox(
            height: 24.h,
          ),
          CustomTextFromField(
            labelText: "Password",
            suffix: Text(
              "Change",
              style: getTextStyle(FontSize.s12, FontWeightManager.semiBold,
                  ColorsManager.primaryColor),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          CustomTextFromField(
            labelText: "Phone number",
          ),
          SizedBox(
            height: 48.h,
          ),
          CustomElevatedButton(
            label: "Update",
            onTap: () {},
          )
        ],
      ),
    );
  }
}
