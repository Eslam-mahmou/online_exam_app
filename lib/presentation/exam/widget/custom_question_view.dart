import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

class CustomQuestionView extends StatelessWidget {
  CustomQuestionView({super.key, required this.question});

  final Questions question;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question.toString(),
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...question.answers!.map((answer) => Text(
                  answer.toString(),
                  style: const TextStyle(color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
