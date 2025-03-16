import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/domain/entity/all_subject.dart';

class SubjectWidget extends StatelessWidget {
  final List<SubjectsEntity> subjects;

  const SubjectWidget({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return SizedBox(
          height: 90.h,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PagesRoutes.examScreen,arguments: subject);
            },
            child: Card(
              shadowColor: ColorsManager.blackColor,
              elevation: 3,
              color: ColorsManager.whiteColor,
              child: Row(
                children: [
                  SizedBox(width: 14.w),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        subject.icon.toString(),
                        width: 50,
                        height: 50,
                      )),
                  SizedBox(width: 8.w),
                  Text(subject.name.toString(),
                      style: getTextStyle(FontSize.s16,
                          FontWeightManager.regular, ColorsManager.blackColor)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
