import 'package:flutter/material.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomQuestionCard extends StatelessWidget {
  final Questions question;


 const CustomQuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.pink[50], // Light pink background
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question ??"",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: question.answers!.map((answer) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey,
                      ),
                      title: Text(answer.answer??""),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
