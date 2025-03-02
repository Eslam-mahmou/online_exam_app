import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/domain/entity/exam_response_entity.dart';
import 'package:online_exam_app/presentation/exam/widget/custom_question_view.dart';

import 'manager/question_cubit/question_cubit.dart';
import 'manager/question_cubit/question_state.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0; // Track the current question index

  @override
  Widget build(BuildContext context) {
    QuestionViewModel viewModel = getIt.get<QuestionViewModel>();
    var arg = ModalRoute.of(context)!.settings.arguments as ExamsEntity;

    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: ColorsManager.whiteColor,
        body: BlocConsumer<QuestionViewModel, QuestionState>(
          bloc: viewModel..doIntent(FetchQuestionIntent(arg.id.toString())),
          listener: (context, state) {
            if (state is ErrorQuestionState) {
              DialogUtils.showMessage(
                context: context,
                message: state.errMessage.toString(),
                title: "Error",
                postActionName: "Ok",
                negativeActionName: "Cancel",
                postAction: () {
                  viewModel.doIntent(FetchQuestionIntent(arg.id.toString()));
                },
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingQuestionState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.primaryColor,
                ),
              );
            } else if (state is SuccessQuestionState &&
                state.question.isNotEmpty) {
              // Get the current question to display
              var currentQuestion = viewModel.question[currentQuestionIndex];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CustomQuestionView(question: currentQuestion),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // if (currentQuestionIndex > 0) // Only show if it's not the first question
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (currentQuestionIndex > 0) {
                                currentQuestionIndex--;
                              }
                              if (currentQuestionIndex < 0) {
                                Navigator.pushNamed(
                                    context, PagesRoutes.examScreen);
                              }
                            });
                          },
                          child: Text('Previous'),
                        ),
                        if (currentQuestionIndex <
                            viewModel.question.length - 1)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (currentQuestionIndex <
                                    viewModel.question.length - 1) {
                                  currentQuestionIndex++;
                                }
                              });
                            },
                            child: Text('Next'),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  "No exams found for this subject",
                  style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                      ColorsManager.blackColor),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// class QuestionScreen extends StatelessWidget {
//   const QuestionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     QuestionViewModel viewModel = getIt.get<QuestionViewModel>();
//     var arg = ModalRoute.of(context)!.settings.arguments as ExamsEntity;
//     return BlocProvider(
//       create: (context) => viewModel,
//       child: Scaffold(
//         backgroundColor: ColorsManager.whiteColor,
//         // appBar: AppBar(
//         //   title: Text(
//         //     arg.name.toString(),
//         //     style: getTextStyle(FontSize.s20, FontWeightManager.medium,
//         //         ColorsManager.blackColor,
//         //         fontFamily: FontFamily.inter),
//         //   ),
//         //   elevation: 0,
//         //   backgroundColor: ColorsManager.whiteColor,
//         //   leading: InkWell(
//         //     onTap: () {
//         //       Navigator.pop(context);
//         //     },
//         //     child: const Icon(
//         //       Icons.arrow_back_ios,
//         //       color: ColorsManager.blackColor,
//         //     ),
//         //   ),
//         // ),
//         body: BlocConsumer<QuestionViewModel, QuestionState>(
//           bloc: viewModel..doIntent(FetchQuestionIntent(arg.id.toString())),
//           listener: (context, state) {
//             if (state is ErrorQuestionState) {
//               DialogUtils.showMessage(
//                 context: context,
//                 message: state.errMessage.toString(),
//                 title: "Error",
//                 postActionName: "Ok",
//                 negativeActionName: "Cancel",
//                 postAction: () {
//                   viewModel.doIntent(FetchQuestionIntent(arg.id.toString()));
//                 },
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is LoadingQuestionState) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: ColorsManager.primaryColor,
//                 ),
//               );
//             } else if (state is SuccessQuestionState &&
//                 state.question.isNotEmpty) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//                 child: ListView(
//                   physics: const ClampingScrollPhysics(),
//                   children: [
//                     ...List.generate(
//                         viewModel.question.length,
//                         (index) => CustomQuestionView(
//                               questions: viewModel.question[index],
//                             )),
//                     SizedBox(height: 20.h),
//                   ],
//                 ),
//               );
//             } else if (viewModel.question.isEmpty) {
//               return Center(
//                 child: Text(
//                   "No exams found for this subject",
//                   style: getTextStyle(FontSize.s18, FontWeightManager.medium,
//                       ColorsManager.blackColor),
//                 ),
//               );
//             } else {
//               return const Text("Something went wrong");
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
