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
import 'package:online_exam_app/presentation/exam/manager/score_cubit/score_state.dart';
import 'package:online_exam_app/presentation/exam/manager/score_cubit/score_view_model_cubit.dart';

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
            return state is LoadingScoreState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.primaryColor,
                    ),
                  )
                : state is SuccessScoreState
                    ? Padding(
                        padding: EdgeInsets.all(16.0.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your score",
                              style: getTextStyle(
                                  FontSize.s18,
                                  FontWeightManager.medium,
                                  ColorsManager.blackColor),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                SizedBox(width: 5.w),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomPaint(
                                      size: Size(120.w, 120.h),
                                      painter: ScorePainter(
                                        (viewModel.answerEntity?.correct
                                                    ?.toDouble() ??
                                                0) /
                                            (viewModel.questions?.questions
                                                    ?.length ??
                                                1),
                                        (viewModel.answerEntity?.wrong
                                                    ?.toDouble() ??
                                                0) /
                                            (viewModel.questions?.questions
                                                    ?.length ??
                                                1),
                                      ),
                                    ),
                                    Text(
                                      // Check if total is a String, remove '%' if present, and then parse to double
                                      (viewModel.answerEntity?.total is String
                                              ? double.tryParse(viewModel
                                                          .answerEntity?.total
                                                          ?.replaceAll(
                                                              '%', '') ??
                                                      "0") ??
                                                  0.0
                                              : (viewModel.answerEntity?.total
                                                      as double?) ??
                                                  0.0)
                                          .toStringAsFixed(0),
                                      // Round to 0 decimal places
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 12.w),
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
                                        SizedBox(width: 30.w), // +10
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 12,
                                          child: Container(
                                            width: 25.w,
                                            height: 25.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorsManager
                                                      .primaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                viewModel.answerEntity?.correct
                                                        ?.toString() ??
                                                    "0",
                                                style: getTextStyle(
                                                    FontSize.s12,
                                                    FontWeightManager.medium,
                                                    ColorsManager.primaryColor,
                                                    fontFamily:
                                                        FontFamily.inter),
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
                                        SizedBox(width: 20.w),
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 12,
                                          child: Container(
                                            width: 25.w,
                                            height: 25.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      ColorsManager.redColor),
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                                    fontFamily:
                                                        FontFamily.inter),
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
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PagesRoutes.resultScreen,
                                    arguments: viewModel.answerEntity);
                              },
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
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PagesRoutes.questionScreen);
                              },
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
                      )
                    : const Center(
                        child: Text("No data available yet"),
                      );
          },
        ),
      ),
    );
  }
}

class ScorePainter extends CustomPainter {
  final double correctScore;
  final double incorrectScore;
  final double gapAngle = pi / 18;

  ScorePainter(this.correctScore, this.incorrectScore);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 4.w;
    double radius = size.width / 2;

    Paint basePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

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
    double totalAngle = 2 * pi - (gapAngle * 2); // Reduce total angle by gaps

    double incorrectAngle =
        (incorrectScore / (correctScore + incorrectScore)) * totalAngle;
    double correctAngle =
        (correctScore / (correctScore + incorrectScore)) * totalAngle;

    // Edge cases: full blue or full red
    if (incorrectScore == 0) {
      correctAngle = totalAngle;
      incorrectAngle = 0;
    }
    if (correctScore == 0) {
      incorrectAngle = totalAngle;
      correctAngle = 0;
    }

    // Draw base circle for better contrast
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(radius, radius), radius: radius - strokeWidth / 2),
      0,
      2 * pi,
      false,
      basePaint,
    );

    // Draw incorrect (red) part
    if (incorrectAngle > 0) {
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(radius, radius), radius: radius - strokeWidth / 2),
        startAngle + gapAngle, // Start with a gap
        incorrectAngle,
        false,
        incorrectPaint,
      );
    }

    // Draw correct (blue) part with symmetrical gap
    if (correctAngle > 0) {
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(radius, radius), radius: radius - strokeWidth / 2),
        startAngle + incorrectAngle + (gapAngle * 2), // Ensure equal gap
        correctAngle,
        false,
        correctPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
