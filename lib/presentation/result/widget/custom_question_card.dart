import 'package:flutter/material.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

class CustomQuestionCard extends StatelessWidget {
  final Questions question;

  const CustomQuestionCard({Key? key, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Text
              Text(
                question.question ?? "No question text",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Displaying all answers
              Column(
                children: question.answers?.map((answer) {
                      final answerKey = answer.key?.trim() ?? '';
                      final answerText = answer.answer?.trim() ?? '';
                      final selectedAnswer = question.selectedAnswer?.trim();
                      final correctAnswer = question.correct?.trim() ?? '';

                      final isSelected = selectedAnswer == answerKey;
                      final isCorrectAnswer = correctAnswer == answerKey;
                      final isWrongSelected = isSelected && !isCorrectAnswer;
                      final isUnanswered = selectedAnswer == null ||
                          selectedAnswer.isEmpty ||
                          selectedAnswer.trim().isEmpty ||
                          selectedAnswer == "null";

                      print('== Debug ==');
                      print('Question: ${question.question}');
                      print('Key: $answerKey');
                      print('Answer Text: $answerText');
                      print('Selected Answer: $selectedAnswer');
                      print(
                          'Selected Answer (Raw): "${question.selectedAnswer}"');
                      print('Correct Answer: $correctAnswer');
                      print('isSelected: $isSelected');
                      print('isCorrectAnswer: $isCorrectAnswer');
                      print('isWrongSelected: $isWrongSelected');
                      print('isUnanswered: $isUnanswered');
                      print('===========');

                      return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: (selectedAnswer == null ||
                          selectedAnswer.isEmpty || selectedAnswer == "null")
                          ? ColorsManager.greyColor.withOpacity(0.2)
                          : (isCorrectAnswer
                          ? ColorsManager.greenColor.withOpacity(0.3)
                          : isWrongSelected
                          ? ColorsManager.redColor.withOpacity(0.3)
                          : Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isCorrectAnswer
                            ? Colors.green
                            : isWrongSelected
                            ? Colors.red
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      answerText,
                      style: TextStyle(
                        color: isCorrectAnswer
                            ? Colors.green[900]
                            : isWrongSelected
                            ? Colors.red[900]
                            : isUnanswered
                            ? Colors.grey[600]
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList() ?? [],
              ),
            ],
          ),
        ));
  }
}
