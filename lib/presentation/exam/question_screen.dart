import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/services/shared_preference_services.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/domain/entity/cache_answer_model.dart';
import 'package:online_exam_app/presentation/exam/widget/custom_question_view.dart';

import 'manager/question_cubit/question_cubit.dart';
import 'manager/question_cubit/question_state.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionViewModel viewModel = getIt.get<QuestionViewModel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: ColorsManager.whiteColor,
        body: BlocConsumer<QuestionViewModel, QuestionState>(
          bloc: viewModel
            ..doIntent(FetchQuestionIntent(
                SharedPreferenceServices.getData(AppConstants.examId)
                    .toString())),
          listener: (context, state) {
            if (state is ErrorQuestionState) {
              DialogUtils.showMessage(
                context: context,
                message: state.errMessage.toString(),
                title: "Error",
                postActionName: "Ok",
                negativeActionName: "Cancel",
                postAction: () {
                  Navigator.pop(context);
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
                    state.question.isNotEmpty ||
                state is NextQuestionState ||
                state is PreviousQuestionState) {
              // Get the current question to display
              var currentQuestion =
                  viewModel.question[viewModel.currentQuestionIndex];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CustomQuestionView(
                      question: currentQuestion,
                      numberOfQuestions: viewModel.currentQuestionIndex,
                      questionsLength: viewModel.question.length,
                    ),
                    SizedBox(height: 20.h),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (viewModel.currentQuestionIndex >
                              0) // Only show if it's not the first question
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17.r),
                                    ),
                                    side: const BorderSide(
                                        color: ColorsManager.primaryColor,
                                        width: 1),
                                    foregroundColor:
                                        ColorsManager.primaryColor),
                                onPressed: () {
                                  viewModel.doIntent(PreviousQuestionIntent());
                                },
                                child: const Text('Back'),
                              ),
                            ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: viewModel.currentQuestionIndex <
                                    viewModel.question.length - 1
                                ? ElevatedButton(
                                    onPressed: () {
                                      // save answer
                                      viewModel.doIntent(
                                        NextQuestionIntent([
                                          AnswerModel(
                                            questionId: viewModel
                                                .question[viewModel
                                                    .currentQuestionIndex]
                                                .id
                                                .toString(),
                                            correct: viewModel
                                                .question[viewModel
                                                    .currentQuestionIndex]
                                                .selectedAnswer
                                                .toString(),
                                          ),
                                        ]),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(17.r),
                                      ),
                                      backgroundColor:
                                          ColorsManager.primaryColor,
                                      foregroundColor: ColorsManager.whiteColor,
                                    ),
                                    child: const Text("Next"),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      // save answer of last question
                                      QuestionViewModel.timer?.cancel();
                                      viewModel.doIntent(
                                        NextQuestionIntent([
                                          AnswerModel(
                                            questionId: viewModel
                                                .question[viewModel
                                                    .currentQuestionIndex]
                                                .id
                                                .toString(),
                                            correct: viewModel
                                                .question[viewModel
                                                    .currentQuestionIndex]
                                                .selectedAnswer
                                                .toString(),
                                          ),
                                        ]),
                                      );
                                      Navigator.pushNamed(
                                        context,
                                        PagesRoutes.scoreScreen,
                                        arguments: viewModel,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(17.r),
                                      ),
                                      backgroundColor:
                                          ColorsManager.primaryColor,
                                      foregroundColor: ColorsManager.whiteColor,
                                    ),
                                    child: const Text("Submit"),
                                  ),
                          ),
                        ],
                      ),
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
