// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:online_exam_app/core/Utils/colors_manager.dart';
// import 'package:online_exam_app/core/Utils/font_manager.dart';
// import 'package:online_exam_app/core/Utils/style_manager.dart';
//
// class ExamScoreScreen extends StatelessWidget {
//   const ExamScoreScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     int correctAnswers = 18;
//     int incorrectAnswers = 2;
//     double score = correctAnswers / (correctAnswers + incorrectAnswers);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Exam Score"),
//         leading: const BackButton(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               "Your score",
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(width: 24.w,),
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SizedBox(
//                       width: 120.w,
//                       height: 120.h,
//                       child: CircularProgressIndicator(
//                         value: score, // 80% progress
//                         strokeWidth: 4,
//                         backgroundColor: ColorsManager.redColor, // Incorrect part
//                         valueColor: const AlwaysStoppedAnimation<Color>(ColorsManager.primaryColor), // Correct part
//                         strokeAlign: 2,
//                       ),
//                     ),
//                     Text(
//                       "${(score * 100).toInt()}%",
//                       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding:  EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//
//                         children: [
//                            Text(
//                               "Correct",
//                             style: getTextStyle(FontSize.s16, FontWeightManager.medium, ColorsManager.primaryColor),
//                           ),
//                            SizedBox(width: 50.w),
//                           CircleAvatar(
//                             backgroundColor: Colors.transparent,
//                             radius: 12,
//                             child: Container(
//                               width: 25.w,
//                               height: 25.h,
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: ColorsManager.primaryColor,),
//                                   borderRadius: BorderRadius.circular(15)
//
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   correctAnswers.toString(),
//                                   style: getTextStyle(FontSize.s12, FontWeightManager.medium, ColorsManager.primaryColor,fontFamily: FontFamily.inter),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8.h,),
//                       Row(
//                         children: [
//                            Text(
//                               "Incorrect",
//                              style: getTextStyle(FontSize.s16, FontWeightManager.medium, ColorsManager.redColor),
//                            ),
//                            SizedBox(width: 40.w),
//                           CircleAvatar(
//                             backgroundColor: Colors.transparent,
//                             radius: 12,
//                             child: Container(
//                               width: 25.w,
//                               height: 25.h,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: ColorsManager.redColor,),
//                                 borderRadius: BorderRadius.circular(15)
//
//                                 ),
//                               child: Center(
//                                 child: Text(
//                                   incorrectAnswers.toString(),
//                                   style: getTextStyle(FontSize.s12, FontWeightManager.medium, ColorsManager.redColor,fontFamily: FontFamily.inter),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ColorsManager.primaryColor,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text("Show results", style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 10),
//             OutlinedButton(
//               onPressed: () {},
//               style: OutlinedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child:  Text("Start again", style: TextStyle(color: ColorsManager.primaryColor)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';

class ExamScoreScreen extends StatelessWidget {
  const ExamScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 18;
    int incorrectAnswers = 3;
    int totalAnswers = correctAnswers + incorrectAnswers;
    double correctScore = correctAnswers / totalAnswers;
    double incorrectScore = incorrectAnswers / totalAnswers;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Score"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
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
                      painter: ScorePainter(correctScore, incorrectScore),
                    ),
                    Text(
                      "${(correctScore * 100).toInt()}%",
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
                              border:
                                  Border.all(color: ColorsManager.primaryColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                correctAnswers.toString(),
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
                          style: getTextStyle(FontSize.s16,
                              FontWeightManager.medium, ColorsManager.redColor),
                        ),
                        SizedBox(width: 40.w),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 12,
                          child: Container(
                            width: 25.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorsManager.redColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                incorrectAnswers.toString(),
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
                  style: getTextStyle(FontSize.s14, FontWeightManager.medium,
                      ColorsManager.whiteColor)),
            ),
            SizedBox(height: 24.h),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text("Start again",
                  style: getTextStyle(FontSize.s14, FontWeightManager.medium,
                      ColorsManager.primaryColor)),
            ),
          ],
        ),
      ),
    );
  }
}

class ScorePainter extends CustomPainter {
  final double correctScore;
  final double incorrectScore;
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
