import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/auth/manager/verify_email_cubit/verify_email_state.dart';
import 'package:online_exam_app/presentation/auth/manager/verify_email_cubit/verify_email_vew_model.dart';
import 'package:online_exam_app/presentation/auth/widget/custom_verify_text_field.dart';
import '../../../../core/Utils/colors_manager.dart';
import '../../../../core/Utils/font_manager.dart';
import '../../../../core/Utils/style_manager.dart';
import '../../../../core/widget/custom_elevated_button.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    VerifyEmailVewModel vewModel = getIt.get<VerifyEmailVewModel>();
    return BlocProvider(
      create: (context) => vewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Password"),
        ),
        body: BlocListener<VerifyEmailVewModel, VerifyEmailState>(
          listener: (context, state) {
            if (state is LoadingVerifyEmailState) {
              EasyLoading.show();
            }
            if (state is SuccessVerifyEmailState) {
              EasyLoading.dismiss();
              vewModel.doIntent(DisposeEmailIntent());
              Navigator.pushNamed(context, PagesRoutes.resetPassLogin);
            }
            if (state is ErrorVerifyEmailState) {
              EasyLoading.dismiss();
              DialogUtils.showMessage(
                  title: "Error",
                  context: context,
                  message: state.errMessage.toString(),
                  postActionName: "Ok");
            }
            if (state is LoadingResendEmailState) {
              EasyLoading.show();
            }
            if (state is SuccessResendEmailState) {
              EasyLoading.dismiss();
              vewModel.doIntent(DisposeEmailIntent());
            }
            if (state is ErrorResendEmailState) {
              EasyLoading.dismiss();
              DialogUtils.showMessage(
                title: "Error",
                context: context,
                message: state.errMessage.toString(),
                postActionName: "Ok",
                postAction: () {
                  Navigator.pop(context);
                  vewModel.doIntent(ResendClickedIntent());
                },
              );
            }
          },
          child: Form(
            key: vewModel.formVerifyKey,
            child: Column(
              children: [
                Text(
                  "Email verification",
                  style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                      ColorsManager.blackColor),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Please enter your code that send to your\n email address",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 16.w,
                    ),
                    CustomVerifyTextField(
                      controller: vewModel.code1,
                      focusNode: vewModel.focusNode1,
                      onChanged: (value) => vewModel.onChanged(
                          context, value, vewModel.focusNode2),
                    ),
                    CustomVerifyTextField(
                      controller: vewModel.code2,
                      focusNode: vewModel.focusNode2,
                      onChanged: (value) => vewModel.onChanged(
                          context, value, vewModel.focusNode3),
                    ),
                    CustomVerifyTextField(
                      controller: vewModel.code3,
                      focusNode: vewModel.focusNode3,
                      onChanged: (value) => vewModel.onChanged(
                          context, value, vewModel.focusNode4),
                    ),
                    CustomVerifyTextField(
                      controller: vewModel.code4,
                      focusNode: vewModel.focusNode4,
                      onChanged: (value) => vewModel.onChanged(
                          context, value, vewModel.focusNode5),
                    ),
                    CustomVerifyTextField(
                      controller: vewModel.code5,
                      focusNode: vewModel.focusNode5,
                      onChanged: (value) => vewModel.onChanged(
                          context, value, vewModel.focusNode6),
                    ),
                    CustomVerifyTextField(
                      controller: vewModel.code6,
                      focusNode: vewModel.focusNode6,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code?",
                      style: getTextStyle(FontSize.s16,
                          FontWeightManager.regular, ColorsManager.blackColor),
                    ),
                    TextButton(
                      onPressed: () {
                        vewModel.doIntent(ResendClickedIntent());
                      },
                      child: Text("Resend",
                          style: getTextStyle(
                              FontSize.s16,
                              FontWeightManager.regular,
                              ColorsManager.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsManager.primaryColor)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevatedButton(
                  label: 'Continue',
                  onTap: () {
                    vewModel.doIntent(ContinueClickedIntent());
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
