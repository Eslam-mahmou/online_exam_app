import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_elevated_button.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/presentation/auth/manager/edit%20profile_cubit/edit_profile_state.dart';
import 'package:online_exam_app/presentation/auth/manager/edit%20profile_cubit/edit_profile_view_model.dart';
import 'package:online_exam_app/presentation/layout/widget/custom_picker_image.dart';

import '../../../../di/injectable_initializer.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = getIt.get<EditProfileViewModel>();

    return BlocProvider(
        create: (context) => viewModel,
        child: BlocConsumer<EditProfileViewModel, EditProfileState>(
          bloc: viewModel..doIntent,
          listener: (context, state) {
            if (state is ErrorEditProfileState) {
              EasyLoading.dismiss();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: Text(state.errMessage.toString()),
                  );
                },
              );
            }
            if (state is SuccessEditProfileState) {
              EasyLoading.dismiss();
              Navigator.pushNamed(context, PagesRoutes.layoutScreen);
            }
            if (state is EditProfileLoadingState) {
              EasyLoading.show();
            }
          },
          builder: (BuildContext context, state) {
            return SingleChildScrollView(
              child: Form(
                key: viewModel.formEditProfileKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 45.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Profile",
                        style: getTextStyle(FontSize.s20,
                            FontWeightManager.medium, ColorsManager.blackColor),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const CustomPickerImage(),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFromField(
                      validator: AppValidate.validateUserName,
                      labelText: "User name",
                      controller: viewModel.userNameController,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextFromField(
                          validator: AppValidate.validateFullName,
                          controller: viewModel.firstNameController,
                          labelText: "First name",
                        )),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                            child: CustomTextFromField(
                          validator: AppValidate.validateFullName,
                          controller: viewModel.lastNameController,
                          labelText: "Last name",
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFromField(
                      validator: AppValidate.validateEmail,
                      controller: viewModel.emailController,
                      labelText: "Email",
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFromField(
                      validator: AppValidate.validatePassword,
                      controller: viewModel.passwordNameController,
                      labelText: "Password",
                      suffix: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PagesRoutes.resetPassword);
                          },
                          child: Text(
                            "Change",
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                                FontSize.s12,
                                FontWeightManager.semiBold,
                                ColorsManager.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFromField(
                      validator: AppValidate.validateMobile,
                      controller: viewModel.phoneController,
                      labelText: "Phone number",
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomElevatedButton(
                      label: "Update",
                      onTap: () {
                        if (viewModel.formEditProfileKey.currentState!
                            .validate()) {
                          viewModel.doIntent(EditProfileClickedIntent());
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
