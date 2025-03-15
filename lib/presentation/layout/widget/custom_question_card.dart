import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';

class CustomQuestionCard extends StatelessWidget {
  final Questions question;

  const CustomQuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: ColorsManager.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

                      return Container(
                    width: double.infinity,
                    margin:  EdgeInsets.symmetric(vertical:6.h),
                    padding:  EdgeInsets.symmetric(
                        vertical: 12.h, horizontal: 16.w),
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
