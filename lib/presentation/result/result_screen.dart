import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/result/manager/result_state.dart';
import 'package:online_exam_app/presentation/result/widget/custom_question_card.dart';

import 'manager/result_cubit.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResultViewModel>()..fetchResult(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Results"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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

// class ResultScreen extends StatelessWidget {
//   const ResultScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     CheckAnswerEntity result =
//     ModalRoute.of(context)!.settings.arguments as CheckAnswerEntity;
//
//     return BlocProvider(
//       create: (context) => getIt<ResultViewModel>()..fetchResult(),
//       child: Scaffold(
//         body: BlocConsumer<ResultViewModel, ResultState>(
//           listener: (context, state) {
//             if (state is LoadingResultState) {
//               // Handle loading state if needed
//             } else if (state is ErrorResultState) {
//               DialogUtils.showMessage(
//                 context: context,
//                 message: state.message,
//                 title: "Error",
//                 negativeActionName: "Cancel",
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is LoadingResultState) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (state is SuccessResultState) {
//               final questions = state.questions;
//
//               if (questions.isEmpty) {
//                 return const Center(child: Text("No questions found."));
//               }
//
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ListView.builder(
//                   itemCount: questions.length,
//                   itemBuilder: (context, index) {
//                     final question = questions[index];
//                     final userSelected = question.selectedAnswer ?? "";
//                     final isCorrect = question.correct == userSelected;
//
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Card(
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 question.question ?? "No Question",
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Column(
//                                 children: question.answers?.map((answer) {
//                                   bool isSelected = userSelected == answer.answer;
//                                   bool isCorrectAnswer =
//                                       question.correct == answer;
//                                   return Container(
//                                     width: double.infinity,
//                                     margin: const EdgeInsets.symmetric(
//                                         vertical: 4),
//                                     padding: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       color: questions[index].correct ==
//                                           answer.answer
//                                           ? Colors.green.withOpacity(0.3)
//                                           : userSelected == answer.answer
//                                           ? Colors.lightGreenAccent
//                                           : Colors.white,
//                                       borderRadius:
//                                       BorderRadius.circular(8),
//                                       border: Border.all(
//                                         color: questions[index].correct ==
//                                             answer.answer
//                                             ? Colors.green
//                                             : (userSelected ==
//                                             answer.answer
//                                             ? Colors.red
//                                             : Colors.grey),
//                                         width: 2,
//                                       ),
//                                     ),
//                                     child: Text(
//                                       answer.answer ?? "",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: questions[index].correct ==
//                                             answer.answer
//                                             ? Colors.green
//                                             : questions[index].correct ==
//                                             answer.answer
//                                             ? Colors.red
//                                             : Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList() ??
//                                     [],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
