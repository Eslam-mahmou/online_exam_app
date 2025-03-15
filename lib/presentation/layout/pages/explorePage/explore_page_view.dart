import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/presentation/layout/manager/explore_cubit/explore_state.dart';
import 'package:online_exam_app/presentation/layout/manager/explore_cubit/explore_view_model.dart';

import '../../../../core/widget/custom_diaolg.dart';
import '../../../../di/injectable_initializer.dart';
import '../../widget/subject_widget.dart';

class ExplorePageView extends StatelessWidget {
  const ExplorePageView({super.key});

  @override
  Widget build(BuildContext context) {
    ExploreViewModel viewModel = getIt.get<ExploreViewModel>();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Survey",
                style: getTextStyle(FontSize.s20, FontWeightManager.medium,
                    ColorsManager.primaryColor),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: ColorsManager.greyColor, width: 1),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: "search",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "Browse by subject",
                style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                    ColorsManager.blackColor),
              ),
              SizedBox(
                height: 24.h,
              ),
              BlocConsumer<ExploreViewModel, ExploreState>(
                bloc: viewModel..doIntent(GetAllSubjectIntent()),
                listener: (context, state) {
                  if (state is ExploreLoading) {
                    EasyLoading.show();
                  } else if (state is ExploreSuccess) {
                    EasyLoading.dismiss();
                  } else if (state is ExploreError) {
                    EasyLoading.dismiss();
                    DialogUtils.showMessage(
                      context: context,
                      message: state.errMessage,
                      title: "Error",
                      postActionName: "Ok",
                      negativeActionName: "Cancel",
                      postAction: () {
                        viewModel.doIntent(GetAllSubjectIntent());
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ExploreLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ExploreSuccess) {
                    return Column(
                      children: [
                        SubjectWidget(
                            subjects: state.subject?.subjects ?? []),
                        SizedBox(
                          height: 50.h,
                        )
                      ],
                    );
                  } else if (state is ExploreError) {
                    return Center(child: Text("Error: ${state.errMessage}"));
                  }
                  return const SizedBox.shrink();
                },
              ),
          ],
                  ),
        ),
    ));
  }
}
