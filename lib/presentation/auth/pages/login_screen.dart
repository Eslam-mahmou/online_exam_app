import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/services/shared_preference_services.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/di/injectable_initializer.dart';
import 'package:online_exam_app/presentation/auth/manager/login_cubit/login_state.dart';
import 'package:online_exam_app/presentation/auth/manager/login_cubit/login_view_model.dart';
import '../../../core/Utils/style_manager.dart';
import '../../../core/widget/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = getIt.get<LoginViewModel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
          backgroundColor: ColorsManager.whiteColor,
          appBar: AppBar(
            title: Text(
              "Login",
              textAlign: TextAlign.start,
              style: getTextStyle(FontSize.s20, FontWeightManager.medium,
                  ColorsManager.blackColor),
            ),
            backgroundColor: ColorsManager.whiteColor,
            elevation: 0,
          ),
          body: BlocListener<LoginViewModel, LoginState>(
              listener: (context, state) {
                if (state is LoginLoadingState) {
                  EasyLoading.show();
                }
                if (state is ErrorLoginState) {
                  EasyLoading.dismiss();
                  DialogUtils.showMessage(
                    context: context,
                    message: state.errMessage.toString(),
                    title: "Error",
                    postActionName: "cancel",
                  );
                }
                if (state is SuccessLoginState) {
                  EasyLoading.dismiss();
                  SharedPreferenceServices.saveData(AppConstants.isRemember, viewModel.isRememberMe);
                  Navigator.pushReplacementNamed(context, PagesRoutes.layoutScreen);
                }
              },
              child: Form(
                  key: viewModel.formLoginKey,
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      CustomTextFromField(
                          keyboardType: TextInputType.emailAddress,
                          controller: viewModel.emailController,
                          validator: AppValidate.validateEmail,
                          labelText: "Email",
                          hinText: "Enter your email"),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomTextFromField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: viewModel.passwordController,
                          validator: AppValidate.validatePassword,
                          labelText: "Password",
                          hinText: "Enter your password"),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          StatefulBuilder(builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return Checkbox(
                              value: viewModel.isRememberMe,
                              onChanged: (value) {
                                setState(() {
                                  viewModel.isRememberMe =
                                      !viewModel.isRememberMe;
                                });
                                debugPrint(viewModel.isRememberMe.toString());
                              },
                              activeColor: ColorsManager.primaryColor,
                            );
                          }),
                          Text(
                            "Remember me",
                            style: getTextStyle(
                                FontSize.s12,
                                FontWeightManager.regular,
                                ColorsManager.blackColor),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 16.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PagesRoutes.forgetPassword);
                              },
                              child: Text(
                                "Forget password?",
                                style: getTextStyle(
                                    FontSize.s12,
                                    FontWeightManager.regular,
                                    ColorsManager.blackColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      CustomElevatedButton(
                        label: "Login",
                        onTap: () {
                          if (viewModel.formLoginKey.currentState!.validate()) {
                            viewModel.doIntent(LoginClickedIntent());
                          }
                        },
                        backgroundColor: ColorsManager.primaryColor,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: getTextStyle(
                                FontSize.s16,
                                FontWeightManager.regular,
                                ColorsManager.blackColor),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PagesRoutes.signUpScreen);
                            },
                            child: Text("Sign up",
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
                  ))))),
    );
  }
}
