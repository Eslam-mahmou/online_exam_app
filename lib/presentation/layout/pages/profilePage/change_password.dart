import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/utils/colors_manager.dart';
import 'package:online_exam_app/core/widget/custom_elevated_button.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';

import '../../../../di/injectable_initializer.dart';
import '../../manager/change_password_cubit/change_password_state.dart';
import '../../manager/change_password_cubit/change_password_view_model.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordViewModel viewModel = getIt.get<ChangePasswordViewModel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<ChangePasswordViewModel, ChangePasswordState>(
        listener: (context, state) {
          if (state is SuccessChangePasswordState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Successful change password")),
            );
            Navigator.pushNamed(context, PagesRoutes.loginScreen);
          } else if (state is ErrorChangePasswordState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Change Password")),
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: viewModel.formResetPasswordKey,
                child: Column(
                  children: [
                    CustomTextFromField(
                      controller: viewModel.oldPassword,
                      labelText: "old password",
                      hinText: "old password",
                      validator: AppValidate.validatePassword,
                      obscureText: true,
                    ),
                    CustomTextFromField(
                      controller: viewModel.newPassword,
                      labelText: "New password",
                      hinText: "New password",
                      validator: AppValidate.validatePassword,
                      obscureText: true,
                    ),
                    CustomTextFromField(
                      controller: viewModel.rePassword,
                      labelText: "Confirm password",
                      hinText: "Confirm password",
                      validator: (value) => value == viewModel.newPassword.text
                          ? null
                          : "Passwords do not match",
                      obscureText: true,
                    ),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      label: state is LoadingChangePasswordState
                          ? "Loading..."
                          : "Updating...",
                      onTap: () {
                        if (state is! LoadingChangePasswordState) {
                          viewModel.doIntent(ResetClickedIntent());
                        }
                      },
                      backgroundColor: ColorsManager.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
