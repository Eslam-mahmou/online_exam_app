import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/exam/manager/question_cubit/question_cubit.dart';
import 'package:online_exam_app/presentation/exam/manager/score_cubit/score_state.dart';
import 'package:online_exam_app/presentation/exam/manager/score_cubit/score_view_model_cubit.dart';

import '../../domain/entity/QuestionsOnExamEntity.dart';

class ExamScoreScreen extends StatelessWidget {
  const ExamScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScoreScreenViewModel viewModel = getIt.get<ScoreScreenViewModel>();
    return BlocProvider(
      create: (context) => viewModel..doIntent(CheckAnswerIntent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Exam Score"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BlocConsumer<ScoreScreenViewModel, ScoreState>(
          listener: (context, state) {
            if (state is ErrorScoreState) {
              DialogUtils.showMessage(
                context: context,
                message: state.errMessage,
                title: "Error",
                negativeActionName: "Cancel",
                postActionName: "Ok",
                postAction: () {
                  Navigator.pushNamed(context, PagesRoutes.examScreen);
                },
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your score",
                    style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                        ColorsManager.blackColor),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      SizedBox(width: 16.w),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: Size(120.w, 120.h),
                            painter: ScorePainter(
                                viewModel.answerEntity?.correct?.toDouble()??1
                                ,
                                viewModel.answerEntity?.wrong?.toDouble()??1 ),
                          ),
                          Text(
                            viewModel.answerEntity?.total.toString() ?? "",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(width: 30.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Correct",
                                style: getTextStyle(
                                    FontSize.s16,
                                    FontWeightManager.medium,
                                    ColorsManager.primaryColor),
                              ),
                              SizedBox(width: 50.w), // +10
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 12,
                                child: Container(
                                  width: 25.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorsManager.primaryColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      viewModel.answerEntity?.correct?.toString()??"0",
                                      style: getTextStyle(
                                          FontSize.s12,
                                          FontWeightManager.medium,
                                          ColorsManager.primaryColor,
                                          fontFamily: FontFamily.inter),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                "Incorrect",
                                style: getTextStyle(
                                    FontSize.s16,
                                    FontWeightManager.medium,
                                    ColorsManager.redColor),
                              ),
                              SizedBox(width: 40.w),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 12,
                                child: Container(
                                  width: 25.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorsManager.redColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      viewModel.answerEntity?.wrong
                                              .toString() ??
                                          "0",
                                      style: getTextStyle(
                                          FontSize.s12,
                                          FontWeightManager.medium,
                                          ColorsManager.redColor,
                                          fontFamily: FontFamily.inter),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 80.h),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text("Show results",
                        style: getTextStyle(
                            FontSize.s14,
                            FontWeightManager.medium,
                            ColorsManager.whiteColor)),
                  ),
                  SizedBox(height: 24.h),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text("Start again",
                        style: getTextStyle(
                            FontSize.s14,
                            FontWeightManager.medium,
                            ColorsManager.primaryColor)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ScorePainter extends CustomPainter {
  double correctScore;
  double incorrectScore;
  final double gapAngle =
      pi / 18; // make it .....=> to be equel from left & right

  ScorePainter(this.correctScore, this.incorrectScore);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 5.w;
    double radius = size.width / 2;
    Paint incorrectPaint = Paint()
      ..color = ColorsManager.redColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint correctPaint = Paint()
      ..color = ColorsManager.primaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2;
    double incorrectAngle = incorrectScore * (2 * pi - gapAngle * 2);
    double correctAngle = correctScore * (2 * pi - gapAngle * 2);

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(radius, radius), radius: radius - strokeWidth / 2),
      startAngle,
      incorrectAngle,
      false,
      incorrectPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(radius, radius), radius: radius - strokeWidth / 2),
      startAngle + incorrectAngle + gapAngle,
      correctAngle,
      false,
      correctPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
