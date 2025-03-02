import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

class CustomQuestionView extends StatefulWidget {
  const CustomQuestionView({super.key, required this.question});

  final Questions question;

  @override
  State<CustomQuestionView> createState() => _CustomQuestionViewState();
}

class _CustomQuestionViewState extends State<CustomQuestionView> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorsManager.blackColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "Exam",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            widget.question.question.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: widget.question.answers!.map((answer) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: ColorsManager.lightGrayColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: RadioListTile<String>(
                  title: Text(
                    answer.answer ?? 'No answer provided',
                    style: const TextStyle(color: Colors.black),
                  ),
                  value: answer.key ?? '',
                  groupValue: selectedAnswer,
                  activeColor: ColorsManager.primaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      selectedAnswer = value;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
