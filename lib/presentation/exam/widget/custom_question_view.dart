import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/assets_manager.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/presentation/exam/manager/question_cubit/question_cubit.dart';

class CustomQuestionView extends StatefulWidget {
  CustomQuestionView(
      {super.key, required this.question, required this.numberOfQuestions});

  Questions question;
  final num numberOfQuestions;

  // late int totalSeconds = question.exam!.duration!.toInt() * 60;//
  late int totalSeconds = 1 * 60; //

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

  // void _startTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (remainingSeconds > 0) {
  //       setState(() {
  //         remainingSeconds--;
  //       });
  //     } else {
  //       _timer?.cancel();
  //     }
  //   });
  // }
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

// to show that TIME out.
  void _showTimeOutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        // title: const Text("Time's Up!"),
        content: Row(
          children: [
            Image.asset(ImageAssets.timeOutImage),
            const Text("Time's Up!"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                remainingSeconds = widget.totalSeconds;
              });
              _startTimer(); // Restart countdown
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
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
                remainingSeconds <= remainingSeconds / 2
                    ? ColorsManager.redColor
                    : ColorsManager.greenColor),
          ),
          SizedBox(
            width: 8.w,
          )
        ],
      ),
      Text(
        "Question ${widget.numberOfQuestions + 1} of ${widget.question.exam!.numberOfQuestions}",
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
          max: widget.question.exam!.numberOfQuestions!.toDouble(),
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
              value:answer.key ??"",
              groupValue: QuestionViewModel.selectedAnswer ?? "",
              activeColor: ColorsManager.primaryColor,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                QuestionViewModel.selectedAnswer= value!;
                log("gfghjkl$value");
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
  int mins = minutes % 60;
  int seconds = (minutes * 60) % 60;

  return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
}
