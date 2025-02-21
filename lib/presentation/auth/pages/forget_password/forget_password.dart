import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/auth/manager/forget_password_cubit/forget_password_state.dart';
import 'package:online_exam_app/presentation/auth/manager/forget_password_cubit/forget_password_view_model.dart';

import '../../../../core/Utils/colors_manager.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/custom_text_from_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordViewModel viewModel = getIt.get<ForgetPasswordViewModel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Password"),
        ),
        body: BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
          bloc: viewModel..doIntent,
          listener: (context, state) {
            if (state is LoadingForgetPasswordState) {
              EasyLoading.show();
            } else if (state is ErrorForgetPasswordState) {
              EasyLoading.dismiss();
              DialogUtils.showMessage(context: context, message: state.errorMessage.toString(),
              title: "Error",
              postActionName: "Ok");
            } else if (state is SuccessForgetPasswordState) {
              EasyLoading.dismiss();
              Navigator.pushNamed(context, PagesRoutes.emailVerification,arguments: viewModel.email);
            }
          },
          child: Form(
            key: viewModel.formForgetKey,
            child: Column(
              children: [
                Text(
                  "Forget Password",
                  style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                      ColorsManager.blackColor),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Please enter your email associated to\n your account",
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
                  labelText: "Email",
                  hinText: "Enter your email",
                  controller: viewModel.email,
                  validator: AppValidate.validateEmail,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevatedButton(
                  label: 'Continue',
                  onTap: () {
                    viewModel.doIntent(ContinueClickedIntent());
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
