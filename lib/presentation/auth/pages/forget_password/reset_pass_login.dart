import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/auth/manager/reset_password_cubit/reset_password_state.dart';
import 'package:online_exam_app/presentation/auth/manager/reset_password_cubit/reset_password_view_model.dart';

import '../../../../core/Utils/colors_manager.dart';
import '../../../../core/widget/custom_diaolg.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/custom_text_from_field.dart';

class ResetPasswordLogin extends StatelessWidget {
  const ResetPasswordLogin({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordViewModel viewModel = getIt.get<ResetPasswordViewModel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Password"),
        ),
        body: BlocListener<ResetPasswordViewModel, ResetPasswordState>(
          listener: (context, state) {
            if (state is LoadingResetPasswordState) {
              EasyLoading.show();
            }
            if (state is SuccessResetPasswordState) {
              EasyLoading.dismiss();
              Navigator.pushNamed(context, PagesRoutes.loginScreen);
            }
            if (state is ErrorResetPasswordState) {
              EasyLoading.dismiss();
              DialogUtils.showMessage(
                  title: "Error",
                  context: context,
                  message: state.errorMessage.toString(),
                  postActionName: "Ok");
            }
          },
          child: Form(
            key: viewModel.formResetPasswordKey,
            child: Column(
              children: [
                Text(
                  "Reset password",
                  style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                      ColorsManager.blackColor),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Password must not be empty and must contain\n6 characters with upper case letter and one\nnumber at least",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    FontSize.s14,
                    FontWeightManager.regular,
                    ColorsManager.greyColor,
                    height: 1.4.h,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextFromField(
                  labelText: "New password",
                  hinText: "Enter your password",
                  controller: viewModel.newPassword,
                  validator: AppValidate.validatePassword,
                ),
                CustomTextFromField(
                  labelText: "Confirm password",
                  hinText: "Confirm password",
                  controller: viewModel.confirmPassword,
                  validator: viewModel.validateConfirmPassword,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevatedButton(
                  label: 'Continue',
                  onTap: () {
                    viewModel.doIntent(ResetClickedIntent());
                  },
                  backgroundColor: ColorsManager.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
