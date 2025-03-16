import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/layout/widget/custom_question_card.dart';

import '../../manager/result_cubit/result_cubit.dart';
import '../../manager/result_cubit/result_state.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResultViewModel>()..fetchResult(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Results"),
          backgroundColor: ColorsManager.whiteColor,
          shadowColor: ColorsManager.whiteColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<ResultViewModel, ResultState>(
          listener: (context, state) {
            if (state is ErrorResultState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingResultState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SuccessResultState) {
              final questions = state.questions;

              if (questions.isEmpty) {
                return const Center(child: Text("No questions available"));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return CustomQuestionCard(question: questions[index]);
                  },
                ),
              );
            }

            return const Center(child: Text("No results found."));
          },
        ),
      ),
    );
  }
}
