import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/core/widget/custom_elevated_button.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/presentation/layout/manager/profile_tab_cubit/profile_tab_state.dart';
import 'package:online_exam_app/presentation/layout/manager/profile_tab_cubit/profile_tab_view_model.dart';
import 'package:online_exam_app/presentation/layout/widget/custom_picker_image.dart';

import '../../../../di/injectable_initializer.dart';
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileTabViewModel viewModel = getIt.get<ProfileTabViewModel>();

    return BlocConsumer<ProfileTabViewModel, ProfileTabState>(
      bloc: viewModel..doIntent(GetUserInfoIntent(viewModel.user?.user)),
      listener: (context, state) {
        if (state is ProfileTabLoading) {
          EasyLoading.show();
        } else if (state is ProfileTabSuccess) {
          log(viewModel.user!.user!.firstName.toString());
          EasyLoading.dismiss();
        } else if (state is ProfileTabError) {
          EasyLoading.dismiss();
          DialogUtils.showMessage(
            context: context,
            message: state.errMessage,
            title: "Error",
            postActionName: "Ok",
            negativeActionName: "Cancel",
            postAction: () {
              viewModel.doIntent(GetUserInfoIntent(viewModel.user?.user));
            },
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileTabLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileTabSuccess) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 45.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Profile",
                    style: getTextStyle(FontSize.s20, FontWeightManager.medium,
                        ColorsManager.blackColor),
                  ),
                ),
                SizedBox(height: 16.h),
                const CustomPickerImage(),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  initialValue: state.user?.user?.username ?? "",
                  validator: AppValidate.validateUserName,
                  labelText: "User name",
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFromField(
                        initialValue: state.user?.user?.firstName ?? "",
                        validator: AppValidate.validateFullName,
                        labelText: "First name",
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CustomTextFromField(
                        initialValue: state.user?.user?.lastName ?? "",
                        validator: AppValidate.validateFullName,
                        labelText: "Last name",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  initialValue: state.user?.user?.email ?? "@gmail.com",
                  validator: AppValidate.validateEmail,
                  labelText: "email",
                ),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  obscureText: true,
                  validator: AppValidate.validatePassword,
                  labelText: "Password",
                  suffix: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PagesRoutes.resetPassword);
                    },
                    child: Text(
                      "Change",
                      textAlign: TextAlign.center,
                      style: getTextStyle(
                          FontSize.s12,
                          FontWeightManager.semiBold,
                          ColorsManager.primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  initialValue: state.user?.user?.phone ?? "",
                  validator: AppValidate.validateMobile,
                  labelText: "Phone number",
                ),
                SizedBox(height: 16.h),
                CustomElevatedButton(label: "Update", onTap: () {})
              ],
            ),
          );
        } else if (state is ProfileTabError) {
          return Center(child: Text("Error: ${state.errMessage}"));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     ProfileTabViewModel viewModel = getIt.get<ProfileTabViewModel>();
//     return BlocListener<ProfileTabViewModel, ProfileTabState>(
//         bloc: viewModel..doIntent(GetUserInfoIntent(viewModel.user?.user)),
//         listener: (context, state) {
//           if (state is ProfileTabLoading) {
//             EasyLoading.show();
//           }
//           if (state is ProfileTabSuccess) {
//             log(viewModel.user!.user!.firstName.toString());
//             EasyLoading.dismiss();
//           }
//           if (state is ProfileTabError) {
//             EasyLoading.dismiss();
//             DialogUtils.showMessage(
//               context: context,
//               message: state.errMessage,
//               title: "Error",
//               postActionName: "Ok",
//               negativeActionName: "Cancel",
//               postAction: () {
//                 viewModel.doIntent(GetUserInfoIntent(viewModel.user?.user));
//               },
//             );
//           }
//         },
//         child: SingleChildScrollView(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//               SizedBox(height: 45.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//                 child: Text(
//                   "Profile",
//                   style: getTextStyle(FontSize.s20, FontWeightManager.medium,
//                       ColorsManager.blackColor),
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               const CustomPickerImage(),
//               SizedBox(height: 16.h),
//               CustomTextFromField(
//                 initialValue: viewModel.user?.user?.username ?? "nothing",
//                 validator: AppValidate.validateUserName,
//                 labelText: "User name",
//               ),
//               SizedBox(height: 16.h),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextFromField(
//                       validator: AppValidate.validateFullName,
//                       labelText: "First name",
//                     ),
//                   ),
//                   SizedBox(width: 4.w),
//                   Expanded(
//                     child: CustomTextFromField(
//                       labelText: "Last name",
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               CustomTextFromField(
//                 initialValue: viewModel.user?.user?.email??"",
//                 validator: AppValidate.validateEmail,
//                 labelText: viewModel.user?.user?.email.toString()??"",
//               ),
//               SizedBox(height: 16.h),
//               CustomTextFromField(
//                 obscureText: true,
//                 validator: AppValidate.validatePassword,
//                 labelText: "Password",
//                 suffix: TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, PagesRoutes.resetPassword);
//                   },
//                   child: Text(
//                     "Change",
//                     textAlign: TextAlign.center,
//                     style: getTextStyle(FontSize.s12,
//                         FontWeightManager.semiBold, ColorsManager.primaryColor),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               CustomTextFromField(
//                 validator: AppValidate.validateMobile,
//                 labelText: "Phone number",
//               ),
//               SizedBox(height: 16.h),
//               CustomElevatedButton(label: "Update", onTap: () {})
//             ])));
//   }
// }
