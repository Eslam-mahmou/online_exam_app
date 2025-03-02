import 'package:flutter/material.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/domain/entity/exam_response_entity.dart';

import '../../../core/Utils/assets_manager.dart';

class CustomExamCard extends StatelessWidget {
  CustomExamCard({super.key, required this.exam});

  ExamsEntity exam;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      shadowColor: ColorsManager.greyColor,
      clipBehavior: Clip.none,
      color: ColorsManager.whiteColor,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: ListTile(
            leading:
                Image.asset(width: 60.w, height: 71.h, ImageAssets.examImage),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "High level",
                      style: getTextStyle(FontSize.s16,
                          FontWeightManager.medium, ColorsManager.blackColor),
                    ),
                    Text(
                      exam.duration.toString(),
                      style: getTextStyle(
                          FontSize.s14,
                          FontWeightManager.regular,
                          ColorsManager.primaryColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  exam.numberOfQuestions.toString(),
                  style: getTextStyle(FontSize.s14, FontWeightManager.regular,
                      ColorsManager.greyColor),
                ),
              ],
            ),
            subtitle: Text(
              "From: 1.00 \t To: 6.00",
              style: getTextStyle(FontSize.s14, FontWeightManager.regular,
                  ColorsManager.blackColor),
            ),
          )),
    );
  }
}
