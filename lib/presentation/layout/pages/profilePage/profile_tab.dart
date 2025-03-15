import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/services/shared_preference_services.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/core/widget/custom_diaolg.dart';
import 'package:online_exam_app/core/widget/custom_elevated_button.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/presentation/layout/manager/profile_tab_cubit/profile_tab_state.dart';
import 'package:online_exam_app/presentation/layout/manager/profile_tab_cubit/profile_tab_view_model.dart';
import 'package:online_exam_app/presentation/layout/widget/custom_picker_image.dart';

import '../../../../di/injectable_initializer.dart';
import '../../../../domain/entity/profile_user_entity.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProfileTabViewModel viewModel = getIt.get<ProfileTabViewModel>();

    return BlocConsumer<ProfileTabViewModel, ProfileTabState>(
      bloc: viewModel..doIntent(GetUserInfoIntent()),
      listener: (context, state) {
        if (state is ProfileTabLoading) {
          EasyLoading.show();
        } else if (state is ProfileTabSuccess) {
          usernameController.text = state.user?.user?.username ?? "";
          firstNameController.text = state.user?.user?.firstName ?? "";
          lastNameController.text = state.user?.user?.lastName ?? "";
          emailController.text = state.user?.user?.email ?? "";
          phoneController.text = state.user?.user?.phone ?? "";
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
              viewModel.doIntent(GetUserInfoIntent());
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        style: getTextStyle(FontSize.s20,
                            FontWeightManager.medium, ColorsManager.blackColor),
                      ),
                      IconButton(
                          onPressed: () {
                            SharedPreferenceServices.deleteData(
                                AppConstants.token);
                            SharedPreferenceServices.deleteData(
                                AppConstants.isRemember);
                            Navigator.pushNamed(
                                context, PagesRoutes.loginScreen);
                          },
                        icon: const Icon(Icons.logout),
                        color: ColorsManager.redColor,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                const CustomPickerImage(),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  controller: usernameController,
                  validator: AppValidate.validateUserName,
                  labelText: "User name",
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFromField(
                        controller: firstNameController,
                        validator: AppValidate.validateFullName,
                        labelText: "First name",
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CustomTextFromField(
                        controller: lastNameController,
                        validator: AppValidate.validateFullName,
                        labelText: "Last name",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomTextFromField(
                  controller: emailController,
                  validator: AppValidate.validateEmail,
                  labelText: "Email",
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
                  controller: phoneController,
                  validator: AppValidate.validateMobile,
                  labelText: "Phone number",
                ),
                SizedBox(height: 16.h),
                CustomElevatedButton(
                  label: "Update",
                  onTap: () {
                    final updatedUser = UserDataEntity(
                      username: usernameController.text.trim(),
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                      email: emailController.text.trim(),
                      phone: phoneController.text.trim(),
                    );
                    viewModel.doIntent(EditProfileClickedIntent(updatedUser));
                  },
                )
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
