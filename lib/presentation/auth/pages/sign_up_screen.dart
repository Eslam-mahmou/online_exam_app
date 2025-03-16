//sign_up_screen
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/core/widget/custom_elevated_button.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/presentation/auth/manager/signUP_cubit/signup_state.dart';
import 'package:online_exam_app/presentation/auth/manager/signUP_cubit/signup_view_model.dart';

import '../../../core/Utils/font_manager.dart';
import '../../../core/Utils/style_manager.dart';
import '../../../di/injectable_initializer.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpViewModel viewModel = getIt.get<SignUpViewModel>();
    return BlocProvider(
        create: (context) => viewModel,
        child: Scaffold(
            appBar: AppBar(
          title: const Text("Sign up"),
        ),
            body: BlocConsumer<SignUpViewModel, SignUpState>(
              bloc: viewModel..doIntent,
              listener: (context, state) {
                if (state is ErrorSignUpState) {
                  EasyLoading.dismiss();
                  DialogUtils.showMessage(context: context, message: state.errMessage.toString(),
                  title: "Error",
                  postActionName: "Cancel");
                }
                if (state is SuccessSignUpState) {
                  EasyLoading.dismiss();
                  Navigator.pushNamed(context, PagesRoutes.layoutScreen);
                }
                if (state is SignUpLoadingState) {
                  EasyLoading.show();
                }
              },
              builder: (context, state) => Form(
                key: viewModel.formSignUpKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFromField(
                        controller: viewModel.userNameController,
                        labelText: "User Name",
                        hinText: "Enter your user name",
                        validator: AppValidate.validateUserName,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextFromField(
                                  controller: viewModel.firstNameController,
                                  labelText: "First Name",
                                  hinText: "Enter first name",
                                  validator: AppValidate.validateFullName)),
                          Expanded(
                              child: CustomTextFromField(
                                  controller: viewModel.lastNameController,
                                  labelText: "Last Name",
                                  hinText: "Enter last name",
                                  validator: AppValidate.validateFullName)),
                        ],
                      ),
                      CustomTextFromField(
                          controller: viewModel.emailController,
                          labelText: "Email",
                          hinText: "Enter your email",
                          validator: AppValidate.validateEmail),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextFromField(
                            controller: viewModel.passwordController,
                            validator: AppValidate.validatePassword,
                            labelText: "Password",
                            hinText: "Password",
                          )),
                          Expanded(
                              child: CustomTextFromField(
                            controller: viewModel.rePasswordController,
                            validator: AppValidate.validatePassword,
                            labelText: "Confirm password",
                            hinText: "Confirm",
                          )),
                        ],
                      ),
                      CustomTextFromField(
                        controller: viewModel.phoneController,
                        validator: AppValidate.validateMobile,
                        labelText: "Phone number",
                        hinText: "Enter phone number",
                        // validator: AppValidate.validateMobile
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomElevatedButton(
                        label: 'Signup',
                        onTap: () {
                          if (viewModel.formSignUpKey.currentState!
                              .validate()) {
                            viewModel.doIntent(SignUpClickedIntent());
                          }
                        },
                        backgroundColor: ColorsManager.primaryColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: getTextStyle(
                                FontSize.s16,
                                FontWeightManager.regular,
                                ColorsManager.blackColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Login",
                                style: getTextStyle(
                                    FontSize.s16,
                                    FontWeightManager.regular,
                                    ColorsManager.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        ColorsManager.primaryColor)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}

