import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/result/manager/result_state.dart';
import 'package:online_exam_app/presentation/result/widget/custom_question_card.dart';

import '../../core/widget/custom_diaolg.dart';
import 'manager/result_cubit.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = getIt.get<ResultViewModel>();
    return BlocProvider(
      create: (context) => getIt.get<ResultViewModel>()..fetchResult(),
      child: Scaffold(
        body: BlocConsumer<ResultViewModel, ResultState>(
          listener: (context, state) {
            if(state is ErrorResultState){
              DialogUtils.showMessage(
                context: context,
                message: state.message,
                title: "Error",
                negativeActionName: "Cancel",
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      Text(
                        "Answers",
                        style: getTextStyle(
                            FontSize.s20, FontWeightManager.medium,
                            ColorsManager.blackColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.questionsList.length,
                      itemBuilder: (context, index) {
                      return CustomQuestionCard(question: viewModel.questionsList[index]);
                    },),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
