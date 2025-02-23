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

/// Work one with stateful widget
// class ProfileTab extends StatefulWidget {
//   const ProfileTab({super.key});
//
//   @override
//   State<ProfileTab> createState() => _ProfileTabState();
// }
// class _ProfileTabState extends State<ProfileTab> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   late ProfileTabViewModel viewModel;
//
//   @override
//   void initState() {
//     super.initState();
//     viewModel = getIt.get<ProfileTabViewModel>();
//     viewModel.doIntent(GetUserInfoIntent());
//   }
//
//   @override
//   void dispose() {
//     usernameController.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProfileTabViewModel, ProfileTabState>(
//       bloc: viewModel,
//       listener: (context, state) {
//         if (state is ProfileTabLoading) {
//           EasyLoading.show();
//         } else if (state is ProfileTabSuccess) {
//           final user = state.user?.user;
//           if (user != null) {
//             usernameController.text = user.username ?? "";
//             firstNameController.text = user.firstName ?? "";
//             lastNameController.text = user.lastName ?? "";
//             emailController.text = user.email ?? "";
//             phoneController.text = user.phone ?? "";
//           }
//           EasyLoading.dismiss();
//         } else if (state is ProfileTabError) {
//           EasyLoading.dismiss();
//           DialogUtils.showMessage(
//             context: context,
//             message: state.errMessage,
//             title: "Error",
//             postActionName: "Ok",
//             postAction: () {
//               viewModel.doIntent(GetUserInfoIntent());
//             },
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is ProfileTabLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is ProfileTabSuccess) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text("Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 16),
//                 CustomTextFromField(
//                   controller: usernameController,
//                   validator: AppValidate.validateUserName,
//                   labelText: "Username",
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextFromField(
//                         controller: firstNameController,
//                         validator: AppValidate.validateFullName,
//                         labelText: "First Name",
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: CustomTextFromField(
//                         controller: lastNameController,
//                         validator: AppValidate.validateFullName,
//                         labelText: "Last Name",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFromField(
//                   controller: emailController,
//                   validator: AppValidate.validateEmail,
//                   labelText: "Email",
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFromField(
//                   controller: phoneController,
//                   validator: AppValidate.validateMobile,
//                   labelText: "Phone Number",
//                 ),
//                 const SizedBox(height: 16),
//                 CustomElevatedButton(
//                   label: "Update",
//                   onTap: () {
//                     final updatedUser = UserDataEntity(
//                       username: usernameController.text.trim(),
//                       firstName: firstNameController.text.trim(),
//                       lastName: lastNameController.text.trim(),
//                       email: emailController.text.trim(),
//                       phone: phoneController.text.trim(),
//                     );
//                     viewModel.doIntent(EditProfileClickedIntent(updatedUser));
//                   },
//                 ),
//               ],
//             ),
//           );
//         } else if (state is ProfileTabError) {
//           return Center(child: Text("Error: ${state.errMessage}"));
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
