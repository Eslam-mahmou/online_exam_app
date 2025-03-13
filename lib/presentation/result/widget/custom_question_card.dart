import 'package:flutter/material.dart';
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
                      bool isSelected =
                          question.selectedAnswer == answer.answer;
                      bool isCorrectAnswer = question.correct == answer.answer;

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isCorrectAnswer
                              ? Colors.green.withOpacity(
                                  0.3) // Correct answer background color
                              : isSelected
                                  ? Colors.red.withOpacity(
                                      0.3) // Highlight wrong answer in red
                                  : Colors.transparent,
                          // Default color for unselected answers
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isCorrectAnswer
                                ? Colors
                                    .green // Green border for correct answer
                                : isSelected
                                    ? Colors
                                        .red // Red border for selected but incorrect answer
                                    : Colors.grey, // Default grey border
                            width: 2,
                          ),
                        ),
                        child: Text(
                          answer.answer ?? "No Answer",
                          style: TextStyle(
                            color: isCorrectAnswer
                                ? Colors
                                    .green[900] // Green text for correct answer
                                : isSelected
                                    ? Colors.red[
                                        900] // Red text for incorrect answer
                                    : Colors.black, // Default text color
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ],
          ),
        ));
  }
}

// class CustomQuestionCard extends StatelessWidget {
//   final Questions question;
//
//   final String? selectedAnswer;
//   final String? correctAnswer;
//
//   const CustomQuestionCard({
//     super.key,
//     required this.question,
//     required this.selectedAnswer,
//     required this.correctAnswer,
//   });
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(10),
//       color: Colors.pink[50],
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               question.question ?? "",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Column(
//               children: question.answers!.map((answer) {
//                 final isCorrect = answer.key == correctAnswer;
//                 final isSelected = answer.key == selectedAnswer;
//
//                 Color tileColor;
//                 Icon? leadingIcon;
//
//                 if (isCorrect && isSelected) {
//                   // Correct answer selected
//                   tileColor = Colors.green.shade100;
//                   leadingIcon = const Icon(Icons.check_circle, color: Colors.green);
//                 } else if (isSelected && !isCorrect) {
//                   // Incorrect answer selected
//                   tileColor = Colors.red.shade100;
//                   leadingIcon = const Icon(Icons.cancel, color: Colors.red);
//                 } else if (isCorrect) {
//                   // Correct answer not selected
//                   tileColor = Colors.green.shade100;
//                   leadingIcon = const Icon(Icons.check_circle_outline, color: Colors.green);
//                 } else {
//                   // Not selected and not correct
//                   tileColor = Colors.white;
//                   leadingIcon = const Icon(Icons.circle_outlined, color: Colors.grey);
//                 }
//
//                 return Container(
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                     color: tileColor,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey),
//                   ),
//                   child: ListTile(
//                     leading: leadingIcon,
//                     title: Text(answer.answer ?? ""),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
