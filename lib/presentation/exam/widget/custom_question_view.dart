import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/services/shared_preference_services.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/presentation/exam/manager/question_cubit/question_cubit.dart';

import '../../../core/Utils/assets_manager.dart';

class CustomQuestionView extends StatefulWidget {
  CustomQuestionView(
      {super.key,
      required this.question,
      required this.numberOfQuestions,
      required this.questionsLength});

  Questions question;
  int questionsLength;
  final num numberOfQuestions;

  late int totalSeconds = question.exam!.duration!.toInt() * 60;//


  @override
  State<CustomQuestionView> createState() => _CustomQuestionViewState();
}

class _CustomQuestionViewState extends State<CustomQuestionView> {
  Timer? _timer;
  late int remainingSeconds;
  @override
  void initState() {
    remainingSeconds = widget.totalSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        _showTimeOutDialog();
      }
    });
  }
  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
// to show that TIME out.
  void _showTimeOutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              width: 290.w,
              height: 230.h,
              padding: EdgeInsets.symmetric(vertical: 30.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(
                        ImageAssets.timeOutImage,
                        height: 80,
                      ),
                      SizedBox(width: 10.w),
                      Text("Time out !!",
                          style: getTextStyle(FontSize.s24,
                              FontWeightManager.regular, ColorsManager.redColor,
                              fontFamily: FontFamily.roboto)),
                    ]),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        _timer?.cancel();
                        Navigator.pushNamed(context, PagesRoutes.scoreScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "View score",
                        style: getTextStyle(FontSize.s14,
                            FontWeightManager.medium, ColorsManager.whiteColor,
                            fontFamily: FontFamily.roboto),
                      ),
                    ),
                  ]),
            ));
      },
    );
  }


  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    QuestionViewModel.timer=_timer;
    return SafeArea(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        height: 24.h,
      ),
      Row(
        children: [
          InkWell(
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorsManager.blackColor,
            ),
            onTap: () {
              SharedPreferenceServices.deleteData(AppConstants.examId);
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
          Expanded(
            child: SizedBox(
              width: 8.w,
            ),
          ),
          Image.asset(
            ImageAssets.watchImage,
            scale: .9,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            formatMinutesToTime(remainingSeconds),
            style: getTextStyle(
                FontSize.s20,
                FontWeightManager.medium,
                remainingSeconds <= (widget.totalSeconds ~/ 2)
                    ? ColorsManager.redColor
                    : ColorsManager.greenColor),
          ),
          SizedBox(
            width: 8.w,
          )
        ],
      ),
      Text(
        "Question ${widget.numberOfQuestions + 1} of ${widget.questionsLength}",
        textAlign: TextAlign.center,
        style: getTextStyle(
            FontSize.s14, FontWeightManager.medium, ColorsManager.blackColor),
      ),
      SizedBox(
        height: 4.h,
      ),
      SliderTheme(
        data: const SliderThemeData(
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
          // Hides the thumb
          overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
        ),
        child: Slider(
          autofocus: false,
          value: widget.numberOfQuestions.toDouble(),
          max: widget.questionsLength.toDouble(),
          activeColor: ColorsManager.primaryColor,
          inactiveColor: Colors.grey[300],
          onChanged: (value) {},
        ),
      ),
      SizedBox(
        height: 28.h,
      ),
      Text(
        widget.question.question.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 16.h),
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
              value: answer.key ?? "",
              groupValue: widget.question.selectedAnswer ?? "",
              activeColor: ColorsManager.primaryColor,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                widget.question.selectedAnswer = value;
              },
            ),
          );
        }).toList(),
      )
    ]));
  }
}

String formatMinutesToTime(int minutes) {
  int hours = minutes ~/ 60;
  int mains = minutes % 60;

  return '${hours.toString().padLeft(2, '0')}:${mains.toString().padLeft(2, '0')}';
}
