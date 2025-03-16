import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/domain/entity/all_subject.dart';
import 'package:online_exam_app/domain/entity/exam_response_entity.dart';
import 'package:online_exam_app/presentation/exam/manager/exam_cubit.dart';
import 'package:online_exam_app/presentation/exam/manager/exam_state.dart';
import 'package:online_exam_app/presentation/exam/widget/custom_exam_card.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ExamViewModel viewModel = getIt.get<ExamViewModel>();
    var arg = ModalRoute.of(context)!.settings.arguments as SubjectsEntity;
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: ColorsManager.whiteColor,
        appBar: AppBar(
          title: Text(
            arg.name.toString(),
            style: getTextStyle(FontSize.s20, FontWeightManager.medium,
                ColorsManager.blackColor,
                fontFamily: FontFamily.inter),
          ),
          elevation: 0,
          backgroundColor: ColorsManager.whiteColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorsManager.blackColor,
            ),
          ),
        ),
        body: BlocConsumer<ExamViewModel, ExamState>(
          bloc: viewModel..doIntent(FetchExamIntent(arg.id.toString())),
          listener: (context, state) {
            if (state is ErrorExamState) {
              DialogUtils.showMessage(
                context: context,
                message: state.errMessage.toString(),
                title: "Error",
                postActionName: "Ok",
                negativeActionName: "Cancel",
                postAction: () {
                  viewModel.doIntent(FetchExamIntent(arg.id.toString()));
                },
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingExamState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.primaryColor,
                ),
              );
            } else if (state is SuccessExamState && state.exams.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    for (ExamsEntity item in viewModel.exams) ...[
                      Text(
                        item.title!.split(" ")[0].toString(),
                        style: getTextStyle(FontSize.s18,
                            FontWeightManager.medium, ColorsManager.blackColor),
                      ),
                      SizedBox(height: 10.h),
                      ...List.generate(
                          viewModel.exams.length,
                          (index) => CustomExamCard(
                                exam: viewModel.exams[index],
                              )),
                      SizedBox(height: 20.h),
                    ],
                  ],
                ),
              );
            } else if (viewModel.exams.isEmpty) {
              return Center(
                child: Text(
                  "No exams found for this subject",
                  style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                      ColorsManager.blackColor),
                ),
              );
            } else {
              return const Text("Something went wrong");
            }
          },
        ),
      ),
    );
  }
}
